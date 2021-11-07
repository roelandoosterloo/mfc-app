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
    );
  }
}
