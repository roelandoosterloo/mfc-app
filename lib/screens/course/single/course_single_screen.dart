import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/course/single/single_course_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/models/course/Module.dart';
import 'package:mfc_app/models/course/Course.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';
import 'package:mfc_app/widgets/loading.dart';
import 'package:mfc_app/widgets/s3_image.dart';

class CourseSingleScreen extends StatefulWidget {
  final String _courseId;

  const CourseSingleScreen({Key? key, required String courseId})
      : _courseId = courseId,
        super(key: key);

  @override
  _CourseSingleScreenState createState() => _CourseSingleScreenState(_courseId);
}

class _CourseSingleScreenState extends State<CourseSingleScreen> {
  final String courseId;
  final f = new DateFormat('yyyy-MM-dd');

  _CourseSingleScreenState(this.courseId);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SingleCourseBloc>(context).add(CourseSelected(courseId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCourseBloc, SingleCourseState>(
      builder: (context, state) {
        if (state is SingleInitial) {
          return Scaffold(
            body: Container(
              child: Text(
                "Loading...",
              ),
            ),
          );
        } else if (state is CourseNotFound) {
          return Scaffold(
            body: Container(
              child: Text(
                "The selected course does not exist.",
              ),
            ),
          );
        } else if (state is CourseLoading) {
          return Loading();
        } else if (state is CourseAvailable) {
          Enrollment enrollment = state.course;
          Course course = enrollment.course;
          List<ModuleProgress> modules = enrollment.moduleSchedule ?? [];
          modules.sort((a, b) =>
              b.availableAt.millisecondsSinceEpoch -
              a.availableAt.millisecondsSinceEpoch);

          return Scaffold(
            appBar: AppBar(
              title: Text(course.name),
            ),
            body: Container(
              child: ListView.separated(
                itemCount: modules.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  ModuleProgress progress = modules[index];
                  Module? module = progress.module;
                  if (module != null) {
                    return ListTile(
                      leading: Hero(
                        tag: module.id,
                        child: S3Image(
                          module.coverImage ??
                              "https://placeimg.com/600/600/any",
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(module.name),
                      subtitle: Text(!progress.isAvailable()
                          ? "available at ${f.format(progress.availableAt)}"
                          : ""),
                      onTap: progress.isAvailable()
                          ? () => BlocProvider.of<NavigationBloc>(context)
                              .add(NavigatedToModule(course.id, module.id))
                          : null,
                    );
                  }
                  return ListTile(
                    title: Text("No modules"),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Text("Weird..."),
                    MaterialButton(
                      onPressed: () =>
                          BlocProvider.of<SingleCourseBloc>(context)
                              .add(CourseSelected(courseId)),
                      child: Text("reload"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
