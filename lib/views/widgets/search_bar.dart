// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/views/screens/notices/notices_screen.dart';

class searchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onqueryChange;

  const searchBar({
    Key? key,
    required this.searchController,
    required this.onqueryChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            child: TextField(
              onChanged: onqueryChange,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 1,
                    color: searchbarStrokeColor,
                  ),
                ),
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoticeScreen()));
            },
            icon: const Icon(
              Icons.notifications_rounded,
              color: onboardingBackground,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
