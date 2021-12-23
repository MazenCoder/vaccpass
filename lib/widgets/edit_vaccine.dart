import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/ui/edit_passport_modal_fit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:vaccpass/core/ui/modal_fit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class EditVaccine extends StatefulWidget {
  final VaccineEntity entity;
  const EditVaccine({required this.entity, Key? key}) : super(key: key);

  @override
  _EditVaccineState createState() => _EditVaccineState();
}

class _EditVaccineState extends State<EditVaccine> {

  late TextEditingController _editingController;
  late VaccineEntity model;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.entity.givenName??'New Passport');
    model = widget.entity;
  }
  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('edit_id_pass'.tr.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'SansSerifFLF',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(MdiIcons.contentSave),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              final givenName = widget.entity.givenName??"";
              if (givenName != _editingController.text.trim()) {
                await appUtils.editGivenNameVaccine(
                  context: context, model: widget.entity,
                  name: _editingController.text.trim()
                );
              }
            }
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<VaccineEntity?>(
        stream: db.vaccineEntitysDao.watchVaccineById(widget.entity.id),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting: return const Center(
              child: CircularProgressIndicator(),
            );
            default:
              model = snapshot.data??widget.entity;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Column(
                  children: [

                    Card(
                      child: TextFormField(
                        controller: _editingController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: primaryColor),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: primaryColor),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: primaryColor),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          hintText: 'Name',
                        )
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (model.encoded != null && model.encoded!.isNotEmpty)
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('QR Code',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'SansSerifFLF',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            QrImage(
                              data: model.encoded??'',
                              version: QrVersions.auto,
                              // size: Get.width-100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextButton.icon(
                                  label: Text('Update QR Code',
                                    style: GoogleFonts.acme(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                  ),
                                  icon: const Icon(MdiIcons.qrcodeScan),
                                  onPressed: () => showMaterialModalBottomSheet(
                                    expand: false, context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => EditPassportModalFit(model: model),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await appUtils.editVaccine(
                                      context: context,
                                      model: model,
                                      deleteEncodedQr: true,
                                      deletePhotoQr: false,
                                      deletePhotoID: false,
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    else if (model.imageVaccine != null && model.imageVaccine!.isNotEmpty)
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text('photo_passport'.tr,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'SansSerifFLF',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Image.memory(
                              appUtils.convertImageBase64(model.imageVaccine),
                              // height: Get.height/3,
                              width: Get.width,
                              // fit: BoxFit.contain,
                              // width: ,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextButton.icon(
                                  label: Text('update_photo'.tr,
                                    style: GoogleFonts.acme(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                  ),
                                  icon: const Icon(MdiIcons.cameraPlus),
                                  onPressed: () => showMaterialModalBottomSheet(
                                    expand: false, context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => EditPassportModalFit(model: model),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await appUtils.editVaccine(
                                      context: context,
                                      model: model,
                                      deleteEncodedQr: false,
                                      deletePhotoQr: true,
                                      deletePhotoID: false,
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    else
                      Card(
                        child: TextButton.icon(
                          label: Text('Scan or Add QR Code',
                            style: GoogleFonts.acme(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                          icon: const Icon(MdiIcons.qrcodeScan),
                          onPressed: () => showMaterialModalBottomSheet(
                            expand: false, context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => EditPassportModalFit(model: model),
                          ),
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(height: 8,),
                    if (model.imageId != null && model.imageId!.isNotEmpty)
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('ID',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'SansSerifFLF',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Image.memory(
                              appUtils.convertImageBase64(model.imageId),
                              width: Get.width,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextButton(
                                  child: Text('update_license_id'.tr,
                                    style: GoogleFonts.acme(
                                        fontSize: 12
                                    ),
                                  ),
                                  onPressed: () => showMaterialModalBottomSheet(
                                      expand: false, context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => ModalFit(entity: model)
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await appUtils.editVaccine(
                                      context: context,
                                      model: model,
                                      deleteEncodedQr: false,
                                      deletePhotoQr: false,
                                      deletePhotoID: true,
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    else
                      Card(
                        child: TextButton(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/id.png',
                                color: primaryColor,
                                height: 30,
                              ),
                              const SizedBox(width: 6),
                              Text('add_license_id'.tr,
                                style: GoogleFonts.acme(
                                    fontSize: 12
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => showMaterialModalBottomSheet(
                              expand: false, context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => ModalFit(entity: model)
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
