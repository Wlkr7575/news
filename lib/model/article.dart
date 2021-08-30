import 'package:news/model/source.dart';

class ArticleModel{
  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String img;
  final String date;
  final String content;
  ArticleModel({this.source,this.title,this.url,this.img,this.date,this.author,this.content,this.description});
  ArticleModel.fromJson(Map<String,dynamic> json)
  :
  source = SourceModel.fromJson(json["source"]),
  author = json["author"],
  title = json["title"],
  description = json["description"],
  url = json["url"],
  img = json["urlToImage"],
  date = json["publishedAt"],
  content = json["content"];
}