import 'package:freezed_annotation/freezed_annotation.dart';

part 'Program.freezed.dart';
part 'Program.g.dart';

@Freezed()
class Program with _$Program {
  const factory Program({
    required String id,
    required String name,
    @Default(true) bool isForSale,
    double? price,
    String? productStoreId,
    required String description,
    required String imageUrl,
    required String productUrl,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
