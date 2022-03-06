import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_plugin_interface/amplify_storage_plugin_interface.dart';
import 'package:flutter/material.dart';

class S3Image extends StatefulWidget {
  final String? _fileName;
  final BoxFit? _fit;
  final double? _height;
  final double? _width;
  const S3Image(
    String? fileName, {
    BoxFit? fit,
    double? height,
    double? width,
  })  : _fileName = fileName,
        _fit = fit,
        _height = height,
        _width = width;

  @override
  State<S3Image> createState() => _S3ImageState();
}

class _S3ImageState extends State<S3Image> {
  File? _file;

  @override
  void initState() {
    super.initState();
    setFile();
  }

  @override
  void didUpdateWidget(S3Image old) {
    super.didUpdateWidget(old);
    if (old._fileName != widget._fileName) {
      setFile();
    }
  }

  void setFile() async {
    if (widget._fileName == null) {
      return null;
    }
    final dir = await getTemporaryDirectory();
    final filePath = dir.path + widget._fileName!;
    final file = File(filePath);

    if (file.existsSync()) {
      setState(() {
        _file = file;
      });
      return;
    }

    try {
      await Amplify.Storage.downloadFile(
        key: widget._fileName!,
        local: file,
      );
      setState(() {
        _file = file;
      });
      return;
    } on StorageException catch (_) {
      print('Error while downloading file');
    } catch (_) {}
    return null;
  }

  Future<String> get url async {
    final GetUrlResult url = await Amplify.Storage.getUrl(
      key: widget._fileName!,
      options: GetUrlOptions(accessLevel: StorageAccessLevel.guest),
    );
    return url.url;
  }

  @override
  Widget build(BuildContext context) {
    if (_file != null) {
      return Image.file(
        _file!,
        fit: widget._fit,
        height: widget._height,
        width: widget._width,
      );
    }
    return Image.asset(
      'assets/images/placeholder.png',
      fit: widget._fit,
      height: widget._height,
      width: widget._width,
    );
  }
}
