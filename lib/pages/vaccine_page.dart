import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/ui/responsive_safe_area.dart';
import 'package:vaccpass/widgets/display_passport.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/widgets/edit_vaccine.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:vaccpass/core/ui/modal_fit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccpass/core/util/img.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';



class VaccinePage extends StatelessWidget {
  const VaccinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return ResponsiveSafeArea(
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
              color: primaryColor,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text('DISPLAY PASSPORT',
              style: GoogleFonts.lato(
                color: primaryColor,
              )
          ),
        ),
        backgroundColor: primaryColor,
        // backgroundColor: Colors.grey.shade400,
        body: StreamBuilder<List<VaccineEntity>>(
          stream: db.vaccineEntitysDao.watchAllScanByDate(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final scans = snapshot.data??[];
                logger.d('scans: $scans');
                if (scans.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(IMG.empty),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                    itemCount: scans.length,
                    itemBuilder: (context, index) {
                      final scan = scans[index];
                      final hasId = (scan.imageId?.isNotEmpty)??false;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => Get.to(() => DisplayPassport(model: scan)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(MdiIcons.qrcode,
                                          color: primaryColor,
                                          size: 30,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(scan.givenName??'New Passport',
                                              style: const TextStyle(
                                                fontFamily: 'SansSerifFLF',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(DateFormat('dd MMM yyyy').format(scan.date!)),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(color: primaryColor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    child: Row(
                                      children: [
                                        if (hasId)
                                          Image.memory(
                                            appUtils.convertImageBase64(scan.imageId),
                                            height: 30,
                                          )
                                        else
                                          Image.asset(
                                            'assets/images/id.png',
                                            color: primaryColor,
                                            height: 30,
                                          ),
                                        const SizedBox(width: 6),
                                        Text(hasId ? 'update_license_id'.tr : 'add_license_id'.tr,
                                          style: GoogleFonts.acme(
                                              fontSize: 12
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () => showMaterialModalBottomSheet(
                                        expand: false, context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => ModalFit(entity: scan)
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => Get.to(() => EditVaccine(entity: scan)),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          showDialog(context: context, builder: (context) => AlertDialog(
                                            title: Text('delete_item'.tr),
                                            content: Text('confirm_delete'.trArgs([scan.givenName??''])),
                                            actions: [
                                              TextButton(
                                                child: Text('cancel'.tr),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text('delete'.tr),
                                                onPressed: () async {
                                                  await db.vaccineEntitysDao.deleteVaccine(scan);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ));
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
}