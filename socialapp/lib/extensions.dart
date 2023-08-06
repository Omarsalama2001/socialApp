import 'package:flutter/widgets.dart';
import 'package:socialapp/app_localizations.dart';

extension TranslateX on String {
  String tr(BuildContext context, String key) {
    return AppLocalizations.of(context)!.translate(key)!;
  }
}
