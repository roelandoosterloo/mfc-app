// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Membership.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Membership _$MembershipFromJson(Map<String, dynamic> json) {
  return _Membership.fromJson(json);
}

/// @nodoc
class _$MembershipTearOff {
  const _$MembershipTearOff();

  _Membership call({required String id, required String programId}) {
    return _Membership(
      id: id,
      programId: programId,
    );
  }

  Membership fromJson(Map<String, Object?> json) {
    return Membership.fromJson(json);
  }
}

/// @nodoc
const $Membership = _$MembershipTearOff();

/// @nodoc
mixin _$Membership {
  String get id => throw _privateConstructorUsedError;
  String get programId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MembershipCopyWith<Membership> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembershipCopyWith<$Res> {
  factory $MembershipCopyWith(
          Membership value, $Res Function(Membership) then) =
      _$MembershipCopyWithImpl<$Res>;
  $Res call({String id, String programId});
}

/// @nodoc
class _$MembershipCopyWithImpl<$Res> implements $MembershipCopyWith<$Res> {
  _$MembershipCopyWithImpl(this._value, this._then);

  final Membership _value;
  // ignore: unused_field
  final $Res Function(Membership) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MembershipCopyWith<$Res> implements $MembershipCopyWith<$Res> {
  factory _$MembershipCopyWith(
          _Membership value, $Res Function(_Membership) then) =
      __$MembershipCopyWithImpl<$Res>;
  @override
  $Res call({String id, String programId});
}

/// @nodoc
class __$MembershipCopyWithImpl<$Res> extends _$MembershipCopyWithImpl<$Res>
    implements _$MembershipCopyWith<$Res> {
  __$MembershipCopyWithImpl(
      _Membership _value, $Res Function(_Membership) _then)
      : super(_value, (v) => _then(v as _Membership));

  @override
  _Membership get _value => super._value as _Membership;

  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
  }) {
    return _then(_Membership(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Membership implements _Membership {
  const _$_Membership({required this.id, required this.programId});

  factory _$_Membership.fromJson(Map<String, dynamic> json) =>
      _$$_MembershipFromJson(json);

  @override
  final String id;
  @override
  final String programId;

  @override
  String toString() {
    return 'Membership(id: $id, programId: $programId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Membership &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.programId, programId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(programId));

  @JsonKey(ignore: true)
  @override
  _$MembershipCopyWith<_Membership> get copyWith =>
      __$MembershipCopyWithImpl<_Membership>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MembershipToJson(this);
  }
}

abstract class _Membership implements Membership {
  const factory _Membership({required String id, required String programId}) =
      _$_Membership;

  factory _Membership.fromJson(Map<String, dynamic> json) =
      _$_Membership.fromJson;

  @override
  String get id;
  @override
  String get programId;
  @override
  @JsonKey(ignore: true)
  _$MembershipCopyWith<_Membership> get copyWith =>
      throw _privateConstructorUsedError;
}
