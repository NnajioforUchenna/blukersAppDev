import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedIndustries {
  static get(context, industryId) {
    if (industryId == "agriculture") {
      return AppLocalizations.of(context)!.agriculture;
    }
    if (industryId == "commercialfishing") {
      return AppLocalizations.of(context)!.commercialfishing;
    }
    if (industryId == "construction") {
      return AppLocalizations.of(context)!.construction;
    }
    if (industryId == "custodialwork") {
      return AppLocalizations.of(context)!.custodialwork;
    }
    if (industryId == "foodandbeverages") {
      return AppLocalizations.of(context)!.foodandbeverages;
    }
    if (industryId == "foodprocessing") {
      return AppLocalizations.of(context)!.foodprocessing;
    }
    if (industryId == "forestry") {
      return AppLocalizations.of(context)!.forestry;
    }
    if (industryId == "industrialconstruction") {
      return AppLocalizations.of(context)!.industrialconstruction;
    }
    if (industryId == "landscaping") {
      return AppLocalizations.of(context)!.landscaping;
    }
    if (industryId == "manufacturing") {
      return AppLocalizations.of(context)!.manufacturing;
    }
    if (industryId == "transportation") {
      return AppLocalizations.of(context)!.transportation;
    }
    if (industryId == "warehousing") {
      return AppLocalizations.of(context)!.warehousing;
    }
    return industryId;
  }
}
