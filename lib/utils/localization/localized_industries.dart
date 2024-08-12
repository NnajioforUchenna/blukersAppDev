import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedIndustries {
  static Map<String, String Function(BuildContext)> industryMap = {
    'pipewelder': (context) => AppLocalizations.of(context)!.pipewelder,
    'woodworker': (context) => AppLocalizations.of(context)!.woodworker,
    'farming': (context) => AppLocalizations.of(context)!.farming,
    'safety_representative': (context) =>
        AppLocalizations.of(context)!.safety_representative,
    'lscaping': (context) => AppLocalizations.of(context)!.lscaping,
    'construction__extraction': (context) =>
        AppLocalizations.of(context)!.construction__extraction,
    'glaziers': (context) => AppLocalizations.of(context)!.glaziers,
    'carpentry': (context) => AppLocalizations.of(context)!.carpentry,
    'fitter': (context) => AppLocalizations.of(context)!.fitter,
    'welding': (context) => AppLocalizations.of(context)!.welding,
    'painter_s_blaster': (context) =>
        AppLocalizations.of(context)!.painter_s_blaster,
    'scaffolder': (context) => AppLocalizations.of(context)!.scaffolder,
    'maintenance': (context) => AppLocalizations.of(context)!.maintenance,
    'elevator__escalator_installers': (context) =>
        AppLocalizations.of(context)!.elevator__escalator_installers,
    'construction_building': (context) =>
        AppLocalizations.of(context)!.construction_building,
    'roofer': (context) => AppLocalizations.of(context)!.roofer,
    'project_manager': (context) =>
        AppLocalizations.of(context)!.project_manager,
    'electrician_industrial': (context) =>
        AppLocalizations.of(context)!.electrician_industrial,
    'record_clerk': (context) => AppLocalizations.of(context)!.record_clerk,
    'construction': (context) => AppLocalizations.of(context)!.construction,
    'machinist': (context) => AppLocalizations.of(context)!.machinist,
    'general_laborer': (context) =>
        AppLocalizations.of(context)!.general_laborer,
    'food_preparation': (context) =>
        AppLocalizations.of(context)!.food_preparation,
    'carpet_installers': (context) =>
        AppLocalizations.of(context)!.carpet_installers,
    'driver': (context) => AppLocalizations.of(context)!.driver,
    'cement_masons': (context) => AppLocalizations.of(context)!.cement_masons,
    'hazardous_material_removal': (context) =>
        AppLocalizations.of(context)!.hazardous_material_removal,
    'fishing': (context) => AppLocalizations.of(context)!.fishing,
    'equipment': (context) => AppLocalizations.of(context)!.equipment,
    'floor_senders__finishers': (context) =>
        AppLocalizations.of(context)!.floor_senders__finishers,
    'structural_iron__steel': (context) =>
        AppLocalizations.of(context)!.structural_iron__steel,
    'aircraft_mechanic': (context) =>
        AppLocalizations.of(context)!.aircraft_mechanic,
    'production': (context) => AppLocalizations.of(context)!.production,
    'excavating__loading_machine__dragline_operators': (context) =>
        AppLocalizations.of(context)!
            .excavating__loading_machine__dragline_operators,
    'update': (context) => AppLocalizations.of(context)!.update,
    'delete': (context) => AppLocalizations.of(context)!.delete,
    'noworkersfound': (context) => AppLocalizations.of(context)!.noworkersfound,
  };

  static String convert2Keyword(String title) {
    return title
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('/', '_')
        .replaceAll('and', '');
  }

  static get(BuildContext context, String industryId) {
    String keyWord = convert2Keyword(industryId);
    return industryMap[keyWord]?.call(context) ?? industryId;
  }
}
