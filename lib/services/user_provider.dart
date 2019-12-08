import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  int selectedSortMethod = 0;

  setSortMethod(int index) {
    selectedSortMethod = index;
    notifyListeners();
  }
}
