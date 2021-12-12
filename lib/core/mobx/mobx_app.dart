import 'package:mobx/mobx.dart';

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
}