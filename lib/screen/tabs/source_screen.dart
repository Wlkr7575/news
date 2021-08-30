import 'package:flutter/material.dart';
import 'package:news/bloc/get_sources_bloc.dart';
import 'package:news/element/error_element.dart';
import 'package:news/element/loader_element.dart';
import 'package:news/model/SourceReponse.dart';
import 'package:news/model/source.dart';
import 'package:news/screen/source_detail.dart';
class SourceScreen extends StatefulWidget {
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSourcesBloc..getSources();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
        stream: getSourcesBloc.subject.stream,
        builder: (context,AsyncSnapshot<SourceResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data.error !=null &&snapshot.data.error.length>0){
              return buildErrorWidget(snapshot.data.error);
            }
            return _buildSources(snapshot.data);
          }else if(snapshot.hasError){
            return buildErrorWidget(snapshot.error);
          }else{
            return buildLoadingWidget();
          }
        }
    );
  }
  _buildSources(SourceResponse data){
    List<SourceModel> source = data.sources;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 0.86),
        itemCount: source.length,
        itemBuilder: (context,index){
          return Padding(
              padding: EdgeInsets.only(left: 5.0,right: 5.0,top: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SourceDetail(
                          source: source[index],
                        )));
              },
              child: Container(
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[100],
                    blurRadius: 5.0,
                      spreadRadius: 2.0,
                      offset: Offset(1.0, 1.0)
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(tag: source[index].id,child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/logos/${source[index].id}.png"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),),
                    Container(
                      padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0,bottom: 15.0),
                      child: Text(
                          source[index].name,
                        textAlign: TextAlign.center,
                          maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
