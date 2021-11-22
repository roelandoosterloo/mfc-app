part of "question.dart";

class ShortTextQuestion extends StatelessWidget {
  final Question _question;
  final TextEditingController _controller;

  const ShortTextQuestion({
    Key? key,
    required Question question,
    required TextEditingController controller,
  })  : _question = question,
        _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _question.question,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (_question.introduction != null)
            Text(
              _question.introduction!,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Your Answer",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )),
            controller: _controller,
          )
        ],
      ),
    );
  }
}
