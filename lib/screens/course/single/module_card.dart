part of 'course_single_screen.dart';

class ModuleCard extends StatelessWidget {
  final ModuleProgress _progress;

  final f = new DateFormat(DATE_FORMAT);

  ModuleCard({Key? key, required ModuleProgress progress})
      : _progress = progress,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Module m = _progress.module!;

    return Card(
      color: Color(0xff459E8E),
      margin: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: _progress.isAvailable()
            ? () {
                BlocProvider.of<SingleCoursePageBloc>(context)
                    .add(SingleCoursePageModuleSelected(_progress));
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: S3Image(
                  m.coverImage ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.name.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Stratum',
                      ),
                    ),
                    if (_progress.completedAt != null)
                      Text(
                        "Afgerond",
                        style: TextStyle(color: Colors.white),
                      )
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              if (_progress.isAvailable())
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff2b8474),
                      radius: 20,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              if (!_progress.isAvailable())
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                        bottom: 5,
                      ),
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      f.format(_progress.availableAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
