part of 'module_single_screen.dart';

class ModuleInfoTab extends StatelessWidget {
  const ModuleInfoTab({
    Key? key,
    required this.module,
  }) : super(key: key);

  final Module module;

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

  Future<void> _launchUrl(Downloadable tool) async {
    String? url = await getFileLink(tool);
    if (url == null) {
      return;
    }
    Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri)) {
        throw 'Could not launch $url';
      }
    } catch (ex) {
      await Sentry.captureException(ex);
    }
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
                module.description,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  height: 10,
                ),
              ),
              if (module.tools != null && module.tools!.isNotEmpty) ...[
                Text(
                  "TOOLS",
                  style: TextStyle(
                    fontFamily: 'Stratum',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                ...module.tools!.map(
                  (tool) {
                    return Card(
                      child: ListTile(
                        title: Text(tool.name),
                        leading: CircleAvatar(
                          child: Icon(Icons.handyman),
                        ),
                        onTap: () => _launchUrl(tool),
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
