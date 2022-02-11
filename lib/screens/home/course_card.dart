part of 'home_screen.dart';

enum CourseState {
  locked,
  availble,
  started,
}

class CourseCard extends StatelessWidget {
  final Course _course;
  final Function()? _onTap;
  final CourseState _courseState;
  final bool _isLoading;

  const CourseCard({
    Key? key,
    required Course course,
    Function()? onTap,
    required CourseState courseState,
    bool isLoading = false,
  })  : _course = course,
        _onTap = onTap,
        _courseState = courseState,
        _isLoading = isLoading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AspectRatio(
        aspectRatio: 1.77,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              InkWell(
                onTap: _onTap,
                child: Stack(
                  children: [
                    S3Image(
                      _course.coverImage,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: StatusBadge(
                                state: this._courseState,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Text(
                              _course.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Stratum",
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (_isLoading && _courseState != CourseState.locked)
                Container(
                  color: Colors.white38,
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final CourseState state;

  const StatusBadge({
    Key? key,
    required this.state,
  }) : super(key: key);

  IconData getIcon() {
    switch (state) {
      case CourseState.locked:
        return Icons.lock;
      case CourseState.availble:
        return Icons.play_arrow;
      case CourseState.started:
        return Icons.play_arrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white38,
      radius: 12,
      child: Icon(
        getIcon(),
        size: 18,
      ),
    );
  }
}
