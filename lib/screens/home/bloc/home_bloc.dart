import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {

  final _today$ = BehaviorSubject<DateTime>();
  Stream<DateTime> get todayDateTime$ => _today$.stream;
  Sink<DateTime> get sinkTodayDateTime$ => _today$.sink;

  final _yesterday$ = BehaviorSubject<DateTime>();
  Stream<DateTime> get yesterdayDateTime$ => _yesterday$.stream;
  Sink<DateTime> get sinkYesterdayDateTime$ => _yesterday$.sink;
  var now = DateTime.now();

  HomeBloc() {
    getTodayDateTime();
    getYesterdayDateTime();
  }

  Future<DateTime> getTodayDateTime() async {
    var today = DateTime(now.year, now.month, now.day);
    _today$.sink.add(today);
    print(today.toString());
    return today;
  }

  Future<DateTime> getYesterdayDateTime() async {
    var yesterday = DateTime(now.year, now.month, now.day - 1);
    _yesterday$.sink.add(yesterday);
    print(yesterday.toString());
    return yesterday;
  }

  @override
  void dispose() {
    super.dispose();
    _today$.close();
    _yesterday$.close();
  }
}