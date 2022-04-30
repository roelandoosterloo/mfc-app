// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Program _$$_ProgramFromJson(Map<String, dynamic> json) => _$_Program(
      id: json['id'] as String,
      name: json['name'] as String,
      isForSale: json['isForSale'] as bool? ?? true,
      price: (json['price'] as num?)?.toDouble(),
      productStoreId: json['productStoreId'] as String?,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      productUrl: json['productUrl'] as String,
    );

Map<String, dynamic> _$$_ProgramToJson(_$_Program instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isForSale': instance.isForSale,
      'price': instance.price,
      'productStoreId': instance.productStoreId,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'productUrl': instance.productUrl,
    };
