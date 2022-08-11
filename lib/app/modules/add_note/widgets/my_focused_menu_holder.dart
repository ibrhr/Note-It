import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:note_it/app/modules/settings/controllers/settings_controller.dart';

import '../../../constants/exports.dart';

class MyFocusedMenuHolder extends StatelessWidget {
  const MyFocusedMenuHolder({
    Key? key,
    required this.child,
    required this.items,
  }) : super(key: key);

  final Widget child;
  final List<FocusedMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      blurSize: 5.0,
      menuItemExtent: 45,
      menuBoxDecoration: BoxDecoration(
          color: Get.find<SettingsController>().isDarkMode
              ? ColorManager.appBarDark
              : ColorManager.appBarLight,
          borderRadius: const BorderRadius.all(Radius.circular(15.0))),
      duration: const Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: Colors.black54,
      openWithTap: true, // Open Focused-Menu on Tap rather than Long Press
      menuOffset: 10.0, // Offset value to show menuItem from the selected item
      bottomOffsetHeight:
          80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
      menuItems:
          // Add Each FocusedMenuItem  for Menu Options
          items,
      onPressed: () {},
      child: child,
    );
  }
}
