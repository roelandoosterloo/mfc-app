part of 'module_single_screen.dart';

class ModuleInfoTab extends StatelessWidget {
  const ModuleInfoTab({
    Key? key,
    required this.module,
  }) : super(key: key);

  final Module module;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Hero(
                  tag: module.id,
                  child: S3Image(
                    module.coverImage ?? "https://placeimg.com/1000/600/any",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Text(
                  module.name,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(module.description),
            ),
          ),
        ],
      ),
    );
  }
}
