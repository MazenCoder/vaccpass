import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/database/app_database.dart';
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
    return StreamBuilder<List<ScanEntity>>(
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
                        await showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.symmetric(horizontal: 0),
                            backgroundColor: Colors.white,
                            titlePadding: const EdgeInsets.all(6.0),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                            actionsPadding: const EdgeInsets.all(6.0),
                            buttonPadding: const EdgeInsets.all(6.0),
                            content: SizedBox(
                              height: Get.height/1.5,
                              width: Get.width-50,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    QrImage(
                                      data: scan.encoded??'',
                                      version: QrVersions.auto,
                                      size: Get.width-100,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(scan.givenName??'',
                                          style: GoogleFonts.acme(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 5, height: 5),
                                        Text(DateFormat('dd MMM yyyy').format(scan.dob!),
                                          style: GoogleFonts.acme(
                                            fontSize: 14,
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
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
    );
  }
}


class LocationsHistory extends StatelessWidget {
  const LocationsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return StreamBuilder<List<TracerEntity>>(
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
                      onTap: () async {
                        await showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.symmetric(horizontal: 0),
                            backgroundColor: Colors.white,
                            titlePadding: const EdgeInsets.all(6.0),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                            actionsPadding: const EdgeInsets.all(6.0),
                            buttonPadding: const EdgeInsets.all(6.0),
                            content: SizedBox(
                              height: Get.height/1.5,
                              width: Get.width-50,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    QrImage(
                                      data: tracer.encoded??'',
                                      version: QrVersions.auto,
                                      size: Get.width-100,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(tracer.opn??'',
                                          style: GoogleFonts.acme(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 5, height: 5),
                                        Text(tracer.adr?.replaceAll('\n', ' ')??'',
                                          style: GoogleFonts.acme(
                                            fontSize: 14,
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
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
    );
  }
}