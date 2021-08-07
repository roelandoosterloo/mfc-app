import 'package:mfc_app/models/quiz.dart';

class Module {
  String id;
  String name;
  int index;
  String? topic;
  String text;
  String? coverImageUrl;
  String? videoUrl;
  List<Question>? assignments;

  Module({
    required this.id,
    required this.name,
    required this.index,
    this.topic,
    required this.text,
    this.coverImageUrl,
    this.videoUrl,
    this.assignments,
  });

  Module.fromJson(String id, Map<String, dynamic> json)
      : this(
          id: id,
          name: json['name'],
          index: json['index'] as int,
          topic: json['topic'],
          text: json['text'],
          coverImageUrl: json['coverImageUrl'],
          videoUrl: json['videoUrl'],
        );

  @override
  String toString() {
    return "Module { id: $id, name: $name, index: $index, topic: $topic, }";
  }
}

class Course {
  String id;
  String name;
  String? description;
  String? duration;
  String? coverImageUrl;
  List<Module>? modules;

  Course({
    required this.id,
    required this.name,
    this.duration,
    this.description,
    this.coverImageUrl,
    this.modules,
  });

  Map<String, Object?> toJson() {
    throw UnimplementedError();
  }

  Course.fromJson(String id, Map<String, dynamic> json)
      : this(
          id: id,
          name: json['name'],
          duration: json['duration'],
          description: json['description'],
          coverImageUrl: json['coverImageUrl'],
        );
}
