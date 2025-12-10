import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

class CustomUpgraderMessages extends UpgraderMessages {
  CustomUpgraderMessages() : super(code: Get.locale?.languageCode ?? 'en');

  @override
  String get title => languageCode == 'ar' ? 'تحديث التطبيق' : 'Update App';

  @override
  String get body => languageCode == 'ar'
      ? 'هناك إصدار جديد من التطبيق متاح. الرجاء التحديث للاستمرار في استخدام التطبيق.'
      : 'A new version of the app is available. Please update to continue using the app.';

  @override
  String get prompt => languageCode == 'ar'
      ? 'هل تريد التحديث الآن؟'
      : 'Would you like to update now?';

  @override
  String get releaseNotes =>
      languageCode == 'ar' ? 'ملاحظات الإصدار' : 'Release Notes';

  @override
  String get buttonTitleUpdate =>
      languageCode == 'ar' ? 'تحديث الآن' : 'Update Now';

  @override
  String get buttonTitleIgnore => languageCode == 'ar' ? 'تجاهل' : 'Ignore';

  @override
  String get buttonTitleLater => languageCode == 'ar' ? 'لاحقًا' : 'Later';
}
