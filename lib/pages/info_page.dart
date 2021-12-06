import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/notifier/model_notifier.dart';
import 'package:vaccpass/core/ui/loading_dialog.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccpass/core/util/img.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'license_package_page.dart';
import 'package:get/get.dart';
import '../main.dart';
import 'dart:io';



class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _version = context.read<ModelNotifier>().version;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('information'.tr,
          style: GoogleFonts.acme(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            const SizedBox(height: 6),
            ListTile(
              title: Text('license'.tr,
                style: GoogleFonts.acme(),
              ),
              subtitle: Text('copyright'.tr,
                style: GoogleFonts.acme(),
              ),
              leading: const Icon(MdiIcons.license),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.to(() => const LicensePackagePage()),
            ),
            const Divider(),
            ListTile(
              title: Text('privacy'.tr,
                style: GoogleFonts.acme(),
              ),
              leading: const Icon(MdiIcons.bookLock),
              // onTap: () => Get.to(() => const AddressPage()),
            ),
            const Divider(),
            ListTile(
              title: Text('rate_app'.tr,
                style: GoogleFonts.acme(),
              ),
              leading: Image.asset(IMG.logo1, width: 35, height: 35),
              onTap: () => rateMyApp.showRateDialog(context),
            ),
            const Divider(),
            ListTile(
              title: Text('clear_history'.tr,
                style: GoogleFonts.acme(),
              ),
              leading: const Icon(MdiIcons.history),
              onTap: () => clearHistory(context),
            ),
            const Divider(),
            ListTile(
              title: Text('version'.trArgs([_version]),
                style: GoogleFonts.acme(),
              ),
              leading: Icon(Platform.isAndroid ?
              Icons.android : MdiIcons.apple),
            ),
          ],
        ),
      ),
    );
  }

  Future clearHistory(BuildContext context) async {
    await showDialog(context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: primaryColor,
          padding: const EdgeInsets.all(14),
          child: Text('history'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            Text('clear_history_msg'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              LoadingDialog.show();
              await appUtils.clearHistory();
              LoadingDialog.hide();
              Navigator.pop(context);
            },
            child: Text('clear'.tr),
          ),
        ],
      ),
    );
  }
}
