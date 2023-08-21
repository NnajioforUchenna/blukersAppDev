import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedJobs {
  static get(context, jobId) {
    // CONSTRUCTION

    if (jobId == "carpenter") {
      return AppLocalizations.of(context)!.carpenter;
    }
    if (jobId == "electrician") {
      return AppLocalizations.of(context)!.electrician;
    }
    if (jobId == "mason") {
      return AppLocalizations.of(context)!.mason;
    }
    if (jobId == "painter") {
      return AppLocalizations.of(context)!.painter;
    }
    if (jobId == "plumber") {
      return AppLocalizations.of(context)!.plumber;
    }

    return jobId;
  }
}
