import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kalimati_bazar/controllers/api_controller.dart';
import 'package:kalimati_bazar/models/daily__market_price_model.dart';

class DailyMarketPriceProvider extends ChangeNotifier {
  late ApiService _apiService;
  List<Prices>? _dailyMarketPriceData;
  TextEditingController _queryController = TextEditingController();

  List<Prices>? get dailyMarketPriceData => _dailyMarketPriceData;
  TextEditingController get queryController => _queryController;

  DailyMarketPriceProvider() {
    _apiService = ApiService();
    _dailyMarketPriceData = [];
    _fetchDailyMarketPrice("");
  }

  Future<void> _fetchDailyMarketPrice(String query) async {
    try {
      Response res =
          await _apiService.getDailyMarketPrice("/api/daily-prices/en");

      if (res.statusCode == 200) {
        DailyMarketPrice dailyPriceData = DailyMarketPrice.fromJson(res.data);
        _dailyMarketPriceData = dailyPriceData.prices
            ?.where((price) =>
                price.commodityname!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                price.avgprice
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void updateQuery(String query) {
    _fetchDailyMarketPrice(query);
  }

  void sortDailyMarketPriceData(String selectedDropdownValue) {
    if (_dailyMarketPriceData != null) {
      _dailyMarketPriceData!.sort((a, b) {
        final aValue = _getValueForComparison(a, selectedDropdownValue);
        final bValue = _getValueForComparison(b, selectedDropdownValue);

        return aValue.compareTo(bValue);
      });
      notifyListeners();
    }
  }

  dynamic _getValueForComparison(Prices price, String selectedDropdownValue) {
    switch (selectedDropdownValue) {
      case 'Avg Price':
        return price.avgprice ?? '';
      case 'Max Price':
        return price.maxprice ?? '';
      case 'Min Price':
        return price.minprice ?? '';
      default:
        return '';
    }
  }
}
