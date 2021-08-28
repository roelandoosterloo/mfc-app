import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/module/module_bloc.dart';
import 'package:mfc_app/models/course/Module.dart';
// import 'package:mfc_app/models/quiz.dart' as quiz;
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
  final PageController controller = PageController(initialPage: 0);

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
          // return SafeArea(
          //   child: Scaffold(
          //     extendBodyBehindAppBar: true,
          //     appBar: AppBar(
          //       elevation: 0,
          //       backgroundColor: Colors.transparent,
          //     ),
          //     body: Container(
          //       child: YoutubePlayerBuilder(
          //         player: YoutubePlayer(
          //           controller: _youtubeController,
          //           showVideoProgressIndicator: true,
          //         ),
          //         builder: (context, player) {
          //           return Column(
          //             children: [
          //               player,
          //               Expanded(
          //                 child: SingleChildScrollView(
          //                   padding: EdgeInsets.symmetric(horizontal: 16),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         module.name,
          //                         style: Theme.of(context).textTheme.headline4,
          //                       ),
          //                       TabBar(tabs: [

          //                       ],)
          //                       Expanded(
          //                         flex: 1,
          //                         child: Text(
          //                           module.description,
          //                           style:
          //                               Theme.of(context).textTheme.bodyText1,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // );
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
                  Container(
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
                                  module.coverImage ??
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
                                module.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(module.description),
                          ),
                        ),
                      ],
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
                  PageView(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    children: module.assignments
                            ?.map((q) => QuestionW(
                                  question: q,
                                  key: Key(q.id),
                                ))
                            .toList() ??
                        [],
                  ),
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
