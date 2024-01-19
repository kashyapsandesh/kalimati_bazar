import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/constants/font_const.dart';
import 'package:kalimati_bazar/constants/string_const.dart';
import 'package:kalimati_bazar/controllers/api_controller.dart';
import 'package:kalimati_bazar/models/daily__market_price_model.dart';
import 'package:kalimati_bazar/views/widgets/app_at.dart';
import 'package:kalimati_bazar/views/widgets/custom_drop_down.dart';
import 'package:kalimati_bazar/views/widgets/search_bar.dart';
import 'package:kalimati_bazar/views/widgets/single_item.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  // Initial Selected Value
  String dropdownvalue = 'Avg Price';

  // List of items in our dropdown menu
  var items = [
    'Avg Price',
    'Max Price',
    'Min Price',
  ];
  TextEditingController _queryController = TextEditingController();
  late ApiService _apiService;
  List<Prices>? dailyMarketPriceData;
  String selectedDropdownValue = 'Avg Price';

  getDailyMarketPrice(String query) async {
    try {
      Response res =
          await _apiService.getDailyMarketPrice("/api/daily-prices/en");

      if (res.statusCode == 200) {
        DailyMarketPrice dailyPriceData = DailyMarketPrice.fromJson(res.data);

        setState(() {
          dailyMarketPriceData = dailyPriceData.prices
              ?.where((price) =>
                  price.commodityname!
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  price.avgprice
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _apiService = ApiService();
    getDailyMarketPrice(""); // Initially fetch data without any query
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            searchBar(
              onqueryChange: (query) {
                getDailyMarketPrice(query);
              },
              searchController: _queryController,
            ),
            AppAt(onDropdownChanged: (String newValue) {
              // Update the selected value in the parent widget
              setState(() {
                selectedDropdownValue = newValue;
                // Sort the data based on the selected dropdown value
                sortDailyMarketPriceData();
              });
            }),
            Expanded(
              child: dailyMarketPriceData != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: onboardingBackground,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Product Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Avg Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Max Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Min Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: dailyMarketPriceData!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          dailyMarketPriceData![index]
                                              .commodityname!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "NRS: ${dailyMarketPriceData![index].avgprice}/${dailyMarketPriceData![index].commodityunit}",
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            "NRS: ${dailyMarketPriceData![index].maxprice}/${dailyMarketPriceData![index].commodityunit}",
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'NRS: ${dailyMarketPriceData![index].minprice}/${dailyMarketPriceData![index].commodityunit}',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: onboardingBackground,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void sortDailyMarketPriceData() {
    if (dailyMarketPriceData != null) {
      dailyMarketPriceData!.sort((a, b) {
        final aValue = getValueForComparison(a);
        final bValue = getValueForComparison(b);

        return aValue.compareTo(bValue);
      });
    }
  }

  dynamic getValueForComparison(Prices price) {
    switch (selectedDropdownValue) {
      case 'Avg Price':
        return price.avgprice ??
            ''; // Provide a default value if avgprice is nullable
      case 'Max Price':
        return price.maxprice ??
            ''; // Provide a default value if maxprice is nullable
      case 'Min Price':
        return price.minprice ??
            ''; // Provide a default value if minprice is nullable
      default:
        return ''; // Handle default case
    }
  }
}
