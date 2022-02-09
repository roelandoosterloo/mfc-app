import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/constants/values.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/models/course/Module.dart';
import 'package:mfc_app/models/course/Course.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';
import 'package:mfc_app/screens/course/single/bloc/singlecoursepage_bloc.dart';
import 'package:mfc_app/widgets/loading.dart';
import 'package:mfc_app/widgets/s3_image.dart';

part "module_card.dart";

class CourseSingleScreen extends StatefulWidget {
  @override
  State<CourseSingleScreen> createState() => _CourseSingleScreenState();
}

class _CourseSingleScreenState extends State<CourseSingleScreen> {
  @override
  void initState() {
    BlocProvider.of<SingleCoursePageBloc>(context)
        .add(SingleCoursePageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<SingleCoursePageBloc, SingleCoursePageState>(
        builder: (context, state) {
          if (state is SingleCoursePageLoading) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff2b8474),
              ),
            );
          } else if (state is SingleCoursePageLoaded) {
            Enrollment enrollment = state.enrollment!;
            Course course = enrollment.course;
            List<ModuleProgress> modules = enrollment.moduleSchedule ?? [];
            modules.sort((a, b) =>
                a.availableAt.millisecondsSinceEpoch -
                b.availableAt.millisecondsSinceEpoch);

            return Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff2b8474),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: S3Image(
                      course.coverImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 75, left: 50),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff2b8474).withOpacity(0),
                          Color(0xff2b8474),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 230,
                          width: double.infinity,
                        ),
                        Text(
                          course.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'Stratum',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          course.description ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        ...modules.map(
                          (ModuleProgress m) {
                            return ModuleCard(progress: m);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
