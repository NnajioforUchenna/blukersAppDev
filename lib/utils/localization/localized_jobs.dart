import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedJobs {
  static get(context, jobId) {
    // AGRICULTURE

    if (jobId == "agriculturaltechnician") {
      return AppLocalizations.of(context)!.agriculturaltechnician;
    }
    if (jobId == "cropconsultant") {
      return AppLocalizations.of(context)!.cropconsultant;
    }
    if (jobId == "farmer") {
      return AppLocalizations.of(context)!.farmer;
    }
    if (jobId == "farmlaborer") {
      return AppLocalizations.of(context)!.farmlaborer;
    }

    // COMMERCIAL FISHING

    if (jobId == "deckhand") {
      return AppLocalizations.of(context)!.deckhand;
    }
    if (jobId == "fisherman") {
      return AppLocalizations.of(context)!.fisherman;
    }
    if (jobId == "fishingvesselcaptain") {
      return AppLocalizations.of(context)!.fishingvesselcaptain;
    }
    if (jobId == "fishprocessingworker") {
      return AppLocalizations.of(context)!.fishprocessingworker;
    }

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

    // CUSTODIAL WORK

    if (jobId == "cleaner") {
      return AppLocalizations.of(context)!.cleaner;
    }
    if (jobId == "floortechnician") {
      return AppLocalizations.of(context)!.floortechnician;
    }
    if (jobId == "housekeepingsupervisor") {
      return AppLocalizations.of(context)!.housekeepingsupervisor;
    }
    if (jobId == "janitor") {
      return AppLocalizations.of(context)!.janitor;
    }

    // FOOD AND BEVERAGES

    if (jobId == "bartender") {
      return AppLocalizations.of(context)!.bartender;
    }
    if (jobId == "cashier") {
      return AppLocalizations.of(context)!.cashier;
    }
    if (jobId == "cook") {
      return AppLocalizations.of(context)!.cook;
    }
    if (jobId == "cookhelper") {
      return AppLocalizations.of(context)!.cookhelper;
    }
    if (jobId == "dishwasher") {
      return AppLocalizations.of(context)!.dishwasher;
    }
    if (jobId == "host") {
      return AppLocalizations.of(context)!.host;
    }

    // FOOD PROCESSING

    if (jobId == "foodtechnologist") {
      return AppLocalizations.of(context)!.foodtechnologist;
    }
    if (jobId == "packagingoperator") {
      return AppLocalizations.of(context)!.packagingoperator;
    }
    if (jobId == "productionsupervisor") {
      return AppLocalizations.of(context)!.productionsupervisor;
    }
    if (jobId == "qualityassuranceinspector") {
      return AppLocalizations.of(context)!.qualityassuranceinspector;
    }

    // FORESTRY

    if (jobId == "forester") {
      return AppLocalizations.of(context)!.forester;
    }
    if (jobId == "loggingequipmentoperator") {
      return AppLocalizations.of(context)!.loggingequipmentoperator;
    }
    if (jobId == "timbercruiser") {
      return AppLocalizations.of(context)!.timbercruiser;
    }
    if (jobId == "treeplanter") {
      return AppLocalizations.of(context)!.treeplanter;
    }

    // INDUSTRIAL CONSTRUCTION

    if (jobId == "pipefitter") {
      return AppLocalizations.of(context)!.pipefitter;
    }
    if (jobId == "sandblaster") {
      return AppLocalizations.of(context)!.sandblaster;
    }
    if (jobId == "structuralwelder") {
      return AppLocalizations.of(context)!.structuralwelder;
    }

    // LANDSCAPING

    if (jobId == "gardener") {
      return AppLocalizations.of(context)!.gardener;
    }
    if (jobId == "irrigationspecialist") {
      return AppLocalizations.of(context)!.irrigationspecialist;
    }
    if (jobId == "landscapedesigner") {
      return AppLocalizations.of(context)!.landscapedesigner;
    }
    if (jobId == "treesurgeon") {
      return AppLocalizations.of(context)!.treesurgeon;
    }

    // MANUFACTURING

    if (jobId == "assemblylineworker") {
      return AppLocalizations.of(context)!.assemblylineworker;
    }
    if (jobId == "machineoperator") {
      return AppLocalizations.of(context)!.machineoperator;
    }
    if (jobId == "qualitycontrolinspector") {
      return AppLocalizations.of(context)!.qualitycontrolinspector;
    }

    // TRANSPORTATION

    if (jobId == "courier") {
      return AppLocalizations.of(context)!.courier;
    }
    if (jobId == "deliverydriver") {
      return AppLocalizations.of(context)!.deliverydriver;
    }
    if (jobId == "dispatcher") {
      return AppLocalizations.of(context)!.dispatcher;
    }
    if (jobId == "taxidriver") {
      return AppLocalizations.of(context)!.taxidriver;
    }
    if (jobId == "truckdriver") {
      return AppLocalizations.of(context)!.truckdriver;
    }

    // WAREHOUSING

    if (jobId == "forkliftoperator") {
      return AppLocalizations.of(context)!.forkliftoperator;
    }
    if (jobId == "inventoryclerk") {
      return AppLocalizations.of(context)!.inventoryclerk;
    }
    if (jobId == "packer") {
      return AppLocalizations.of(context)!.packer;
    }
    if (jobId == "warehousemanager") {
      return AppLocalizations.of(context)!.warehousemanager;
    }

    //

    return jobId;
  }
}
