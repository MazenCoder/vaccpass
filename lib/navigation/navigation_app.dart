import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/ui/responsive_safe_area.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vaccpass/pages/history_scan_page.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:vaccpass/widgets/modal_scan.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vaccpass/pages/info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NavigationApp extends StatefulWidget {
  final int jumpIndex;
  const NavigationApp({Key? key, this.jumpIndex = 0}) : super(key: key);

  @override
  _NavigationAppState createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {

  final PageController _pageController = PageController();

  Future<bool> _onWillPop(BuildContext context) async {
    if (mobxApp.currentIndex != 0) {
      mobxApp.onPageChanged(0);
      _pageController.jumpToPage(mobxApp.currentIndex);
      return Future.value(false);
    } else {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16, horizontal: 8,
            ),
            color: primaryColor,
            child: Text("app_name".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          content: Text('exit_app'.tr,
            style: const TextStyle(
              color: taigaColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('cancel'.tr,
                style: const TextStyle(
                  color: taigaColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('exit'.tr,
                style: const TextStyle(
                  color: taigaColor,
                ),
              ),
            ),
          ],
        ),
      )??false;
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return ResponsiveSafeArea(
      builder: (context) => WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                HistoryScanPage(),
                SizedBox.shrink(),
                InfoPage(),
                // AccountPage(),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: isKeyboardShowing ? null : FloatingActionButton(
            heroTag: UniqueKey(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: const Icon(MdiIcons.qrcode, color: Colors.white),
            // onPressed: () => Get.to(() => const ScanQrPage()),
            onPressed: () => showMaterialModalBottomSheet(
                expand: false, context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => const ModalScan()
            ),
          ),
          bottomNavigationBar: Observer(
            builder: (_) => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: primaryColor,
              // unselectedItemColor: taigaColor,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              currentIndex: mobxApp.currentIndex,
              onTap: (index) {
                if (index == 1) {
                  // Get.to(() => const ScanQrPage());
                  showMaterialModalBottomSheet(
                      expand: false, context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ModalScan()
                  );
                } else {
                  mobxApp.onPageChanged(index);
                  _pageController.jumpToPage(index);
                }
              },
              items: [
                BottomNavigationBarItem(
                  activeIcon: const Icon(MdiIcons.history, color: primaryColor),
                  icon: const Icon(MdiIcons.history),
                  label: 'history'.tr,
                ),

                const BottomNavigationBarItem(
                  activeIcon:  Icon(MdiIcons.qrcode, color: Colors.white),
                  icon: Icon(MdiIcons.qrcode, color: Colors.white),
                  label: 'Scan',
                ),

                BottomNavigationBarItem(
                  activeIcon: const Icon(MdiIcons.information, color: primaryColor),
                  icon: const Icon(MdiIcons.information),
                  label: 'info'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}