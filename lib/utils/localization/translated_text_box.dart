import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslateTextBox extends StatelessWidget {
  final String text;
  final String fromLanguage;
  final String toLanguage;
  final TextStyle? style;

  const TranslateTextBox({
    super.key,
    required this.text,
    this.fromLanguage = 'en',
    this.toLanguage = 'hi',
    this.style,
  });

  Future<String> _translateText() async {
    final translator = GoogleTranslator();
    var translated = await translator.translate(
      text,
      from: fromLanguage,
      to: toLanguage,
    );
    return translated.text;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _translateText(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Translating...',
            style: style,
          );
        } else if (snapshot.hasError) {
          return Text(
            text,
            style: style,
          );
        } else {
          return Text(
            snapshot.data ?? text,
            style: style,
          );
        }
      },
    );
  }
}
