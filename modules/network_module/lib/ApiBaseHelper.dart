import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:network_module/webservice.dart';
// import 'package:repository_module/Storage/constants.dart';
// import 'package:repository_module/Storage/data_store.dart';
// import 'package:repository_module/Utils/encryption.dart';

import 'AppException.dart';

enum ParameterEncoding { JSON_ENCODING, URL_ENCODING }

extension ParamenterEncodingExtension on ParameterEncoding {
  String get name => describeEnum(this);

  String get encoder {
    switch (this) {
      case ParameterEncoding.JSON_ENCODING:
        return "application/json";
      case ParameterEncoding.URL_ENCODING:
        return "application/x-www-form-urlencoded";
      default:
        return "application/json";
    }
  }
}

enum HTTPMethod { POST, GET, PUT, DELETE, MULTIPART }

extension HTTPMethodExtension on HTTPMethod {
  String get name => describeEnum(this);

  String get encoder {
    switch (this) {
      case HTTPMethod.POST:
        return "post";
      case HTTPMethod.GET:
        return "get";
      case HTTPMethod.PUT:
        return "put";
      case HTTPMethod.DELETE:
        return "delete";
      case HTTPMethod.MULTIPART:
        return "multipart";
      default:
        return "post";
    }
  }
}

class ApiBaseHelper {
  final _baseUrl = WebService.baseUrl;

  Future<dynamic> send(String url, dynamic body,
      HTTPMethod method, ParameterEncoding? encoding) async {
    var endPoint = Uri.parse(_baseUrl + url);

    Map<String, String> headers = {
      "Content-Type": encoding?.encoder ?? "",
      "Accept": "application/json",
    };
    var responseJson;
    try {
      switch (method) {
        case HTTPMethod.GET:
          final subhostname = url;

          final response = await http.get(endPoint, headers: headers);
          if (response.statusCode == 401) {
              send(url, body, method, encoding);
          }
          responseJson = _returnResponse(response);
          break;
        case HTTPMethod.POST:
          final response =
              await http.post(endPoint, body: body, headers: headers);
          if (response.statusCode == 401) {
              send(url, body, method, encoding);
          }
          responseJson = _returnResponse(response);
          break;
        case HTTPMethod.PUT:
          final response =
              await http.put(endPoint, body: body, headers: headers);
          responseJson = _returnResponse(response);
          break;
        case HTTPMethod.DELETE:
          final response =
              await http.delete(endPoint, body: body, headers: headers);
          responseJson = _returnResponse(response);
          break;
        default:
          final response =
              await http.post(endPoint, body: body, headers: headers);
          responseJson = _returnResponse(response);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  jsonToFormData(
      http.MultipartRequest request, Map<String, dynamic> data) async {
    for (var key in data.keys) {
      if (data[key] is File) {
        request.files
            .add(await http.MultipartFile.fromPath(key, data[key].path));
      } else {
        request.fields[key] = data[key].toString();
      }
    }
    return request;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      var responseJson = json.decode(response.body.toString());
      throw BadRequestException(responseJson["error_description"]);
    case 401:
      throw TokenExpiredException(response.body.toString());
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
