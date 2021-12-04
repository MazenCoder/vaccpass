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
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
