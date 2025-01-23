import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:e_hujjat/app/router.dart';

import '../../db/cache.dart';
import '../utils/exceptions.dart';

final class RequestHelper {
  final logger = Logger();
  final baseUrl = 'http://10.100.26.2:5000';
  final dio = Dio();

  void logMethod(String message) {
    log(message);
  }

  String get _token {
    final token = cache.getString('access_token');
    if (token != null) return token;
    throw UnauthorizedException();
  }

  Future<dynamic> get(
    String path, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.get(
        baseUrl + path,
        cancelToken: cancelToken,
      );

      if (log) {
        logger.d([
          'GET',
          path,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e, s) {
      logger.d([
        'GET',
        path,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
        s,
      ]);

      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }

      rethrow;
    } catch (e, s) {
      logger.e([e, s]);
      rethrow;
    }
  }

  Future<dynamic> getTheNews(String path,
      {bool log = false, CancelToken? cancelToken, String? lang}) async {
    try {
      final headers = {'lang': lang};
      final response = await dio.get(
        path,
        cancelToken: cancelToken,
        options: Options(headers: headers),
      );

      if (log) {
        logger.d([
          'GET',
          path,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e, s) {
      logger.d([
        'GET',
        path,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
        s,
      ]);

      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }

      rethrow;
    } catch (e, s) {
      logger.e([e, s]);
      rethrow;
    }
  }

  Future<dynamic> getWithAuth(
    String path, {
    bool log = false,
    CancelToken? cancelToken,
    String? accessToken,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${accessToken ?? _token}',
        // 'Authorization': 'Bearer eyJhbGciOiJSUzI1NiJ9.eyJ1cGRhdGVfaWQiOjM1NDA4NSwic3ViIjoiMTcxMWI3ZDItYjNiYS00NTU2LTk0ODctMjhhOWRkODQzODM5Iiwicm9sZXMiOiIiLCJpc3MiOiIiLCJ0eXBlIjoiQmVhcmVyIiwibG9jYWxlIjoidWsiLCJzaWQiOiI0NjRiYTAxMy04NDNiLTQwMWYtOTNjMy1mODdkN2MwYmJkOTciLCJhdWQiOiJhY2NvdW50IiwiZnVsbF9uYW1lIjoiWE_igJhKQVlFViBNT-KAmFlESU5YVUpBIE1BWE1VRCBP4oCYR-KAmExJIiwiZXhwIjoxNzMxODU5ODY5LCJzZXNzaW9uX3N0YXRlIjoiU1RBVEVMRVNTIiwiaWF0IjoxNzMxNzczNDY5LCJqdGkiOiJjYzZlYzQ4NC0xYzk5LTRjMGUtYTg1OS1mN2MzZWI4MThhNTEiLCJ1c2VybmFtZSI6InVzZXIzMDMwMTk4NjcwMDA0NSJ9.tVzxlU_8aRPXGCBUdKQ3IIGk3DDunuYBH7bTjPAXKl8qYHEgboVB_wKVL9al78lac-lxtTmcuH9fZC4oMEILS7nS7VFogFpHd_96i-UgJ9UkH6tYBQaiqylkPY_v4wTPfXJFVjSN5lQ7qujuITumCX1r7OZk_KXQRadbYNAdtpSXqdkxrEHYjxxR98yoZk0tB0aZLxDdwj1xMHqMBlQBLbtUeAS5_ZmQEf6WuYR9cQnovxAE4HDdnwIvxP9kAfgkFzXrqOTWkv0zz3rDV1Q-4aTtWfu_gnQ0NyLZLc5XzERr9s3mcvCDHwCr5Ws1H8kEEJtdpweqvIaJeqYlH5_5Wg',
      };
      final response = await dio.get(
        baseUrl + path,
        cancelToken: cancelToken,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 401) {
        await refreshAccessToken();
        return getWithAuth(path);
      }
      if (log) {
        logger.d([
          'GET',
          path,
          accessToken,
          _token,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e, s) {
      logger.d([
        'GET',
        path,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
        s,
      ]);

      // if (e.response?.statusCode == 401) {
      //   await refreshAccessToken();
      //   return getWithAuth(path);
      //   router.go(Routes.home);

      //   throw UnauthorizedException();
      // }

      rethrow;
    } catch (e, s) {
      logger.e([e, s]);
      rethrow;
    }
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> body, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      const headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await dio.post(
        baseUrl + path,
        cancelToken: cancelToken,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (log) {
        logger.d([
          'POST',
          path,
          body,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e, s) {
      logger.d([
        'POST',
        path,
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
        s,
      ]);

      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }

      throw e.response?.data?['response']?['detail'] ??
          e.response?.data?['message'];
    } catch (e, s) {
      logger.e([e, s]);
      rethrow;
    }
  }

  Future<dynamic> postWithAuth(
    String path,
    Map<String, dynamic> body, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      };

      final response = await dio.post(
        baseUrl + path,
        cancelToken: cancelToken,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (log) {
        logger.d([
          'POST',
          path,
          body,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e, s) {
      logger.d([
        'POST',
        path,
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
        s,
      ]);

      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }

      throw e.response?.data?['message'];
    } catch (e, s) {
      logger.e([e, s]);
      rethrow;
    }
  }

  Future<dynamic> putWithAuth(
    String path,
    Map<String, dynamic> body, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      };

      final response = await dio.put(
        baseUrl + path,
        cancelToken: cancelToken,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (log) {
        logger.d([
          'PUT',
          path,
          body,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e, s) {
      logger.d([
        'PUT',
        path,
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
        s,
      ]);

      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }

      throw e.response?.data?['message'];
    } catch (e, s) {
      logger.e([e, s]);
      rethrow;
    }
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = cache.getString('refresh_token');
    if (refreshToken == null) {
      router.go(Routes.home);

      throw UnauthorizedException();
    }

    var url =
        'https://qoriqlash-xizmati.platon.uz/services/platon-core/api/mobile/v1/auth/refresh/token';

    var headers = <String, String>{};

    // headers.addAll(await getAndSetUserAgent());
    headers.addAll({'Authorization': 'Bearer $refreshToken'});

    var response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var parsed = json.decode(utf8.decode(response.bodyBytes));
      String accessToken = parsed['data']['access_token'];
      String refreshToken = parsed['data']['refresh_token'];
      await cache.setString('access_token', accessToken);
      await cache.setString('refresh_token', refreshToken);
    } else {
      router.go(Routes.home);
      throw UnauthorizedException();
    }
  }
}

final requestHelper = RequestHelper();
