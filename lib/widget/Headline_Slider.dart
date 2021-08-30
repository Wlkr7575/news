import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/getTopHeadlines_bloc.dart';
import 'package:news/element/error_element.dart';
import 'package:news/model/article.dart';
import 'package:news/model/article_response.dart';
import 'package:news/element/loader_element.dart';
import 'package:news/screen/news_detail.dart';
import 'package:timeago/timeago.dart' as timeago;
class HeadlinSlider extends StatefulWidget {
  @override
  _HeadlinSliderState createState() => _HeadlinSliderState();
}

class _HeadlinSliderState extends State<HeadlinSlider> {
  @override
  void initState(){
    super.initState();
    getTopHeadlinesBloc..getHeadlines();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
        builder: (context,AsyncSnapshot<ArticleResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error !=null &&snapshot.data.error.length>0){
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHeadlinesSlider(snapshot.data);
        }else if(snapshot.hasError){
          return buildErrorWidget(snapshot.error);
        }else{
          return buildLoadingWidget();
        }
        }
    );
  }
  Widget _buildHeadlinesSlider(ArticleResponse data){
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false,
          height: 200.0,
          viewportFraction: 0.9
        ),
        items: getExpenseSlider(articles),
      ),
    );
  }
  getExpenseSlider(List<ArticleModel> articles){
    return articles.map((article) => GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetail(
                  article: article,
                )));
      },
      child: Container(
        padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: article.img == null ? AssetImage("assets/img/placeholder.png"):NetworkImage(article.img)
                )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.white.withOpacity(0.0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1,0.9]
                ),
              ),
            ),
            Positioned(
              bottom: 30.0,
              child: Container(
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                width: 250.0,
                child: Column(
                  children: [
                    Text(article.title,style: TextStyle(height: 1.5,color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12.0),)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
                left: 10.0,
                child: Text(
                  article.source.name,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 9.0
                  ),
                )
            ),
            Positioned(
              bottom: 10.0,
                top: 10.0,
                child: Text(timeAgo(DateTime.parse(article.date)),
                  style: TextStyle(color: Colors.white54,fontSize: 9.0),)
            )
          ],
        ),
      ),
    )
    ).toList();
  }
  String timeAgo(DateTime date){
    return timeago.format(date,allowFromNow: true,locale: 'en');
  }
}
