import 'package:rxdart/rxdart.dart';
import '../service/api_repository.dart';
import '../utils/logger.dart';

class BaseBloc extends Object {

  final repository = AppRepository();

  int get defaultFetchLimit => 10;
  int get defaultFetchLimitChatMessage => 20;
  bool isApiCallDone = false;

  String getValue(BehaviorSubject<String> subject) {
    if(subject.hasValue) return subject.value ?? "";
    return '';
  }

  void dispose() {
    Logger().v('------------------- ${this} Dispose ------------------- ');
  }

}