import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nineboot/tools/locale_provider.dart';
import 'package:provider/provider.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  late String _locale;
  final Map _languages = {'en': 'English', 'zh_CN': '简体中文'};

  @override
  void initState() {
    super.initState();
    setState(() {
      log('init locale : ' + Intl.getCurrentLocale());
      _locale = Intl.getCurrentLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: const Icon(
            Icons.translate,
            size: 24,
          ),
        ),
        DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: _locale,
          onChanged: (newValue) {
            var codes = newValue!.split('_');
            Locale newLocale;
            if (codes.length == 1) {
              newLocale = Locale.fromSubtags(languageCode: codes[0]);
            } else {
              newLocale = Locale.fromSubtags(
                  languageCode: codes[0], countryCode: codes[1]);
            }

            final provider =
                Provider.of<LocaleProvider>(context, listen: false);
            provider.setLocale(newLocale);
            setState(() {
              _locale = newValue;
              log('change to ' + newValue);
            });
          },
          items: _languages.entries
              .map((e) =>
                  DropdownMenuItem<String>(value: e.key, child: Text(e.value)))
              .toList(),
        )),
      ],
    );
  }
}
