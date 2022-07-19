// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Downloadable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Downloadable _$DownloadableFromJson(Map<String, dynamic> json) {
  return _Downloadable.fromJson(json);
}

/// @nodoc
mixin _$Downloadable {
  String get id => throw _privateConstructorUsedError;
  String get moduleId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DownloadableCopyWith<Downloadable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadableCopyWith<$Res> {
  factory $DownloadableCopyWith(
          Downloadable value, $Res Function(Downloadable) then) =
      _$DownloadableCopyWithImpl<$Res>;
  $Res call({String id, String moduleId, String name, String url, int? index});
}

/// @nodoc
class _$DownloadableCopyWithImpl<$Res> implements $DownloadableCopyWith<$Res> {
  _$DownloadableCopyWithImpl(this._value, this._then);

  final Downloadable _value;
  // ignore: unused_field
  final $Res Function(Downloadable) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? moduleId = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      moduleId: moduleId == freezed
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$DownloadableCopyWith<$Res>
    implements $DownloadableCopyWith<$Res> {
  factory _$DownloadableCopyWith(
          _Downloadable value, $Res Function(_Downloadable) then) =
      __$DownloadableCopyWithImpl<$Res>;
  @override
  $Res call({String id, String moduleId, String name, String url, int? index});
}

/// @nodoc
class __$DownloadableCopyWithImpl<$Res> extends _$DownloadableCopyWithImpl<$Res>
    implements _$DownloadableCopyWith<$Res> {
  __$DownloadableCopyWithImpl(
      _Downloadable _value, $Res Function(_Downloadable) _then)
      : super(_value, (v) => _then(v as _Downloadable));

  @override
  _Downloadable get _value => super._value as _Downloadable;

  @override
  $Res call({
    Object? id = freezed,
    Object? moduleId = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? index = freezed,
  }) {
    return _then(_Downloadable(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      moduleId: moduleId == freezed
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Downloadable implements _Downloadable {
  const _$_Downloadable(
      {required this.id,
      required this.moduleId,
      required this.name,
      required this.url,
      this.index});

  factory _$_Downloadable.fromJson(Map<String, dynamic> json) =>
      _$$_DownloadableFromJson(json);

  @override
  final String id;
  @override
  final String moduleId;
  @override
  final String name;
  @override
  final String url;
  @override
  final int? index;

  @override
  String toString() {
    return 'Downloadable(id: $id, moduleId: $moduleId, name: $name, url: $url, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Downloadable &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.moduleId, moduleId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(moduleId),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  _$DownloadableCopyWith<_Downloadable> get copyWith =>
      __$DownloadableCopyWithImpl<_Downloadable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DownloadableToJson(this);
  }
}

abstract class _Downloadable implements Downloadable {
  const factory _Downloadable(
      {required final String id,
      required final String moduleId,
      required final String name,
      required final String url,
      final int? index}) = _$_Downloadable;

  factory _Downloadable.fromJson(Map<String, dynamic> json) =
      _$_Downloadable.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get moduleId => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  int? get index => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DownloadableCopyWith<_Downloadable> get copyWith =>
      throw _privateConstructorUsedError;
}
