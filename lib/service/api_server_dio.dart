import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/connectivity_helper.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/flutter_toast.dart';
import 'package:mdpe_approve_app/service/Apis.dart';

class ApiHelper {


  static Future<dynamic> getData({
    required String urlEndPoint,
    required BuildContext context,
  }) async {
    try {
      if (!await ConnectivityHelper.allConnectivityCheck(context: context)) {
        return null;
      }
      String url = Apis.baseUrl + urlEndPoint;
      final response = await Dio().get(Uri.parse(url).toString());
      log("URL --> $url");
      log("Response Data --> ${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      }
      return response.data;
    } on DioException catch (error) {
      debugPrint("Dio Error --> ${error.message}");
      final statusCode = error.response?.statusCode;
      Response? errorMessage = error.response;
      return await _handleError(statusCode :statusCode, errorMessage: errorMessage,context: context);
    } catch (e) {
      log("Catch Error --> $e");
      await UtilsToast.errorSnackBar(msg: "Something Went Wrong", context: context);
      throw 'Something Went Wrong';
    }
  }


  static Future<dynamic> postData({
    required BuildContext context,
    required String urlEndPoint,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    String? contentType,
    formData,
  }) async {
    try {
      if (!await ConnectivityHelper.allConnectivityCheck(context: context)) {
        return null;
      }
      String url = Apis.baseUrl + urlEndPoint;
      var options = Options(
        headers: headers ?? {},
        contentType: contentType ?? (formData != null ? "multipart/form-data" : null),
      );
      var response = await Dio().post(Uri.parse(url).toString(),
          options: options, data: param ?? FormData.fromMap(formData));
      log("URL --> $url");
      log("Response Data --> ${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      }
      return response.data;
    } on DioException catch (error) {
      debugPrint("Dio Error --> ${error.message}");
      final statusCode = error.response?.statusCode;
      Response? errorMessage = error.response;
      return await _handleError(statusCode :statusCode, errorMessage: errorMessage,context: context);
    } catch (e) {
      log("Multipart Error --> $e");
      await UtilsToast.errorSnackBar(msg: "Something Went Wrong", context: context);
      throw 'Something Went Wrong';
    }
  }


  static Future<dynamic> postDataWithFile({
    required String urlEndPoint,
    required Map<String, dynamic> body,
    required List<ImageRequestObject> imageRequestObject,
    required BuildContext context,
  }) async {
    try {
      if (!await ConnectivityHelper.allConnectivityCheck(context: context)) {
        return null;
      }

      final formData = FormData.fromMap(body);

      // Process image files
      for (var element in imageRequestObject) {
        if (element.path!.isNotEmpty && !element.path!.startsWith("http")) {
          final mimeTypeData = lookupMimeType(element.path!, headerBytes: [0xFF, 0xD8])?.split('/');
          if (mimeTypeData != null && mimeTypeData.length == 2) {
            formData.files.add(
              MapEntry(
                element.key!,
                await MultipartFile.fromFile(
                  element.path!,
                  contentType: DioMediaType(mimeTypeData[0], mimeTypeData[1]),
                ),
              ),
            );
          }
        } else {
          body[element.key!] = element.path;
        }
      }
      String url = Apis.baseUrl + urlEndPoint;
      final response = await Dio().post(Uri.parse(url).toString(), data: formData);
      debugPrint("URL --> $url");
      debugPrint("Response Data --> ${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      }

      return response.data;
    } on DioException catch (error) {
      debugPrint("Dio Error --> ${error.message}");
      final statusCode = error.response?.statusCode;
      Response? errorMessage = error.response;
      return await _handleError(statusCode :statusCode, errorMessage: errorMessage,context: context);
    } catch (e) {
      debugPrint("Multipart Error --> $e");
      await UtilsToast.errorSnackBar(msg: "Something Went Wrong", context: context);
      throw 'Something Went Wrong';
    }
  }



  static Future<void> _handleError(
      {int? statusCode, Response? errorMessage, required BuildContext context}) async {
    if(statusCode == 400){
     /* return  await UtilsToast.errorSnackBar(
          msg: errorMessage!.data.replaceAll("{", "").replaceAll("}", ""),
          context: context);*/
    }else if(statusCode == 401){
      log("errorStatus(401)-->${errorMessage.toString()}");
      return await UtilsToast.errorSnackBar(msg: errorMessage!.data.toString(), context: context);
    }else if(statusCode == 404){
      log("errorStatus(404)-->${errorMessage.toString()}");
      return await UtilsToast.errorSnackBar(msg: errorMessage!.data.toString(), context: context);
    }else if(statusCode == 415){
      return await UtilsToast.errorSnackBar(msg: errorMessage!.data.toString(), context: context);
    } else if(statusCode == 500){
      return await UtilsToast.errorSnackBar(msg: errorMessage!.statusMessage.toString(), context: context);
    } else{
      return await UtilsToast.errorSnackBar(msg: errorMessage!.data.toString(), context: context);
    }
  }
}


class ImageRequestObject {
  String? key;
  String? path;

  ImageRequestObject(this.key, this.path);
}