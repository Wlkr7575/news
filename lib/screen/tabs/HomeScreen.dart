import 'package:flutter/material.dart';
import 'package:news/widget/Headline_Slider.dart';
import 'package:news/widget/hot_news.dart';
import 'package:news/widget/top_channels.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlinSlider(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Top channels",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17.0),),
        ),
        TopChannelsWidget(),
        Padding(padding: EdgeInsets.all(10.0),
          child: Text("Hot News",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17.0),),
        ),
        HotNewsWidget()
      ],
    );
  }
}
