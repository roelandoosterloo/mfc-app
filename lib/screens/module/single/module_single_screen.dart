import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/module/module_bloc.dart';
import 'package:mfc_app/models/course/Module.dart';
import 'package:mfc_app/models/course/Question.dart';
import 'package:mfc_app/widgets/MySliverPersistentHeaderDelegate.dart';
import 'package:mfc_app/widgets/loading.dart';
import 'package:mfc_app/widgets/questions/question.dart';
import 'package:mfc_app/widgets/s3_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'info_tab.dart';
part 'video_tab.dart';
part 'questions_tab.dart';

class ModuleSingleScreen extends StatefulWidget {
  final String _progressId;

  const ModuleSingleScreen({Key? key, required String progressId})
      : _progressId = progressId,
        super(key: key);

  @override
  _ModuleSingleScreenState createState() =>
      _ModuleSingleScreenState(_progressId);
}

class _ModuleSingleScreenState extends State<ModuleSingleScreen> {
  final String progressId;

  _ModuleSingleScreenState(this.progressId);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ModuleProgressBloc>(context).add(
      ModuleProgressSelected(progressId),
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
    return BlocBuilder<ModuleProgressBloc, ModuleProgressState>(
      builder: (context, state) {
        if (state is ModuleProgressInitial) {
          return Loading();
        } else if (state is ModuleProgressLoading) {
          return Loading();
        } else if (state is ModuleProgressAvailable) {
          Module module = state.moduleprogress.module!;
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      pinned: true,
                      floating: false,
                      expandedHeight:
                          MediaQuery.of(context).size.height * 0.305,
                      backgroundColor: Color(0xff2b8474),
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(module.name, textScaleFactor: 1),
                        background: S3Image(
                          module.coverImage ?? "",
                          fit: BoxFit.cover,
                        ),
                        stretchModes: [StretchMode.zoomBackground],
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: MySliverPersistentHeaderDelegate(
                        TabBar(
                          indicatorColor: Colors.white,
                          tabs: [
                            Tab(text: "Info"),
                            Tab(text: "Video"),
                            Tab(text: "Opdrachten"),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: Container(
                  color: Color(0xff2b8474),
                  padding: EdgeInsets.only(top: 16),
                  child: TabBarView(
                    children: [
                      ModuleInfoTab(module: module),
                      ModuleVideoTab(youtubeController: _youtubeController),
                      ModuleQuestionsTab(questions: module.assignments ?? []),
                    ],
                  ),
                ),
              ),
            ),
          );
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
                      onPressed: () =>
                          BlocProvider.of<ModuleProgressBloc>(context)
                              .add(ModuleProgressSelected(progressId)),
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
