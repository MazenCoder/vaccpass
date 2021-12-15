// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxApp on MobxAppBase, Store {
  final _$currentIndexAtom = Atom(name: 'MobxAppBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$obscureTextAtom = Atom(name: 'MobxAppBase.obscureText');

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  final _$covidPassAtom = Atom(name: 'MobxAppBase.covidPass');

  @override
  CovidPassModel? get covidPass {
    _$covidPassAtom.reportRead();
    return super.covidPass;
  }

  @override
  set covidPass(CovidPassModel? value) {
    _$covidPassAtom.reportWrite(value, super.covidPass, () {
      super.covidPass = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'MobxAppBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$MobxAppBaseActionController = ActionController(name: 'MobxAppBase');

  @override
  void onPageChanged(int val) {
    final _$actionInfo = _$MobxAppBaseActionController.startAction(
        name: 'MobxAppBase.onPageChanged');
    try {
      return super.onPageChanged(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggle(bool val) {
    final _$actionInfo =
        _$MobxAppBaseActionController.startAction(name: 'MobxAppBase.toggle');
    try {
      return super.toggle(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCovidPassModel(CovidPassModel? val) {
    final _$actionInfo = _$MobxAppBaseActionController.startAction(
        name: 'MobxAppBase.setCovidPassModel');
    try {
      return super.setCovidPassModel(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String? val) {
    final _$actionInfo = _$MobxAppBaseActionController.startAction(
        name: 'MobxAppBase.setErrorMessage');
    try {
      return super.setErrorMessage(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
obscureText: ${obscureText},
covidPass: ${covidPass},
errorMessage: ${errorMessage}
    ''';
  }
}
