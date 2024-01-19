// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kalimati_bazar/constants/color_const.dart';

class singleItem extends StatelessWidget {
  final String imageUrl;
  final String avgprice;
  final String maxprice;
  final String minprice;
  final String productName;
  const singleItem({
    Key? key,
    required this.imageUrl,
    required this.avgprice,
    required this.maxprice,
    required this.minprice,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: itembackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          // Image and Price in Top Right
          Positioned.fill(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: bottompriceColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                avgprice,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Color Container at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: onboardingBackground,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image Name
                  Text(
                    productName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Max and Min Prices wrapped in containers
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: bottompriceColor,
                            borderRadius: BorderRadius.circular(15)),
                        // Red background
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          maxprice,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: bottompriceColor,
                            borderRadius: BorderRadius.circular(15)),
                        // Red background
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          minprice,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
