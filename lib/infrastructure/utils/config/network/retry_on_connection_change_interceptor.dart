import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:matrix_campus/infrastructure/utils/helpers/dev_logger.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  /// Dio instance to fetch refresh token.
  /// Main dio instance will be blocked by [RefreshTokenInterceptor].
  /// That's why creating a new dio instance
  late final Dio _alternateDio;

  final List<Interceptor> interceptors;

  /// Stores list of request failed during refreshing token
  /// These request are sent again after refresh token retrieval is successful
  final List<(DioException, ErrorInterceptorHandler)> _failedRequests = [];

  RetryOnConnectionChangeInterceptor({required this.interceptors}) {
    _alternateDio = Dio()..interceptors.addAll(interceptors);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (_shouldRetry(err)) {
        _failedRequests.add((err, handler));
        await _navigateApiFailureScreen(isServerDown: _isServerDown(err));
      } else {
        handler.next(err);
      }
    } catch (e) {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    return _isServerDown(err);
  }

  bool _isServerDown(DioException err) =>
      (err.type == DioExceptionType.connectionTimeout) ||
      (err.type == DioExceptionType.connectionError);

  Future<void> _navigateApiFailureScreen({required bool isServerDown}) async {
    // TODO: add navigations on API failure if any
  }

  // Future<void> _retryFailedRequests() async {
  //   try {
  //     for (final (DioException err, ErrorInterceptorHandler handler)
  //         in _failedRequests) {
  //       final requestOptions = err.requestOptions;
  //       // Sending back the response with new auth token which will be added through interceptors
  //       final Response response = await _alternateDio.fetch(requestOptions);
  //       handler.resolve(response);
  //     }
  //     _failedRequests.clear();
  //   } on DioException catch (e) {
  //     devLogger(
  //       message: 'retryFailedRequestes failed --> ${e.toString()}',
  //       isError: true,
  //     );
  //   } catch (e) {
  //     devLogger(message: e.toString(), isError: true);
  //   }
  // }
}

(String?, Object?) getCurrentRounteAndArgs(
  GlobalKey<NavigatorState> navigatorKey,
) {
  String? currentPath;
  Object? args;
  navigatorKey.currentState?.popUntil((route) {
    currentPath = route.settings.name;
    args = route.settings.arguments;

    return true;
  });
  return (currentPath, args);
}
