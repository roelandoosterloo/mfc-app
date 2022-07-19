import 'package:freezed_annotation/freezed_annotation.dart';

part 'Downloadable.freezed.dart';
part 'Downloadable.g.dart';

@Freezed()
class Downloadable with _$Downloadable {
  const factory Downloadable(
      {required String id,
      required String moduleId,
      required String name,
      required String url,
      int? index}) = _Downloadable;

  factory Downloadable.fromJson(Map<String, dynamic> json) =>
      _$DownloadableFromJson(json);
}
