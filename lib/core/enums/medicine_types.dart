import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MedicineType {
  tablet,
  capsule,
  syrup,
  drops,
  syringe,
  ointment,
  unknown,
}

extension MedicineTypeX on MedicineType {
  static MedicineType fromString(String? type) {
    switch (type?.toLowerCase()) {
      case 'tablet':
        return MedicineType.tablet;
      case 'capsule':
        return MedicineType.capsule;
      case 'syrup':
        return MedicineType.syrup;
      case 'drops':
        return MedicineType.drops;
      case 'syringe':
        return MedicineType.syringe;
      case 'ointment':
        return MedicineType.ointment;
      default:
        return MedicineType.unknown;
    }
  }

  FaIconData get icon {
    switch (this) {
      case MedicineType.tablet:
        return FontAwesomeIcons.tablets;
      case MedicineType.capsule:
        return FontAwesomeIcons.capsules;
      case MedicineType.syrup:
        return FontAwesomeIcons.glassWater;
      case MedicineType.drops:
        return FontAwesomeIcons.droplet;
      case MedicineType.syringe:
        return FontAwesomeIcons.syringe;
      case MedicineType.ointment:
        return FontAwesomeIcons.bandage;
      case MedicineType.unknown:
        return FontAwesomeIcons.pills;
    }
  }

  String getUnit() {
    switch (this) {
      case MedicineType.tablet:
        return "tablet".tr();
      case MedicineType.capsule:
        return "capsule".tr();
      case MedicineType.syrup:
      case MedicineType.syringe:
        return "ml".tr();
      case MedicineType.drops:
        return "drop".tr();
      case MedicineType.ointment:
        return "gm".tr();
      case MedicineType.unknown:
        return "";
    }
  }
}