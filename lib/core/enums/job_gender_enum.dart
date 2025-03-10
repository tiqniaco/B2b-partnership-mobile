import 'package:get/get.dart';

enum JobGenderEnum {
  male,
  female,
  any,
}

extension JobGenderEnumExtension on JobGenderEnum {
  String get text {
    switch (this) {
      case JobGenderEnum.male:
        return "Male".tr;
      case JobGenderEnum.female:
        return "Female".tr;
      case JobGenderEnum.any:
        return "Any".tr;
    }
  }
}
