import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/module/module_bloc.dart';
import 'package:mfc_app/models/course/Module.dart';
import 'package:mfc_app/models/course/Question.dart';
import 'package:mfc_app/widgets/loading.dart';
import 'package:mfc_app/widgets/question.dart';
import 'package:mfc_app/widgets/s3_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'info_tab.dart';
part 'video_tab.dart';
part 'questions_tab.dart';

class ModuleSingleScreen extends StatefulWidget {
  final String _courseId;
  final String _moduleId;

  const ModuleSingleScreen(
      {Key? key, required String courseId, required String moduleId})
      : _courseId = courseId,
        _moduleId = moduleId,
        super(key: key);

  @override
  _ModuleSingleScreenState createState() =>
      _ModuleSingleScreenState(_courseId, _moduleId);
}

class _ModuleSingleScreenState extends State<ModuleSingleScreen> {
  final String courseId;
  final String moduleId;

  _ModuleSingleScreenState(this.courseId, this.moduleId);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ModuleBloc>(context).add(
      ModuleSelected(courseId, moduleId),
    );
  }

  YoutubePlayerController _youtubeController = YoutubePlayerController(
    initialVideoId: "dQw4w9WgXcQ",
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModuleBloc, ModuleState>(
      builder: (context, state) {
        if (state is ModuleInitial) {
          return Loading();
        } else if (state is ModuleLoading) {
          return Loading();
        } else if (state is ModuleAvailable) {
          Module module = state.module;
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(module.name),
                bottom: TabBar(
                  tabs: [
                    Tab(text: "Info"),
                    Tab(text: "Video"),
                    Tab(text: "Opdrachten"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ModuleInfoTab(module: module),
                  ModuleVideoTab(youtubeController: _youtubeController),
                  ModuleQuestionsTab(questions: module.assignments ?? []),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Text("weird state"),
                    MaterialButton(
                      onPressed: () => BlocProvider.of<ModuleBloc>(context)
                          .add(ModuleSelected(courseId, moduleId)),
                      child: Text('reload'),
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
