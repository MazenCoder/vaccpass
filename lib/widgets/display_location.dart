import 'package:vaccpass/core/database/app_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class DisplayLocation extends StatelessWidget {
  final TracerEntity model;
  const DisplayLocation({required this.model, Key? key}) : super(key: key);


  /*
  Future<Uint8List> generateDocument() async {
    final pw.Document doc = pw.Document();

    doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          // if (context.pageNumber == 1) {
          //   return null;
          // }
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              // decoration: const pw.BoxDecoration(
              //     border: pw.BoxBorder(
              //         bottom: true, width: 0.5, color: PdfColors.grey)),
              child: pw.Text('Portable Document Format',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Center(child: pw.Paragraph(text: 'sdf', style: const pw.TextStyle(fontSize: 18)),),
          pw.Center(child: pw.BarcodeWidget(
            data: jsonEncode({
              "name": "_name",
              "email": "_email",
              "image": "imageUrl",

            }),
            width: 150,
            height: 150,
            barcode: pw.Barcode.qrCode(),
          ),),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ]));

    return doc.save();
  }

  Future<File> getPdf() async {
    Uint8List uint8list = await generateDocument();
    Directory output = await getTemporaryDirectory();
    File file = File(output.path + "/example.pdf");
    await file.writeAsBytes(uint8list);
    return file;
  }

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.adr??'',
          maxLines: 1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImage(
              data: model.encoded??'',
              version: QrVersions.auto,
              size: Get.width-100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(model.opn??'',
                  style: GoogleFonts.acme(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5, height: 5),
                Text(model.adr?.replaceAll('\n', ' ')??'',
                  style: GoogleFonts.acme(
                    fontSize: 14,
                  ),
                ),

              ],
            )
          ],
        )
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
