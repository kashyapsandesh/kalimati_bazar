import 'package:flutter/material.dart';
import 'package:kalimati_bazar/constants/color_const.dart';

import 'package:kalimati_bazar/provider/daily_market_provider.dart';
import 'package:kalimati_bazar/views/widgets/app_at.dart';
import 'package:kalimati_bazar/views/widgets/search_bar.dart';
import 'package:kalimati_bazar/views/widgets/single_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final dailyMarketPriceProvider =
        Provider.of<DailyMarketPriceProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
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
            Expanded(
              child: dailyMarketPriceProvider.dailyMarketPriceData != null
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
                        itemCount: dailyMarketPriceProvider
                            .dailyMarketPriceData!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          final String? productName = dailyMarketPriceProvider
                              .dailyMarketPriceData![index].commodityname;
                          final String imageUrl =
                              "assets/images/$productName.png";
                          final String? unit = dailyMarketPriceProvider
                              .dailyMarketPriceData![index].commodityunit;
                          return singleItem(
                            imageUrl: imageUrl,
                            avgprice:
                                "NRS: ${dailyMarketPriceProvider.dailyMarketPriceData![index].avgprice}/$unit",
                            maxprice:
                                "Max NRS: ${dailyMarketPriceProvider.dailyMarketPriceData![index].maxprice}/$unit",
                            minprice:
                                ' Min NRS: ${dailyMarketPriceProvider.dailyMarketPriceData![index].minprice}/$unit',
                            productName: productName!,
                          );
                        },
                      ),
                    )
                  : const Center(
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
}
