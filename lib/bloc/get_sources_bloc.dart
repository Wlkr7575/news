import 'package:news/model/SourceReponse.dart';
import 'package:news/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourcesBloc {
   final NewsResponsitory _repository = NewsResponsitory();
   final BehaviorSubject<SourceResponse> _subject =
   BehaviorSubject<SourceResponse>();

   getSources() async {
      SourceResponse response = await _repository.getSources();
      _subject.sink.add(response);
   }

   dispose() {
      _subject.close();
   }

   BehaviorSubject<SourceResponse> get subject => _subject;

}
final getSourcesBloc = GetSourcesBloc();