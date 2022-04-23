import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:subscription_app/l10n/app_localizations.dart';
import 'package:subscription_app/models/enums.dart';
import 'package:subscription_app/pages/summary_page.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String? _firstName;
  String? _lastName;
  Gender? _gender;
  String? _birthDate;
  String? _booksPicked;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:
              Text(AppLocalizations.of(context)?.title_subscription_page ?? ''),
        ),
        body: _body(context),
      );

  Widget _body(BuildContext context) {
    final children = [
      _firstNameField(context),
      _lastNameField(context),
      _birthDateField(context),
      _genderField(context),
      _booksPickerField(context),
      _submitButton(context),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: children.length,
      itemBuilder: (_, index) => children[index],
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }

  Widget _firstNameField(BuildContext context) => TextField(
        onChanged: (text) {
          setState(() {
            _firstName = text;
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: AppLocalizations.of(context)?.label_first_name ?? '',
          hintText: AppLocalizations.of(context)?.hint_first_name ?? '',
        ),
      );

  Widget _lastNameField(BuildContext context) => TextField(
        onChanged: (text) {
          setState(() {
            _lastName = text;
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: AppLocalizations.of(context)?.label_last_name ?? '',
          hintText: AppLocalizations.of(context)?.hint_last_name ?? '',
        ),
      );

  Widget _birthDateField(BuildContext context) => TextField(
        onChanged: (text) {
          setState(() {
            _birthDate = text;
          });
        },
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today),
          labelText: AppLocalizations.of(context)?.label_birth_date ?? '',
          hintText: AppLocalizations.of(context)?.hint_birth_date ?? '',
        ),
      );

  Widget _genderField(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)?.label_gender ?? ''),
          Row(
            children: Gender.values
                .map(
                  (gender) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio<Gender>(
                        activeColor: Theme.of(context).primaryColor,
                        value: gender,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text(gender.localizedString(context) ?? ''),
                    ],
                  ),
                )
                .toList(growable: false),
          ),
        ],
      );

  Widget _booksPickerField(BuildContext context) => TextField(
        onChanged: (text) {
          setState(() {
            _booksPicked = text;
          });
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: AppLocalizations.of(context)?.label_books_picker ?? '',
          hintText: AppLocalizations.of(context)?.hint_books_picker ?? '',
        ),
      );

  Widget _submitButton(BuildContext context) => ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummaryPage(
              firstName: _firstName ?? '',
              lastName: _lastName ?? '',
              gender: _gender ?? Gender.other,
              birthDate: DateFormat('dd/MM/yyyy').parse(_birthDate ?? ''),
              booksPicked: int.tryParse(_booksPicked ?? '') ?? 0,
            ),
          ),
        ),
        child: Text(AppLocalizations.of(context)?.action_submit ?? ''),
      );
}
