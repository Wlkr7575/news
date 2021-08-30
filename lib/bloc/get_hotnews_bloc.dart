import 'package:news/model/article_response.dart';
import 'package:news/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetHotNewsBloc{
  final NewsResponsitory _responsitory  =NewsResponsitory();
  final BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();
  getHotNews()async{
    ArticleResponse response =  await _responsitory.getHotNews();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<ArticleResponse> get subject => _subject;
}
final getHotNewsBloc = GetHotNewsBloc();