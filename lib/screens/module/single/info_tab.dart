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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            module.description,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
