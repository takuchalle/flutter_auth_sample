import 'package:flutter/material.dart';

class Message {
  Message({
    @required this.title,
    @required this.greeting,
    @required this.logout,
  });

  final String title;
  final String greeting;
  final String logout;

  factory Message.of(Locale locale) {
    switch (locale.languageCode) {
      case 'ja':
        return Message.ja();
      case 'en':
        return Message.en();
      default:
        return Message.ja();
    }
  }

  factory Message.ja() => Message(
        title: "こんにちは",
        greeting: "ようこそ",
        logout: 'ログアウト',
      );

  factory Message.en() => Message(
        title: "Hello",
        greeting: "Welcome",
        logout: 'logout',
      );
}

class L10n {
  L10n(Locale locale) : this.message = Message.of(locale);

  final Message message;

  static Message of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n).message;
  }
}

class SampleLocalizationsDelegate extends LocalizationsDelegate<L10n> {
  const SampleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<L10n> load(Locale locale) async => L10n(locale);

  @override
  bool shouldReload(SampleLocalizationsDelegate old) => false;
}
