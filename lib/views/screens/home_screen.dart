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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 4 / 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: dailyMarketPriceData!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          final String? productName =
                              dailyMarketPriceData![index].commodityname;
                          final String imageUrl =
                              "assets/images/${productName}.png";
                          final String? unit =
                              dailyMarketPriceData![index].commodityunit;
                          return singleItem(
                            imageUrl: imageUrl == null
                                ? "assets/images/Parseley.png"
                                : imageUrl,
                            avgprice:
                                "NRS: ${dailyMarketPriceData![index].avgprice}/${unit}",
                            maxprice:
                                "Max NRS: ${dailyMarketPriceData![index].maxprice}/${unit}",
                            minprice:
                                ' Min NRS: ${dailyMarketPriceData![index].minprice}/${unit}',
                            productName: productName!,
                          );
                        },
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
