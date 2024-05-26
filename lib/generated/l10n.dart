// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get locale {
    return Intl.message(
      'en',
      name: 'locale',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language_code {
    return Intl.message(
      'English',
      name: 'language_code',
      desc: '',
      args: [],
    );
  }

  /// `QR`
  String get qr {
    return Intl.message(
      'QR',
      name: 'qr',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter reservation number`
  String get enter_rezervation_number {
    return Intl.message(
      'Enter reservation number',
      name: 'enter_rezervation_number',
      desc: '',
      args: [],
    );
  }

  /// `Reservation number`
  String get rezervation_number {
    return Intl.message(
      'Reservation number',
      name: 'rezervation_number',
      desc: '',
      args: [],
    );
  }

  /// `Check reservation`
  String get check_rezervation_number {
    return Intl.message(
      'Check reservation',
      name: 'check_rezervation_number',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `IP Address`
  String get ip_address {
    return Intl.message(
      'IP Address',
      name: 'ip_address',
      desc: '',
      args: [],
    );
  }

  /// `Ticket details`
  String get ticket_details {
    return Intl.message(
      'Ticket details',
      name: 'ticket_details',
      desc: '',
      args: [],
    );
  }

  /// `Enter IP address`
  String get enter_ip_address_and_device_id {
    return Intl.message(
      'Enter IP address',
      name: 'enter_ip_address_and_device_id',
      desc: '',
      args: [],
    );
  }

  /// `Enter username`
  String get enter_username {
    return Intl.message(
      'Enter username',
      name: 'enter_username',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Show log`
  String get show_log {
    return Intl.message(
      'Show log',
      name: 'show_log',
      desc: '',
      args: [],
    );
  }

  /// `Authorization error`
  String get auth_login_error {
    return Intl.message(
      'Authorization error',
      name: 'auth_login_error',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get user_validation_password {
    return Intl.message(
      'Incorrect password',
      name: 'user_validation_password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username`
  String get users_not_found_error {
    return Intl.message(
      'Invalid username',
      name: 'users_not_found_error',
      desc: '',
      args: [],
    );
  }

  /// `Please check that you have filled in the server address correctly!`
  String get please_check_connection {
    return Intl.message(
      'Please check that you have filled in the server address correctly!',
      name: 'please_check_connection',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Cinema prefix not specified`
  String get empty_prefix {
    return Intl.message(
      'Cinema prefix not specified',
      name: 'empty_prefix',
      desc: '',
      args: [],
    );
  }

  /// `No connection to server`
  String get no_connection {
    return Intl.message(
      'No connection to server',
      name: 'no_connection',
      desc: '',
      args: [],
    );
  }

  /// `Error!`
  String get error {
    return Intl.message(
      'Error!',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Repertoire`
  String get repertoire {
    return Intl.message(
      'Repertoire',
      name: 'repertoire',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activate {
    return Intl.message(
      'Activate',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Movie`
  String get movie {
    return Intl.message(
      'Movie',
      name: 'movie',
      desc: '',
      args: [],
    );
  }

  /// `Hall`
  String get hall {
    return Intl.message(
      'Hall',
      name: 'hall',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get start_time {
    return Intl.message(
      'Start time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `Row`
  String get row {
    return Intl.message(
      'Row',
      name: 'row',
      desc: '',
      args: [],
    );
  }

  /// `Seats`
  String get seats {
    return Intl.message(
      'Seats',
      name: 'seats',
      desc: '',
      args: [],
    );
  }

  /// `In the hall`
  String get in_the_hall {
    return Intl.message(
      'In the hall',
      name: 'in_the_hall',
      desc: '',
      args: [],
    );
  }

  /// `Tickets`
  String get tickets {
    return Intl.message(
      'Tickets',
      name: 'tickets',
      desc: '',
      args: [],
    );
  }

  /// `Number of tickets`
  String get tickets_count {
    return Intl.message(
      'Number of tickets',
      name: 'tickets_count',
      desc: '',
      args: [],
    );
  }

  /// `Activating seats...`
  String get seats_activating {
    return Intl.message(
      'Activating seats...',
      name: 'seats_activating',
      desc: '',
      args: [],
    );
  }

  /// `Activated`
  String get activated {
    return Intl.message(
      'Activated',
      name: 'activated',
      desc: '',
      args: [],
    );
  }

  /// `All tickets already activated!`
  String get all_tickets_activated {
    return Intl.message(
      'All tickets already activated!',
      name: 'all_tickets_activated',
      desc: '',
      args: [],
    );
  }

  /// `Tickets already activated! ❗`
  String get tickets_activated {
    return Intl.message(
      'Tickets already activated! ❗',
      name: 'tickets_activated',
      desc: '',
      args: [],
    );
  }

  /// `Ticket has been sent for refund.`
  String get tickets_returned {
    return Intl.message(
      'Ticket has been sent for refund.',
      name: 'tickets_returned',
      desc: '',
      args: [],
    );
  }

  /// `New ✅`
  String get new_ticket {
    return Intl.message(
      'New ✅',
      name: 'new_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Successful!`
  String get success {
    return Intl.message(
      'Successful!',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, reservation not found. Please check the entered reservation number and try again.`
  String get reservation_not_found {
    return Intl.message(
      'Sorry, reservation not found. Please check the entered reservation number and try again.',
      name: 'reservation_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Your reservation has been successfully activated.`
  String get congratulation_activate {
    return Intl.message(
      'Congratulations! Your reservation has been successfully activated.',
      name: 'congratulation_activate',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, activation time is available 30 minutes before the session starts. Please try later.`
  String get sorry_dont_activated {
    return Intl.message(
      'Sorry, activation time is available 30 minutes before the session starts. Please try later.',
      name: 'sorry_dont_activated',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, you need to select at least one seat to activate.`
  String get sorry_empty_activate {
    return Intl.message(
      'Sorry, you need to select at least one seat to activate.',
      name: 'sorry_empty_activate',
      desc: '',
      args: [],
    );
  }

  /// `No sessions on the selected date`
  String get empty_seance {
    return Intl.message(
      'No sessions on the selected date',
      name: 'empty_seance',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
