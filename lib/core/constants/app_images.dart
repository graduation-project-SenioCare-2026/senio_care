abstract final class AppImages {
  static const String baseAppImagePath = "assets/images";

  static const String authBg = "$baseAppImagePath/auth_bg_org.png";
  static const String mobilityState1="$baseAppImagePath/independent.png";
  static const String mobilityState2="$baseAppImagePath/use_wheelchair.png";
  static const String mobilityState3="$baseAppImagePath/use_walker.png";
  static const String mobilityState4="$baseAppImagePath/need_assistance.png";
  static const List<String> mobilityStates = [
    mobilityState1,
    mobilityState3,
    mobilityState2,
    mobilityState4,
  ];
}
