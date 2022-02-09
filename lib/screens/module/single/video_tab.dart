part of 'module_single_screen.dart';

class ModuleVideoTab extends StatelessWidget {
  final YoutubePlayerController? _youtubeController;
  final Module _module;

  ModuleVideoTab({
    Key? key,
    YoutubePlayerController? youtubeController,
    required Module module,
  })  : _youtubeController = youtubeController,
        _module = module,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_youtubeController == null) {
      return Container(
        child: Text(
          "Deze module heeft geen video",
        ),
      );
    }
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController!,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: Theme.of(context).primaryColor,
            handleColor: Theme.of(context).primaryColorLight,
          ),
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
            ],
          );
        },
      ),
    );
  }
}
