part of 'module_single_screen.dart';

class ModuleVideoTab extends StatelessWidget {
  const ModuleVideoTab({
    Key? key,
    required YoutubePlayerController youtubeController,
  })  : _youtubeController = youtubeController,
        super(key: key);

  final YoutubePlayerController _youtubeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: Theme.of(context).primaryColor,
            handleColor: Theme.of(context).primaryColorLight,
          ),
        ),
        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player,
              ElevatedButton(
                onPressed: () {
                  _youtubeController.toggleFullScreenMode();
                  _youtubeController.play();
                },
                child: Text("full screen"),
              )
            ],
          );
        },
      ),
    );
  }
}
