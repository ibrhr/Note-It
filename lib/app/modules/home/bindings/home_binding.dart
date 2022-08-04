import 'package:get/get.dart';
import 'package:notes/app/modules/home/controllers/archived_controller.dart';
import 'package:notes/app/modules/home/controllers/deleted_controller.dart';

import '../../settings/controllers/settings_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(
      SettingsController(),
      permanent: true,
    );
    Get.put<HomeController>(
      HomeController(),
    );
    Get.put<DeletedController>(
      DeletedController(),
    );
    Get.put<ArchivedController>(
      ArchivedController(),
    );
  }
}
