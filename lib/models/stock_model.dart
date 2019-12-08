import 'package:flutter/foundation.dart';

class Stock {
  String name;
  double currentValue;
  double openedValue;
  double growthPercentage;
  List<double> quotes;

  Stock({
    @required this.name,
    @required this.currentValue,
    @required this.openedValue,
    @required this.growthPercentage,
    @required this.quotes,
  });
}

class ReceivedQuote {
  String name;
  double value;
  double timeStamp;

  ReceivedQuote({@required this.name, @required this.value, @required this.timeStamp});
}
