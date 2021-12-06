import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LicensePackagePage extends StatelessWidget {
  const LicensePackagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text('license'.tr,
          style: GoogleFonts.acme(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('permission_hereby'.tr,
                style: GoogleFonts.abel(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 8,),
              Text('above_copyright'.tr,
                style: GoogleFonts.abel(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 8,),
              Text('software_provided'.tr,
                style: GoogleFonts.abel(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
