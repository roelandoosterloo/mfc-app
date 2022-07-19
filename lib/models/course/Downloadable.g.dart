// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Downloadable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Downloadable _$$_DownloadableFromJson(Map<String, dynamic> json) =>
    _$_Downloadable(
      id: json['id'] as String,
      moduleId: json['moduleId'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      index: json['index'] as int?,
    );

Map<String, dynamic> _$$_DownloadableToJson(_$_Downloadable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moduleId': instance.moduleId,
      'name': instance.name,
      'url': instance.url,
      'index': instance.index,
    };
