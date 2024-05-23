import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';

@JsonSerializable()
class LanguageModel {
  String language;
  String subLanguage;
  String languageCode;

  LanguageModel(
      {required this.language,
      required this.subLanguage,
      required this.languageCode});

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);
}

List<LanguageModel> get languageModelList => [
      LanguageModel(
          language: 'Русский', subLanguage: 'Russian', languageCode: 'ru'),
      LanguageModel(
          language: 'Українська', subLanguage: 'Ukrainian', languageCode: 'uk'),
      LanguageModel(
          language: 'English', subLanguage: 'English', languageCode: 'en'),
    ];
