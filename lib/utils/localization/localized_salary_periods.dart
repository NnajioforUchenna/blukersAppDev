import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedSalaryPeriods {
  static get(context, salaryPeriodId) {
    if (salaryPeriodId == "hourly") {
      return AppLocalizations.of(context)!.hourly;
    }
    if (salaryPeriodId == "daily") {
      return AppLocalizations.of(context)!.daily;
    }
    if (salaryPeriodId == "monthly") {
      return AppLocalizations.of(context)!.monthly;
    }
    if (salaryPeriodId == "yearly") {
      return AppLocalizations.of(context)!.yearly;
    }
    return salaryPeriodId;
  }
}
