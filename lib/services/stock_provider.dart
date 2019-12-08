import 'package:desafio_toro/models/stock_model.dart';
import 'package:flutter/foundation.dart';

class StockProvider with ChangeNotifier {
  List<Stock> _stocksList = [];

  List<Stock> get stocksList => _stocksList;

  bool azToggle = true;

  addQuote(Map data) {
    ReceivedQuote receivedQuote = ReceivedQuote(name: data.keys.toList()[0], value: data.values.toList()[0], timeStamp: data.values.toList()[1] * 1000);

    int stockIndex = _stocksList.indexWhere((quote) => quote.name == receivedQuote.name);

    if (stockIndex == -1) {
      _stocksList.add(
        Stock(
          name: receivedQuote.name,
          currentValue: receivedQuote.value,
          openedValue: receivedQuote.value,
          growthPercentage: 0,
          quotes: [receivedQuote.value],
        ),
      );
    } else {
      stocksList[stockIndex].currentValue = receivedQuote.value;
      stocksList[stockIndex].currentValue = receivedQuote.value;
      stocksList[stockIndex].growthPercentage = stocksList[stockIndex].currentValue / stocksList[stockIndex].openedValue - 1;
      if (stocksList[stockIndex].quotes.length > 20) {
        stocksList[stockIndex].quotes.removeAt(0);
        stocksList[stockIndex].quotes.add(receivedQuote.value);
      } else {
        stocksList[stockIndex].quotes.add(receivedQuote.value);
      }
    }
    notifyListeners();
  }

  sortList(int option) {
    switch (option) {
      case 0:
        {
          stocksList.sort((a, b) => b.growthPercentage.compareTo(a.growthPercentage));
        }
        break;
      case 1:
        {
          stocksList.sort((a, b) => a.growthPercentage.compareTo(b.growthPercentage));
        }
        break;
      case 2:
        {
          azToggle ? stocksList.sort((a, b) => a.name.compareTo(b.name)) : stocksList.sort((a, b) => b.name.compareTo(a.name));
          azToggle = !azToggle;
        }
        break;
    }
    notifyListeners();
  }
}
