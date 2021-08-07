import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/single/single_course_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/course.dart';
import 'package:mfc_app/widgets/loading.dart';

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
          Course course = state.course;

          return Scaffold(
            appBar: AppBar(
              title: Text(course.name),
            ),
            body: Container(
              child: ListView.separated(
                itemCount: course.modules?.length ?? 0,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  Module? module = course.modules?[index];
                  if (module != null) {
                    return ListTile(
                      leading: Hero(
                        tag: module.id,
                        child: Image.network(
                          module.coverImageUrl ??
                              "https://placeimg.com/600/600/any",
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(module.name),
                      subtitle: Text(module.topic ?? ""),
                      onTap: () => BlocProvider.of<NavigationBloc>(context)
                          .add(NavigatedToModule(course.id, module.id)),
                    );
                  }
                  return ListTile(
                    title: Text("No modules"),
                  );

                  // )

                  // Card(
                  //   clipBehavior: Clip.antiAlias,
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         width: double.infinity,
                  //         height: 150,
                  //         child: Hero(
                  //           tag: index,
                  //           child: Image.network(
                  //             "https://placeimg.com/1000/600/any",
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       ),
                  //       ListTile(
                  //         title: Text(
                  //           module.name,
                  //           style: TextStyle(fontSize: 24),
                  //         ),
                  //         subtitle: Text(
                  //           "Beschikbaar vanaf 09-05-2022",
                  //           style:
                  //               TextStyle(color: Colors.black.withOpacity(0.6)),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(16.0),
                  //         child: Text(
                  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean congue at purus eget auctor. Duis vitae facilisis neque, vitae lacinia velit. Aliquam vulputate et libero et dictum[...] ",
                  //           style: TextStyle(
                  //             color: Colors.black.withOpacity(0.6),
                  //           ),
                  //         ),
                  //       ),
                  //       Divider(
                  //         indent: 10,
                  //         endIndent: 10,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.restaurant),
                  //             Text("16"),
                  //             SizedBox(width: 24),
                  //             Icon(Icons.play_arrow),
                  //             Text("23:41"),
                  //             SizedBox(width: 24),
                  //             Icon(Icons.book),
                  //             Text("9"),
                  //           ],
                  //         ),
                  //       ),
                  //       ButtonBar(
                  //         alignment: MainAxisAlignment.start,
                  //         children: [
                  //           TextButton(
                  //             onPressed: () =>
                  //                 BlocProvider.of<NavigationBloc>(context)
                  //                     .add(NavigatedToModule(index.toString())),
                  //             child: Text("Begin"),
                  //           )
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              child: Text("Weird..."),
            ),
          );
        }
      },
    );
  }
}
