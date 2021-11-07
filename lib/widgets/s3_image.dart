import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_plugin_interface/amplify_storage_plugin_interface.dart';
import 'package:flutter/material.dart';

class S3Image extends StatelessWidget {
  final String _fileName;
  final BoxFit? _fit;
  const S3Image(String fileName, {BoxFit? fit})
      : _fileName = fileName,
        _fit = fit;

  Future<File?> get file async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = dir.path + _fileName;
    final file = File(filePath);

    if (file.existsSync()) {
      return file;
    }

    try {
      await Amplify.Storage.downloadFile(
        key: _fileName,
        local: file,
      );
      return file;
    } on StorageException catch (_) {
      print('Error while downloading file');
    }
  }

  Future<String> get url async {
    final GetUrlResult url = await Amplify.Storage.getUrl(
      key: _fileName,
      options: GetUrlOptions(accessLevel: StorageAccessLevel.guest),
    );
    return url.url;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return Image.file(
              snapshot.data!,
              fit: _fit,
            );
          }
        }
        return Image.asset('assets/placeholder.png', fit: _fit);
      },
    );
  }
}