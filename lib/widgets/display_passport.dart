import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';



class DisplayPassport extends StatelessWidget {
  final VaccineEntity model;
  const DisplayPassport({required this.model, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.givenName??'',
          maxLines: 1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: false, // Set it to false to prevent panning.
          boundaryMargin: const EdgeInsets.all(80),
          minScale: 0.5,
          child: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                if (model.encoded != null && model.encoded!.isNotEmpty)
                  Expanded(
                    child: QrImage(
                      data: model.encoded??'',
                      version: QrVersions.auto,
                      // size: Get.width-100,
                    ),
                  )
                else if (model.imageVaccine != null && model.imageVaccine!.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(
                        appUtils.convertImageBase64(model.imageVaccine),
                        // height: 30,
                      ),
                    ),
                  ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (model.givenName != null && model.givenName!.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(model.givenName??'',
                        style: GoogleFonts.acme(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],

                    const SizedBox(height: 5),
                    Text(DateFormat('dd MMM yyyy').format(model.dob!),
                      style: GoogleFonts.acme(
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 8,),
                if (model.imageId != null && model.imageId!.isNotEmpty)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(
                        appUtils.convertImageBase64(model.imageId),
                        // height: 30,
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
      /*
      body: FutureBuilder<File>(
        future: getPdf(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: PDFView(
                filePath: snapshot.data!.path,
                autoSpacing: false,
                pageFling: false,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

       */
    );
  }
}
