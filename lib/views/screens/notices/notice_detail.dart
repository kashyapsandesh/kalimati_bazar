// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeDetailsPage extends StatelessWidget {
  Map<String, dynamic> notice;
  NoticeDetailsPage({
    Key? key,
    required this.notice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = notice['4']['link'];
    Future<void> launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> _saveImage(BuildContext context) async {
      String? message;
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      try {
        // Download image
        final http.Response response = await http.get(Uri.parse(imageUrl));

        // Get temporary directory
        final dir = await getTemporaryDirectory();

        // Create an image name
        var filename = '${dir.path}/image.png';

        // Save to filesystem
        final file = File(filename);
        await file.writeAsBytes(response.bodyBytes);

        // Ask the user to save it
        final params = SaveFileDialogParams(sourceFilePath: file.path);
        final finalPath = await FlutterFileDialog.saveFile(params: params);

        if (finalPath != null) {
          message = 'Image saved to disk';
        }
      } catch (e) {
        message = 'An error occurred while saving the image';
      }

      if (message != null) {
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Image View'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _saveImage(context),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            imageUrl,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Tap the download icon to save the image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => launchURL(imageUrl),
        tooltip: 'Open in Browser',
        child: Icon(Icons.open_in_browser),
      ),
    );
  }
}
