import 'package:freezed_annotation/freezed_annotation.dart';

part 'Membership.freezed.dart';
part 'Membership.g.dart';

@Freezed()
class Membership with _$Membership {
  const factory Membership({
    required String id,
    required String programId,
  }) = _Membership;

  factory Membership.fromJson(Map<String, dynamic> json) =>
      _$MembershipFromJson(json);
}
