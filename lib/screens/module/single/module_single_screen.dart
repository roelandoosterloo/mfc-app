import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/module/module_bloc.dart';
import 'package:mfc_app/models/course.dart';
import 'package:mfc_app/widgets/loading.dart';
import 'package:mfc_app/widgets/question.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
                    Tab(
                      text: "Info",
                    ),
                    Tab(text: "Video"),
                    Tab(text: "Opdrachten"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Container(
                    child: SingleChildScrollView(
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
                                  child: Image.network(
                                    module.coverImageUrl ??
                                        "https://placeimg.com/1000/600/any",
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
                                  module.topic ?? "",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Text(module.text),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                      ),
                      builder: (context, player) {
                        return Column(
                          children: [
                            player,
                            SizedBox(
                              height: 300,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Column(
                    children: module.assignments
                            ?.map((q) => Question(
                                  question: q,
                                  key: Key(q.id),
                                ))
                            .toList() ??
                        [],
                    // [
                    //   Question(
                    //     question: quiz.Question(
                    //       id: "1",
                    //       questionText: "Hoe lang is een chinees?",
                    //       type: quiz.QuestionType.singleChoice,
                    //       options: [
                    //         quiz.Option("12.34", label: "12.34 m"),
                    //         quiz.Option("23.45", label: "23.45 m"),
                    //         quiz.Option("34.56", label: "34.56 m"),
                    //         quiz.Option("45.67", label: "45.67 m"),
                    //       ],
                    //     ),
                    //   ),
                    //   Question(
                    //     question: quiz.Question(
                    //       id: "1",
                    //       type: quiz.QuestionType.longText,
                    //       questionText: "Hoe lang is een chinees?",
                    //     ),
                    //   ),
                    // ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              child: Text("weird state"),
            ),
          );
        }
      },
    );
  }
}
