import 'package:flutter/material.dart';

import 'package:kalimati_bazar/provider/daily_market_provider.dart';
import 'package:kalimati_bazar/provider/theme_provider.dart';
import 'package:kalimati_bazar/views/widgets/app_at.dart';
import 'package:kalimati_bazar/views/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  String dropdownvalue = 'Avg Price';
  var items = ['Avg Price', 'Max Price', 'Min Price'];

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeChanger.themeMode == ThemeMode.dark;
    final dailyMarketPriceProvider =
        Provider.of<DailyMarketPriceProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => DailyMarketPriceProvider(),
          child: Consumer<DailyMarketPriceProvider>(
            builder: (context, provider, _) {
              return Column(
                children: [
                  searchBar(
                    onqueryChange: (query) {
                      dailyMarketPriceProvider.updateQuery(query);
                    },
                    searchController: dailyMarketPriceProvider.queryController,
                  ),
                  AppAt(onDropdownChanged: (String newValue) {
                    dailyMarketPriceProvider.sortDailyMarketPriceData(newValue);
                  }),
                  // Your existing searchBar and AppAt widgets here...

                  Expanded(
                    child: provider.dailyMarketPriceData != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.blue,
                                  ),
                                  child: const Row(
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
                                    itemCount:
                                        provider.dailyMarketPriceData!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                                provider
                                                    .dailyMarketPriceData![
                                                        index]
                                                    .commodityname!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "NRS: ${provider.dailyMarketPriceData![index].avgprice}/${provider.dailyMarketPriceData![index].commodityunit}",
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  "NRS: ${provider.dailyMarketPriceData![index].maxprice}/${provider.dailyMarketPriceData![index].commodityunit}",
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  'NRS: ${provider.dailyMarketPriceData![index].minprice}/${provider.dailyMarketPriceData![index].commodityunit}',
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
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors
                                  .blue, // or use your onboardingBackground color
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
