abstract class Model {
  String getId();

  bool operator ==(Object other);

  Map<String, dynamic> toJson();

  const Model();

  @override
  int get hashCode => super.hashCode;
}
