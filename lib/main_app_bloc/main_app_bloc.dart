import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ticket_prod_v2/main.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

part 'main_app_event.dart';
part 'main_app_state.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  final SettingsRepository _settingsRepository = SettingsRepository();

  MainAppBloc() : super(MainAppState.initial()) {
    on<MainGetSavedLocaleEvent>(_getLanguage);
    on<MainChangeLocaleEvent>(_changeLanguage);
  }

  Future<void> _changeLanguage(
      MainChangeLocaleEvent event, Emitter<MainAppState> emit) async {
    if (event.locale == state.locale) return;
    _saveLocale(event.locale);
    emit(MainAppState(event.locale));
  }

  Future<void> _getLanguage(
      MainGetSavedLocaleEvent event, Emitter<MainAppState> emit) async {
    Locale savedLocal = await _getLocale();
    emit(MainAppState(savedLocal));
  }

  Future<void> _saveLocale(Locale locale) async {
    final settingsModel = await _settingsRepository.getSettings();
    settingsModel.languageModel?.languageCode = locale.languageCode;
    if (locale.languageCode == 'ru' || locale.languageCode == 'en') {
      settingsModel.env = Environment.PRODUCTION;
    } else {
      settingsModel.env = Environment.PRODUCTION_UA;
    }
    await _settingsRepository.saveSettings(settingsModel);
  }

  Future<Locale> _getLocale() async {
    final settingsModel = await _settingsRepository.getSettings();
    final env = await _settingsRepository.getEnv();
    String languageCode = '';
    switch (env) {
      case Environment.PRODUCTION:
        languageCode = 'ru';
      case Environment.PRODUCTION_UA:
        languageCode = 'uk';
      default:
        languageCode = 'en';
    }
    return Locale(settingsModel.languageModel?.languageCode ?? languageCode);
  }
}
