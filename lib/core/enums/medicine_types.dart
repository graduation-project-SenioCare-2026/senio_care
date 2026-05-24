import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MedicineType {
  tablet,
  capsule,
  syrup,
  drops,
  syringe,
  ointment,
  injection,
  cream,
  inhaler,
  patch,
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
      case 'injection':
      case 'syringe':
        return MedicineType.injection;
      case 'cream':
      case 'ointment':
        return MedicineType.cream;
      case 'inhaler':
        return MedicineType.inhaler;
      case 'patch':
        return MedicineType.patch;
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
      case MedicineType.injection:
      case MedicineType.syringe:
        return FontAwesomeIcons.syringe;
      case MedicineType.cream:
      case MedicineType.ointment:
        return FontAwesomeIcons.splotch;
      case MedicineType.inhaler:
        return FontAwesomeIcons.sprayCan;
      case MedicineType.patch:
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
      case MedicineType.injection:
      case MedicineType.syringe:
        return "ml".tr();
      case MedicineType.drops:
        return "drop".tr();
      case MedicineType.cream:
      case MedicineType.ointment:
        return "gm".tr();
      case MedicineType.inhaler:
        return "puff".tr();
      case MedicineType.patch:
        return "patch".tr();
      case MedicineType.unknown:
        return "";
    }
  }
}