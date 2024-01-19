import 'package:flutter/material.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/constants/font_const.dart';
import 'package:kalimati_bazar/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomDropdown extends StatelessWidget {
  final String dropdownvalue;
  final List<String> items;
  final Function(String) onChanged;

  const CustomDropdown({
    Key? key,
    required this.dropdownvalue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeChanger.themeMode == ThemeMode.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: searchbarStrokeColor,
          width: 1,
        ),
      ),
      child: DropdownButton(
        value: dropdownvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontFamily: popmedium,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          onChanged(newValue!);
        },
      ),
    );
  }
}
