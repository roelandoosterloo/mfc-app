// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return _Program.fromJson(json);
}

/// @nodoc
class _$ProgramTearOff {
  const _$ProgramTearOff();

  _Program call(
      {required String id,
      required String name,
      bool isForSale = true,
      double? price,
      String? productStoreId,
      required String description,
      required String imageUrl,
      required String productUrl}) {
    return _Program(
      id: id,
      name: name,
      isForSale: isForSale,
      price: price,
      productStoreId: productStoreId,
      description: description,
      imageUrl: imageUrl,
      productUrl: productUrl,
    );
  }

  Program fromJson(Map<String, Object?> json) {
    return Program.fromJson(json);
  }
}

/// @nodoc
const $Program = _$ProgramTearOff();

/// @nodoc
mixin _$Program {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isForSale => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  String? get productStoreId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get productUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      bool isForSale,
      double? price,
      String? productStoreId,
      String description,
      String imageUrl,
      String productUrl});
}

/// @nodoc
class _$ProgramCopyWithImpl<$Res> implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._value, this._then);

  final Program _value;
  // ignore: unused_field
  final $Res Function(Program) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isForSale = freezed,
    Object? price = freezed,
    Object? productStoreId = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? productUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isForSale: isForSale == freezed
          ? _value.isForSale
          : isForSale // ignore: cast_nullable_to_non_nullable
              as bool,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      productStoreId: productStoreId == freezed
          ? _value.productStoreId
          : productStoreId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      productUrl: productUrl == freezed
          ? _value.productUrl
          : productUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$ProgramCopyWith(_Program value, $Res Function(_Program) then) =
      __$ProgramCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      bool isForSale,
      double? price,
      String? productStoreId,
      String description,
      String imageUrl,
      String productUrl});
}

/// @nodoc
class __$ProgramCopyWithImpl<$Res> extends _$ProgramCopyWithImpl<$Res>
    implements _$ProgramCopyWith<$Res> {
  __$ProgramCopyWithImpl(_Program _value, $Res Function(_Program) _then)
      : super(_value, (v) => _then(v as _Program));

  @override
  _Program get _value => super._value as _Program;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isForSale = freezed,
    Object? price = freezed,
    Object? productStoreId = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? productUrl = freezed,
  }) {
    return _then(_Program(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isForSale: isForSale == freezed
          ? _value.isForSale
          : isForSale // ignore: cast_nullable_to_non_nullable
              as bool,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      productStoreId: productStoreId == freezed
          ? _value.productStoreId
          : productStoreId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      productUrl: productUrl == freezed
          ? _value.productUrl
          : productUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Program implements _Program {
  const _$_Program(
      {required this.id,
      required this.name,
      this.isForSale = true,
      this.price,
      this.productStoreId,
      required this.description,
      required this.imageUrl,
      required this.productUrl});

  factory _$_Program.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @JsonKey()
  @override
  final bool isForSale;
  @override
  final double? price;
  @override
  final String? productStoreId;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  final String productUrl;

  @override
  String toString() {
    return 'Program(id: $id, name: $name, isForSale: $isForSale, price: $price, productStoreId: $productStoreId, description: $description, imageUrl: $imageUrl, productUrl: $productUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Program &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.isForSale, isForSale) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality()
                .equals(other.productStoreId, productStoreId) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality()
                .equals(other.productUrl, productUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isForSale),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(productStoreId),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(productUrl));

  @JsonKey(ignore: true)
  @override
  _$ProgramCopyWith<_Program> get copyWith =>
      __$ProgramCopyWithImpl<_Program>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramToJson(this);
  }
}

abstract class _Program implements Program {
  const factory _Program(
      {required String id,
      required String name,
      bool isForSale,
      double? price,
      String? productStoreId,
      required String description,
      required String imageUrl,
      required String productUrl}) = _$_Program;

  factory _Program.fromJson(Map<String, dynamic> json) = _$_Program.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isForSale;
  @override
  double? get price;
  @override
  String? get productStoreId;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  String get productUrl;
  @override
  @JsonKey(ignore: true)
  _$ProgramCopyWith<_Program> get copyWith =>
      throw _privateConstructorUsedError;
}
