import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:subscription_app/models/enums.dart';

extension Genderl10n on Gender {
  String? localizedString(BuildContext context) => this == Gender.male
      ? AppLocalizations.of(context)?.gender_male
      : this == Gender.female
          ? AppLocalizations.of(context)?.gender_female
          : AppLocalizations.of(context)?.gender_other;
}

extension AppLocalizationsExtension on AppLocalizations {
  String labelWelcome(String firstName, Gender gender) {
    switch (gender) {
      case Gender.male:
        return label_welcome_male(firstName);
      case Gender.female:
        return label_welcome_female(firstName);
      case Gender.other:
        return label_welcome_other(firstName);
    }
  }
}
