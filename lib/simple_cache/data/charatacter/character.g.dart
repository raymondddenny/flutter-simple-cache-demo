// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CharacterModel _$$_CharacterModelFromJson(Map<String, dynamic> json) =>
    _$_CharacterModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CharacterModelToJson(_$_CharacterModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

_$_CharacterData _$$_CharacterDataFromJson(Map<String, dynamic> json) =>
    _$_CharacterData(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: Origin.fromJson(json['origin'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
    );

Map<String, dynamic> _$$_CharacterDataToJson(_$_CharacterData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
    };

_$_Origin _$$_OriginFromJson(Map<String, dynamic> json) => _$_Origin(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_OriginToJson(_$_Origin instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

_$_Location _$$_LocationFromJson(Map<String, dynamic> json) => _$_Location(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_LocationToJson(_$_Location instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
