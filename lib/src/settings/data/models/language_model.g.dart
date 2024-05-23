// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) =>
    LanguageModel(
      language: json['language'] as String,
      subLanguage: json['subLanguage'] as String,
      languageCode: json['languageCode'] as String,
    );

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      'language': instance.language,
      'subLanguage': instance.subLanguage,
      'languageCode': instance.languageCode,
    };
