import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/core/util/flash_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:vaccpass/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:async';



class PinCodeVerification extends StatefulWidget {
  const PinCodeVerification({Key? key}) : super(key: key);

  @override
  _PinCodeVerificationState createState() =>
      _PinCodeVerificationState();
}

class _PinCodeVerificationState extends State<PinCodeVerification> {

  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  final formKey = GlobalKey<FormState>();
  String currentText = "";
  bool hasError = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.PRIMARY_COLOR,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: SvgPicture.asset('assets/images/Lock.svg',
                    color: primaryColor,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('enter_your_pin'.tr,
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
                  child: Text('enter_digit_pin'.tr,
                    textAlign: TextAlign.center,
                  )
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Padding(
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
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) async {
                          logger.i("Completed $currentText");
                          await appUtils.verificationCode(currentText).then((value) {
                            if (value) {
                              Get.offAll(() => const HomePage());
                            } else {
                              FlashHelper.errorBar(
                                context: context,
                                title: 'verification'.tr,
                                message: 'pin_not_match'.tr,
                              );
                            }
                          });
                        },
                        onChanged: (value) {
                          logger.i(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          logger.i("Allowing to paste $text");
                          return true;
                        },
                      ),
                  ),
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
                const SizedBox(height: 20),

                /*
                const SizedBox(height: 14),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        formKey.currentState!.validate();
                        if (currentText.length != 4) {
                          errorController!.add(ErrorAnimationType.shake); // Triggering error shake animation
                          setState(() => hasError = true);
                        } else {
                          setState(() {hasError = false;});
                          await appUtils.verificationCode(currentText).then((value) {
                            if (value) {
                              Get.offAll(() => const HomePage());
                            } else {
                              FlashHelper.errorBar(
                                context: context,
                                title: 'verification'.tr,
                                message: 'pin_not_match'.tr,
                              );
                            }
                          });
                        }
                      },
                      child: Center(
                          child: Text(
                            "VERIFY".toUpperCase(),
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
                const SizedBox(height: 16),
                
                 */

              ],
            ),
          ),
        ),
      ),
    );
  }
}