import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccpass/core/util/img.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';



class HistoryScanPage extends StatelessWidget {
  const HistoryScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'history_scanners'.tr,
          style: GoogleFonts.acme(),
        ),
      ),
      body: StreamBuilder<List<ScanEntity>>(
        stream: db.scanEntitysDao.watchAllScanEntity(),
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
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await db.scanEntitysDao.deleteScanEntity(scan);
                          },
                        ),
                        leading: const Icon(MdiIcons.qrcode, color: primaryColor),
                        title: Text(scan.givenName??''),
                        subtitle: Text(DateFormat('dd MMM yyyy').format(scan.dob!)),
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
