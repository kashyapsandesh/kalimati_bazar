import 'package:flutter/material.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/provider/notice_provider.dart';
import 'package:kalimati_bazar/views/screens/notices/notice_detail.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoticesProvider>(context, listen: false).fetchNotices();
  }

  @override
  Widget build(BuildContext context) {
    final noticesProvider = Provider.of<NoticesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: onboardingBackground,
        title: Text(
          'Kalimati Market Notices',
          style: TextStyle(color: iconBackgroundColor),
        ),
      ),
      body: noticesProvider.notices == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: noticesProvider.notices!.length,
              itemBuilder: (context, index) {
                final notice = noticesProvider.notices![index];
                return Card(
                  color: onboardingBackground,
                  margin: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoticeDetailsPage(
                                    notice: notice,
                                  )));
                    },
                    child: ListTile(
                      title: Text(
                        '${notice['1']}',
                        style: TextStyle(color: iconBackgroundColor),
                      ),
                      // Add other details as needed
                    ),
                  ),
                );
              },
            ),
    );
  }
}
