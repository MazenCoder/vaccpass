import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/ui/responsive_safe_area.dart';
import 'package:vaccpass/widgets/display_location.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccpass/core/util/img.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';




class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return ResponsiveSafeArea(
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text('DISPLAY LOCATIONS',
            style: GoogleFonts.lato(
              color: primaryColor,
            )
          ),
        ),
        backgroundColor: primaryColor,
        body: StreamBuilder<List<LocationEntity>>(
          stream: db.locationEntitysDao.watchAllLocationByDate(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final tracers = snapshot.data??[];
                if (tracers.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(IMG.empty),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                    itemCount: tracers.length,
                    itemBuilder: (context, index) {
                      final tracer = tracers[index];
                      return Card(
                        child: ListTile(
                          onTap: () => Get.to(() => DisplayLocation(model: tracer)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              showDialog(context: context, builder: (context) => AlertDialog(
                                title: Text('delete_item'.tr),
                                content: Text('confirm_delete'.trArgs([tracer.opn??''])),
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
                                      await db.locationEntitysDao.deleteLocation(tracer);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ));
                            },
                          ),
                          leading: const Icon(MdiIcons.qrcode, color: primaryColor),
                          title: Text(tracer.opn??'',
                            style: const TextStyle(
                              fontFamily: 'SansSerifFLF',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          subtitle: Text(DateFormat('dd MMM yyyy hh:mm a').format(tracer.date!)),
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