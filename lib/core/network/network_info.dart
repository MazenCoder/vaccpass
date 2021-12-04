import 'package:vaccpass/core/usecases/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';



class NetworkInfo extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  bool isConnected = false;
  int connectionType = 0;

  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription ;

  @override
  void onInit() {
    getConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async{
    late ConnectivityResult result;
    try{
      result = await (_connectivity.checkConnectivity());
    }on PlatformException catch(e){
      logger.e(e);
    }
    return _updateState(result);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  void _updateState(ConnectivityResult result) {
    switch(result) {
      case ConnectivityResult.wifi:
        connectionType=1;
        isConnected = true;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType=2;
        isConnected = true;
        update();
        break;
      case ConnectivityResult.none:
        connectionType=0;
        isConnected = false;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        isConnected = false;
      break;

    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}