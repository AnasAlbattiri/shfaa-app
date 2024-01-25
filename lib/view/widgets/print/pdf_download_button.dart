import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DownloadButton extends StatelessWidget {
  final String filePath;

  const DownloadButton({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Share.shareFiles([filePath], text: 'Your PDF file');
      },
      child: Text('Download PDF'),
    );
  }
}
