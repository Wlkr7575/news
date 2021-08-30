import 'package:dio/dio.dart';
import 'package:news/model/SourceReponse.dart';
import 'package:news/model/article_response.dart';

class NewsResponsitory{
  static String mainUrl = "https://newsapi.org/v2/";
  final String apiKey = "6ba139e1588143ccaf25cb45fab9fded";

  final Dio _dio = Dio();

  var getSourceUrl = "$mainUrl/sources";
  var getTopHeadLineUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future<SourceResponse> getSources()async{
    var params = {
      "apiKey" : apiKey,
      "language" : "en",
      "country" : "us"
    };
    try{
      Response response = await _dio.get(getSourceUrl,queryParameters: params);
      return SourceResponse.fromJson(response.data);
    }catch(error,stacktrace){
      print("Exception occured:$error stackTrace:$stacktrace");
      return SourceResponse.withError(error);
    }
  }
  Future<ArticleResponse> getTopHeadLines()async{
    var params = {
      "apiKey" : apiKey,
      "country" : "us"
    };
    try{
      Response response = await _dio.get(getTopHeadLineUrl,queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error){
      return ArticleResponse.withError(error);
    }
  }
  Future<ArticleResponse> getHotNews()async{
    var params = {
      "apiKey" : apiKey,
      "q":"apple",
      "sortBy" : "popularity"
    };
    try{
      Response response = await _dio.get(everythingUrl,queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error){
      return ArticleResponse.withError(error);
    }
  }
  Future<ArticleResponse> getSourceNews(String sourceId)async{
    var params = {
      "apiKey" : apiKey,
      "sources":sourceId,
    };
    try{
      Response response = await _dio.get(getTopHeadLineUrl,queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error){
      return ArticleResponse.withError(error);
    }
  }
  Future<ArticleResponse> search(String value) async {
    var params = {
      "apiKey": apiKey,
      "q" : value,
      "sortBy": "popularity"};
    try {
      Response response = await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }
}