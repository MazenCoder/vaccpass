import 'package:flutter/material.dart';
import 'package:vaccpass/core/util/constants.dart';

typedef ResponsiveBuilder = Widget Function(BuildContext context);

class ResponsiveSafeArea extends StatelessWidget {

  const ResponsiveSafeArea({
    required ResponsiveBuilder builder,
    Key? key,
  }) : responsiveBuilder = builder, super(key: key);

  final ResponsiveBuilder responsiveBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        bottom: false,
        child: responsiveBuilder(context)
      ),
    );
  }
}