import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_plugin_interface/amplify_storage_plugin_interface.dart';
import 'package:flutter/material.dart';

class S3Image extends StatelessWidget {
  final String _fileName;
  final BoxFit? _fit;
  const S3Image(String fileName, {BoxFit? fit})
      : _fileName = fileName,
        _fit = fit;

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
      future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Image.network(
            snapshot.data!,
            fit: _fit,
          );
        } else if (snapshot.hasError) {
          return Text("error loading image");
        } else {
          return Text("Loading..");
        }
      },
    );
  }
}
