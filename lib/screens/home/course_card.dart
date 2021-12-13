part of 'home_screen.dart';

class CourseCard extends StatelessWidget {
  final Enrollment _enrollment;
  final Function()? _onTap;

  const CourseCard({
    Key? key,
    required Enrollment enrollment,
    Function()? onTap,
  })  : _enrollment = enrollment,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: _onTap,
          child: Stack(
            children: [
              S3Image(
                _enrollment.course.coverImage,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width * 0.6,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xff2b8474),
                              width: 3,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4,
                            ),
                            child: Text(
                              "START",
                              style: TextStyle(
                                color: Color(0xff2b8474),
                                fontFamily: "Stratum",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _enrollment.course.name.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Stratum",
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
