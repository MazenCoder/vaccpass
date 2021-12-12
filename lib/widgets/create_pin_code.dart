import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/core/util/flash_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';




class CreatePinCode extends StatefulWidget {
  const CreatePinCode({Key? key}) : super(key: key);

  @override
  _CreatePinCodeState createState() =>
      _CreatePinCodeState();
}

class _CreatePinCodeState extends State<CreatePinCode> {

  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();


  final formKey = GlobalKey<FormState>();
  String pinCode1 = "";
  String pinCode2 = "";
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SvgPicture.asset('assets/images/Lock.svg',
                  color: primaryColor,
                )
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('set_pin'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansSerifFLF',
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: Text('prompted_enter_pin'.tr,
                textAlign: TextAlign.center,
              )
            ),
            const SizedBox(height: 25),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text('enter_pin'.tr,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30,
                    ),
                    child: PinCodeTextField(
                      // backgroundColor: Colors.grey,
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      obscuringWidget: Image.asset(
                        'assets/images/logo.png',
                        height: 24, width: 24,
                      ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 4) {
                          return 'field_required'.tr;
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.grey,
                        selectedFillColor: Colors.grey,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      controller: _pinController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) async {
                        logger.i("Completed $pinCode1");
                      },
                      onChanged: (value) {
                        logger.i(value);
                        setState(() {
                          pinCode1 = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        logger.i("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text('confirm_pin'.tr,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30,
                    ),
                    child: PinCodeTextField(
                      // backgroundColor: Colors.grey,
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      obscuringWidget: Image.asset(
                        'assets/images/logo.png',
                        height: 24, width: 24,
                      ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 4) {
                          return 'field_required'.tr;
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.grey,
                        selectedFillColor: Colors.grey,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      controller: _confirmController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) async {
                        logger.i("Completed $pinCode2");
                        if (pinCode1 != pinCode2) {
                          FlashHelper.errorBar(
                            context: context,
                            title: 'PIN Code'.tr,
                            message: 'pin_not_match'.tr,
                          );
                        }
                      },
                      onChanged: (value) {
                        logger.i(value);
                        setState(() {
                          pinCode2 = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        logger.i("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                hasError ? "*Please fill up all the cells properly" : "",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: ButtonTheme(
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    formKey.currentState!.validate();
                    if (pinCode1.length != 4 || pinCode2.length != 4) {
                      setState(() => hasError = true);
                    } else {
                      if (pinCode1 != pinCode2) {
                        return FlashHelper.errorBar(
                          context: context,
                          title: 'PIN Code'.tr,
                          message: 'pin_not_match'.tr,
                        );
                      }
                      setState(() {hasError = false;});
                      await appUtils.createPinCode(pinCode1).then((_) {
                        Get.back();
                      });
                    }
                  },
                  child: Center(
                      child: Text(
                        "Save".toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: primaryColor,
                      offset: Offset(1, -2),
                      blurRadius: 5,
                    ),
                    BoxShadow(
                      color: primaryColor,
                      offset: Offset(-1, 2),
                      blurRadius: 5,
                    )
                  ],
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}