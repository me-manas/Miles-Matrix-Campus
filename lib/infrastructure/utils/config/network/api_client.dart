import 'package:dio/dio.dart';
import 'package:matrix_campus/infrastructure/utils/config/network/api_result.dart';
import 'package:matrix_campus/infrastructure/utils/config/network/retry_on_connection_change_interceptor.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/dev_logger.dart';
import 'api_exception.dart';
import 'header_interceptor.dart';

typedef JsonMap = Map<String, dynamic>;

class ApiClient {
  static final ApiClient _instance = ApiClient.internal();
  static late Dio _dio;
  static ApiResult apiResult = ApiResult();

  ApiClient.internal() {
    final authInterceptor = AuthInterceptor();
    final retryInterceptor = RetryOnConnectionChangeInterceptor(
      interceptors: [authInterceptor],
    );
    _dio =
        Dio()
          ..interceptors.add(authInterceptor)
          ..interceptors.add(retryInterceptor)
          ..interceptors.add(
            LogInterceptor(
              responseBody: true,
              request: true,
              logPrint: (Object object) {
                if (object.toString().contains('uri') ||
                    object.toString().contains('message')) {
                  devLogger(message: 'API Request- $object');
                }
              },
              requestBody: true,
            ),
          );
  }

  factory ApiClient() => _instance;

  final CancelToken _cancelToken = CancelToken();

  Future<dynamic> get(
    url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      url = url;
      Response response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<dynamic> post(
    url, {
    JsonMap? body,
    FormData? formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Function(int, int)? onSendProgres,
  }) async {
    try {
      url = url;
      Response response = await _dio.post(
        url,
        data: formData ?? body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
        onSendProgress: onSendProgres,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<dynamic> postList(
    url, {
    List? body,
    FormData? formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Function(int, int)? onSendProgres,
  }) async {
    try {
      url = url;
      Response response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
        onSendProgress: onSendProgres,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future update(
    String url, {
    JsonMap? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      url = url;
      Response response = await _dio.put(
        url,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future delete(
    String url, {
    JsonMap? body,
    Map<String, dynamic>? header,
  }) async {
    try {
      url = url;
      Response response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: header),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<Map<String, dynamic>> _handleError(String path, Object error) {
    if (error is DioException) {
      final method = error.requestOptions.method;
      final response = error.response;

      if (response != null) {
        final statusCode = response.statusCode;
        final responseData = response.data;

        // Extract error message using a generic approach
        final String errorMessage = _extractErrorMessage(
          statusCode: statusCode,
          responseData: responseData,
        );

        // if (statusCode == 403 || statusCode == 401) {
        /// User is FORBIDDEN or UNAUTHORIZED
        /// TODO: navigate him back to login screen & clear local storage data
        // }
        throw ApiException(
          errorMessage: errorMessage,
          path: path,
          info: errorMessage,
          response: response.data,
          statusCode: statusCode,
          method: method,
        );
      } else {
        // If no response is available, handle it as a general error
        final errorMessage = error.message ?? StringConstants.unexpectedError;
        throw ApiException(
          errorMessage: errorMessage,
          path: path,
          info: errorMessage,
          response: response?.data,
          method: method,
        );
      }
    } else {
      int errorCode = 0; //We will send a default error code as 0
      throw ApiException(
        path: path,
        info: 'received server error $errorCode',
        response: error.toString(),
        statusCode: errorCode,
        method: '',
      );
    }
  }

  // Helper method to extract error message from response data
  static String _extractErrorMessage({
    required int? statusCode,
    required dynamic responseData,
  }) {
    //default error messages based on status code
    final Map<int, String> defaultMessages = {
      400: StringConstants.badRequestError,
      401: StringConstants.unauthorizedError,
      403: StringConstants.unauthorizedError,
      404: StringConstants.notFoundError,
      500: '',
    };

    // Get default message for the status code or use unexpectedError
    final defaultMessage =
        defaultMessages[statusCode] ?? StringConstants.unexpectedError;

    // If there's no response data, return the default message
    if (responseData == null) {
      return defaultMessage;
    }

    // Try to extract message from common paths
    try {
      // Check all possible locations for the error message
      // needs to be confirmed
      final List<dynamic> possibleMessagePaths = [
        responseData['result']?['message'],
        responseData['message'],
        responseData['error']?['message'],
        responseData['error'],
      ];

      // Return the first non-null message found
      for (var message in possibleMessagePaths) {
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }
      }

      // If no message found in the response, use the default
      return defaultMessage;
    } catch (e) {
      // If any error occurs during extraction, return the default
      return defaultMessage;
    }
  }

  Future download(
    String url, {
    required String path,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      await Dio().download(
        url,
        path,
        onReceiveProgress: onReceiveProgress,
        cancelToken: _cancelToken,
        options: Options(followRedirects: false),
      );
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<dynamic> put(
    url, {
    JsonMap? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      url = url;
      Response response = await _dio.put(
        url,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<dynamic> patch(
    url, {
    JsonMap? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      url = url;
      Response response = await _dio.patch(
        url,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }
}
