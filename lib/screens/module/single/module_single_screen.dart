import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/module/module_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/constants/colors.dart';
import 'package:mfc_app/models/Answer.dart';
import 'package:mfc_app/models/Downloadable.dart';
import 'package:mfc_app/models/Module.dart';
import 'package:mfc_app/models/ModuleProgress.dart';
import 'package:mfc_app/models/Question.dart';
import 'package:mfc_app/widgets/MySliverPersistentHeaderDelegate.dart';
import 'package:mfc_app/widgets/questions/question.dart';
import 'package:mfc_app/widgets/s3_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;

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

  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ModuleProgressBloc>(context).add(
      ModuleProgressSelected(progressId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModuleProgressBloc, ModuleProgressState>(
      listener: (context, state) {
        if (_youtubeController == null && state is ModuleProgressAvailable) {
          setState(
            () {
              String? videoId = YoutubePlayer.convertUrlToId(
                  state.moduleprogress.module!.videoUrl);
              if (videoId != null) {
                _youtubeController = YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                );
              }
            },
          );
        }
      },
      builder: (context, state) {
        if (state is ModuleProgressInitial) {
          return Scaffold(body: Container());
        } else if (state is ModuleProgressLoading) {
          return Scaffold(body: Container());
        } else if (state is ModuleProgressAvailable) {
          Module module = state.moduleprogress.module!;
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  if (_youtubeController != null &&
                      _youtubeController!.value.isFullScreen) {
                    return [];
                  }
                  return <Widget>[
                    SliverAppBar(
                      pinned: true,
                      floating: false,
                      expandedHeight:
                          MediaQuery.of(context).size.height * 0.305,
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          module.name.toUpperCase(),
                          textScaleFactor: 1.3,
                          style: TextStyle(
                            fontFamily: 'Stratum',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
                          indicatorColor: RED,
                          tabs: [
                            Tab(text: "Info".toUpperCase()),
                            Tab(text: "Video".toUpperCase()),
                            Tab(text: "Werkboek".toUpperCase()),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: Container(
                  child: TabBarView(
                    children: [
                      ModuleInfoTab(module: module),
                      ModuleVideoTab(
                        youtubeController: _youtubeController,
                        module: module,
                      ),
                      ModuleQuestionsTab(progress: state.moduleprogress),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Text("Er ging iets fout"),
                    MaterialButton(
                      onPressed: () =>
                          BlocProvider.of<ModuleProgressBloc>(context)
                              .add(ModuleProgressSelected(progressId)),
                      child: Text('Opnieuw laden'),
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
