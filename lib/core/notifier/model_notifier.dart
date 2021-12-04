import 'package:flutter/material.dart';



class ModelNotifier extends ChangeNotifier {


  //! Version
  String _version = '1.0.0';
  String get version => _version;

  setVersion(String val) {
    _version = val;
    notifyListeners();
  }


  // //! LoginModel
  // LoginModel _loginModel;
  // LoginModel get loginModel => _loginModel;
  //
  // setLoginModel(LoginModel val) {
  //   _loginModel = val;
  //   notifyListeners();
  // }
  //
  // //! InputLogin
  // InputLogin _inputLogin;
  // InputLogin get inputLogin => _inputLogin;
  //
  // setInputLogin(InputLogin val) {
  //   _inputLogin = val;
  //   notifyListeners();
  // }
  //
  // //! List Enfant
  // List<Enfant> _enfants = [];
  // List<Enfant> get enfants => _enfants;
  //
  // setEnfants(List<Enfant> val) {
  //   _enfants = val;
  //   notifyListeners();
  // }
  //
  // //! Enfant
  // Enfant _enfant;
  // Enfant get enfant => _enfant;
  //
  // setEnfant(Enfant val) {
  //   _enfant = val;
  //   notifyListeners();
  // }
  //
  // logout() {
  //   _loginModel = null;
  //   _inputLogin = null;
  //   notifyListeners();
  // }
  //
  // //! Main Counts
  // MainCountsModel _counters = MainCountsModel(
  //   countJoursFeries: 0,
  //   countNotifications: 0,
  //   countEvenements: 0,
  //   countInformations: 0,
  // );
  //
  // MainCountsModel get counters => _counters;
  //
  // void setMainCountsModel(MainCountsModel val) {
  //   _counters = val;
  //   notifyListeners();
  // }
}