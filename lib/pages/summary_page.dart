import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:subscription_app/l10n/app_localizations.dart';
import 'package:subscription_app/models/enums.dart';

class SummaryPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final Gender gender;
  final DateTime birthDate;
  final int booksPicked;

  const SummaryPage({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
    required this.booksPicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title:
                Text(AppLocalizations.of(context)?.title_summary_page ?? '')),
        body: _body(context),
      );

  Widget _body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeWidget(context),
            _numberOfBooksWidget(context),
            _recapWidget(context),
            _firstNameWidget(context),
            _lastNameWidget(context),
            _birthDateWidget(context),
            _genderWidget(context),
            _priceWidget(context),
          ],
        ),
      );

  Widget _welcomeWidget(BuildContext context) => Text(
        AppLocalizations.of(context)?.labelWelcome(firstName, gender) ?? '',
        style: Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(color: Colors.black),
      );

  Widget _numberOfBooksWidget(BuildContext context) => Text(
        AppLocalizations.of(context)?.label_books_number(booksPicked) ?? '',
        style: Theme.of(context).textTheme.subtitle1,
      );

  Widget _recapWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          AppLocalizations.of(context)?.label_summary ?? '',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.black),
        ),
      );

  Widget _firstNameWidget(BuildContext context) => Row(
        children: [
          RichText(
            text: TextSpan(
              text: AppLocalizations.of(context)?.label_first_name ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                const TextSpan(
                  text: ': ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: firstName,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _lastNameWidget(BuildContext context) => Row(
        children: [
          RichText(
            text: TextSpan(
              text: AppLocalizations.of(context)?.label_last_name ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                const TextSpan(
                  text: ': ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: lastName,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _birthDateWidget(BuildContext context) => Row(
        children: [
          RichText(
            text: TextSpan(
              text: AppLocalizations.of(context)?.label_birth_date ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                const TextSpan(
                  text: ': ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: DateFormat(
                    DateFormat.YEAR_MONTH_DAY,
                    AppLocalizations.of(context)?.localeName ?? '',
                  ).format(birthDate),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _genderWidget(BuildContext context) => Row(
        children: [
          RichText(
            text: TextSpan(
              text: AppLocalizations.of(context)?.label_gender ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                const TextSpan(
                  text: ': ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: gender.localizedString(context),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _priceWidget(BuildContext context) => Row(
        children: [
          RichText(
            text: TextSpan(
              text: AppLocalizations.of(context)?.label_price ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                const TextSpan(
                  text: ': ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: NumberFormat.currency(
                    symbol: '€',
                    decimalDigits: 2,
                    locale: AppLocalizations.of(context)?.localeName ?? '',
                  ).format(booksPicked * 3.12),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      );
}
