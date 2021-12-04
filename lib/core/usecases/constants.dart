import 'package:vaccpass/core/mobx/mobx_app.dart';
import 'package:vaccpass/core/util/app_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';


final AppUtils appUtils = GetIt.I.get<AppUtils>();
final MobxApp mobxApp = MobxApp();
final Logger logger = Logger();
