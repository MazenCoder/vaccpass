import 'package:vaccpass/pages/locations_page.dart';
import 'package:vaccpass/pages/vaccine_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
            VaccinePage(),
            LocationsPage(),
          ],
        ),
      ),
    );
  }
}



