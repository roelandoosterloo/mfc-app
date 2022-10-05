import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mfc_app/screens/pdf_viewer/pdf_viewer_screen.dart';

class PdfViewerPage extends Page {
  final File _file;
  final String _name;
  final String _url;

  PdfViewerPage(
    this._file,
    this._name,
    this._url,
  ) : super(name: "PdfViewerPage");

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => PdfViewerScreen(
        file: _file,
        name: _name,
        url: _url,
      ),
    );
  }
}
