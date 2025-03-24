import 'package:matrix_campus/infrastructure/utils/enums/app_enums.dart';

extension ApiStatusExtension on ApiStatus {
  bool get isLoading {
    return this == ApiStatus.loading;
  }
}
