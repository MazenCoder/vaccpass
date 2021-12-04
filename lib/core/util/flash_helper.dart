import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flash/flash.dart';
import 'dart:collection';
import 'constants.dart';
import 'dart:async';



class _MessageItem<T> {
  final String message;
  Completer<Future<T>> completer;
  _MessageItem(this.message) : completer = Completer<Future<T>>();
}

class FlashHelper {
  static Completer<BuildContext> _buildCompleter = Completer<BuildContext>();
  static final Queue<_MessageItem> _messageQueue = Queue<_MessageItem>();
  static Duration duration = const Duration(seconds: 3);
  static late Completer _previousCompleter;


  static void init(BuildContext context) {
    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.complete(context);
    }
  }

  static void dispose() {
    _messageQueue.clear();

    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.completeError('NotInitalize');
    }
    _buildCompleter = Completer<BuildContext>();
  }

  static Color _backgroundColor(BuildContext context) {
    var theme = Theme.of(context);
    return theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
  }

  static TextStyle _titleStyle(BuildContext context, [Color? color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.headline6)!
        .copyWith(color: color);
  }

  static TextStyle _contentStyle(BuildContext context, [Color? color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)!
        .copyWith(color: color);
  }

  static Future<void> infoBar<T>({
    required BuildContext context,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<void>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: Text(title, style: _titleStyle(context, Colors.white)),
            content: Text(message, style: _contentStyle(context, Colors.white)),
            icon: const Icon(Icons.info_outline, color: Colors.yellow),
            // leftBarIndicatorColor: Colors.black,
          ),
        );
      },
    );
  }

  static Future<void> successBar<T>({
    required BuildContext context,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<void>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: Text(title, style: _titleStyle(context, Colors.white)),
            content: Text(message, style: _contentStyle(context, Colors.white)),
            icon: const Icon(Icons.check_circle, color: primaryColor),
            // leftBarIndicatorColor: Colors.black,
          ),
        );
      },
    );
  }

  static Future<void> errorBar<T>({
    required BuildContext context,
    required String title,
    required String message,
    required ChildBuilder primaryAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<void>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return StatefulBuilder(builder: (context, setState) {
          return Flash(
            controller: controller,
            behavior: FlashBehavior.floating,
            position: FlashPosition.bottom,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            backgroundColor: Colors.black87,
            child: FlashBar(
              title: Text(title, style: _titleStyle(context, Colors.white)),
              content: Text(message, style: _contentStyle(context, Colors.white)),
              primaryAction: primaryAction.call(context, controller, setState),
              icon: Icon(Icons.warning, color: Colors.red[300]),
              // leftBarIndicatorColor: Colors.black,
            ),
          );
        });
      },
    );
  }

  static Future<void> actionBar<T>(
      BuildContext context, {
        required String title,
        required String message,
        required ChildBuilder primaryAction,
        Duration duration = const Duration(seconds: 3),
      }) {
    return showFlash<void>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return StatefulBuilder(builder: (context, setState) {
          return Flash(
            controller: controller,
            behavior: FlashBehavior.floating,
            position: FlashPosition.bottom,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            backgroundColor: Colors.black87,
            child: FlashBar(
              title: Text(title, style: _titleStyle(context, Colors.white)),
              content:
              Text(message, style: _contentStyle(context, Colors.white)),
              primaryAction: primaryAction.call(context, controller, setState),
            ),
          );
        });
      },
    );
  }
}

typedef ChildBuilder = Widget Function(
    BuildContext context, FlashController controller, StateSetter setState);
