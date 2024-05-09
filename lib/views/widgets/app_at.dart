import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/constants/font_const.dart';
import 'package:kalimati_bazar/constants/string_const.dart';
import 'package:kalimati_bazar/provider/theme_provider.dart';
import 'package:kalimati_bazar/views/widgets/custom_drop_down.dart';
import 'package:provider/provider.dart';

class AppAt extends StatefulWidget {
  final Function(String) onDropdownChanged;

  const AppAt({
    Key? key,
    required this.onDropdownChanged,
  }) : super(key: key);

  @override
  State<AppAt> createState() => _AppAtState();
}

class _AppAtState extends State<AppAt> {
  String dropdownValue = 'Avg Price';

  // List of items in our dropdown menu
  var items = ['Avg Price', 'Max Price', 'Min Price'];

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeChanger.themeMode == ThemeMode.dark;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todayprice,
                style: TextStyle(
                  fontFamily: popmedium,
                  fontSize: 24,
                  color: isDarkMode ? iconBackgroundColor : homepageTextColor,
                ),
              ),
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontFamily: popmedium,
                  fontSize: 16,
                  color: homepageTextColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        CustomDropdown(
          dropdownvalue: dropdownValue,
          items: items,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                dropdownValue = newValue;
                widget.onDropdownChanged(newValue);
              });
              print(dropdownValue);
            }
          },
        ),
      ],
    );
  }
}
