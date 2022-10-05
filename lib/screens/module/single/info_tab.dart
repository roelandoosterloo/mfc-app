part of 'module_single_screen.dart';

class ModuleInfoTab extends StatefulWidget {
  const ModuleInfoTab({
    Key? key,
    required this.module,
  }) : super(key: key);

  final Module module;

  @override
  State<ModuleInfoTab> createState() => _ModuleInfoTabState();
}

class _ModuleInfoTabState extends State<ModuleInfoTab> {
  bool _loadingTool = false;

  Future<String?> getFileLink(Downloadable tool) async {
    try {
      GetUrlResult result = await Amplify.Storage.getUrl(
          key: tool.url,
          options: GetUrlOptions(
            accessLevel: StorageAccessLevel.guest,
          ));
      return result.url;
    } catch (ex) {
      await Sentry.captureException(ex);
      return null;
    }
  }

  Future<void> loadPdfFromNetwork(Downloadable tool) async {
    setState(() => {_loadingTool = true});
    try {
      String? url = await getFileLink(tool);
      if (url == null) {
        return;
      }
      final File file = await _downloadFile(tool.name, url);
      BlocProvider.of<NavigationBloc>(context)
          .add(NavigatedToPdf(file, tool.name, url));
    } catch (ex) {
      await Sentry.captureException(ex);
    } finally {
      setState(() {
        _loadingTool = false;
      });
    }
  }

  Future<File> _downloadFile(String name, String url) async {
    final filename = name + ".pdf";
    final dir = await getTemporaryDirectory();

    final File cache = File('${dir.path}/$filename');
    if (cache.existsSync()) {
      return cache;
    }

    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.module.description,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  height: 10,
                ),
              ),
              if (widget.module.tools != null &&
                  widget.module.tools!.isNotEmpty) ...[
                Text(
                  "TOOLS",
                  style: TextStyle(
                    fontFamily: 'Stratum',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                ...widget.module.tools!.map(
                  (tool) {
                    return Card(
                      child: ListTile(
                        title: Text(tool.name),
                        leading: !_loadingTool
                            ? CircleAvatar(
                                child: Icon(Icons.handyman),
                              )
                            : CircularProgressIndicator(),
                        onTap: !_loadingTool
                            ? () => loadPdfFromNetwork(tool)
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
