import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedJobTypes {
  static get(context, jobTypeId) {
    if (jobTypeId == "fullTime") {
      return AppLocalizations.of(context)!.fullTime;
    }
    if (jobTypeId == "partTime") {
      return AppLocalizations.of(context)!.partTime;
    }
    if (jobTypeId == "contract") {
      return AppLocalizations.of(context)!.contract;
    }
    if (jobTypeId == "specifiedTime") {
      return AppLocalizations.of(context)!.specifiedTime;
    }
    if (jobTypeId == "fullTimePermanent") {
      return AppLocalizations.of(context)!.fullTimePermanent;
    }
    if (jobTypeId == "fullTimeTemporary") {
      return AppLocalizations.of(context)!.fullTimeTemporary;
    }
    if (jobTypeId == "internship") {
      return AppLocalizations.of(context)!.internship;
    }
    return jobTypeId;
  }
}
