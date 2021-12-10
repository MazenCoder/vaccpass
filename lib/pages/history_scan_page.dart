import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/widgets/display_location.dart';
import 'package:vaccpass/widgets/display_passport.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccpass/core/util/img.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';



class HistoryScanPage extends StatelessWidget {
  const HistoryScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'history_scanners'.tr,
            style: GoogleFonts.acme(),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'vaccines'.tr),
              Tab(text: 'locations'.tr),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: [
            VaccineHistory(),
            LocationsHistory(),
          ],
        ),
      ),
    );
  }
}

class VaccineHistory extends StatelessWidget {
  const VaccineHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text('DISPLAY PASSPORT',
          style: GoogleFonts.lato()
        ),
      ),
      body: StreamBuilder<List<ScanEntity>>(
        stream: db.scanEntitysDao.watchAllScanByDate(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              final scans = snapshot.data??[];
              if (scans.isEmpty) {
                return Center(
                  child: Image.asset(IMG.empty),
                );
              } else {
                return ListView.builder(
                  itemCount: scans.length,
                  itemBuilder: (context, index) {
                    final scan = scans[index];
                    return Card(
                      child: ListTile(
                        onTap: () async {
                          Get.to(() => DisplayPassport(model: scan));
                        },
                        trailing: IconButton(
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
                                    await db.scanEntitysDao.deleteScanEntity(scan);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ));
                          },
                        ),
                        leading: const Icon(MdiIcons.qrcode, color: primaryColor),
                        title: Text(scan.givenName??'',
                          style: GoogleFonts.acme(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(DateFormat('dd MMM yyyy').format(scan.date!)),
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}


class LocationsHistory extends StatelessWidget {
  const LocationsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text('DISPLAY LOCATIONS',
            style: GoogleFonts.lato()
        ),
      ),
      body: StreamBuilder<List<TracerEntity>>(
        stream: db.tracerEntitysDao.watchAllTracerByDate(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              final tracers = snapshot.data??[];
              if (tracers.isEmpty) {
                return Center(
                  child: Image.asset(IMG.empty),
                );
              } else {
                return ListView.builder(
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
                                    await db.tracerEntitysDao.deleteTracerEntity(tracer);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ));
                          },
                        ),
                        leading: const Icon(MdiIcons.qrcode, color: primaryColor),
                        title: Text(tracer.opn??'',
                          style: GoogleFonts.acme(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(DateFormat('dd MMM yyyy').format(tracer.date!)),
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}