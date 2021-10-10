import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/list/course_list_bloc.dart';
import 'package:mfc_app/blocs/course/single/single_course_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/course/Course.dart';
import 'package:mfc_app/widgets/loading.dart';
import 'package:mfc_app/widgets/s3_image.dart';

class CourseListScreen extends StatefulWidget {
  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CourseListBloc>(context).add(CourseListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Courses"),
      ),
      body: BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return Loading();
          }
          if (state is CourseListAvailable) {
            return Container(
              child: ListView.builder(
                itemCount: state.courses.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Course course = state.courses[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Hero(
                            tag: index,
                            child: S3Image(
                              course.coverImage ??
                                  "https://placeimg.com/1000/600/any",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            course.name,
                            style: TextStyle(fontSize: 24),
                          ),
                          // subtitle: Text(
                          //   "Beschikbaar vanaf 09-05-2022",
                          //   style: TextStyle(
                          //       color: Colors.black.withOpacity(0.6)),
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            course.description ?? "",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  BlocProvider.of<NavigationBloc>(context)
                                      .add(NavigatedToCourse(course.id)),
                              child: Text("Begin"),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Text("Loading");
        },
      ),
    );
  }
}
