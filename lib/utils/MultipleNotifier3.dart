import 'package:flutter/material.dart';

class MultipleNotifier3 extends ChangeNotifier {
  List<String> _selecteItems;
  MultipleNotifier3(this._selecteItems);
  List<String> get selectedItems => _selecteItems;

  bool isHaveItem(String value) => _selecteItems.contains(value);

  addItem(String value) {
    if (!isHaveItem(value)) {
      _selecteItems.add(value);
      notifyListeners();
    }
  }

  List<String> get getListOfBannerItem1{
    return [..._selecteItems];
  }

  removeItem(String value) {
    if (isHaveItem(value)) {
      _selecteItems.remove(value);
      notifyListeners();
    }
  }
}
