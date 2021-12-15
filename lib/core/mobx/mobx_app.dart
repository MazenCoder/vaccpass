import 'package:mobx/mobx.dart';

import '../../covid_pass_model.dart';

part 'mobx_app.g.dart';

class MobxApp = MobxAppBase with _$MobxApp;

abstract class MobxAppBase with Store {

  @observable
  int currentIndex = 0;

  @action
  void onPageChanged(int val) {
    currentIndex = val;
  }

  @observable
  bool obscureText = true;

  @action
  void toggle(bool val) {
    obscureText = val;
  }

  @observable
  CovidPassModel? covidPass;

  @action
  void setCovidPassModel(CovidPassModel? val) {
    covidPass = val;
  }

  @observable
  String? errorMessage;

  @action
  void setErrorMessage(String? val) {
    errorMessage = val;
  }

}