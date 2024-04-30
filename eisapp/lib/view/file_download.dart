import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';

import 'package:path_provider/path_provider.dart';



class FileDownload {
  Dio dio = Dio();
  bool isSuccess = false;

  void startDownloading(BuildContext context, bool pdf,String url,final Function okCallback,String cat_name) async {
    String fileName =pdf? "${cat_name}.pdf":"${cat_name}.xls";

    String baseUrl = url;

    String path = await _getFilePath(fileName);

    try {
      await dio.download(
        baseUrl,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          okCallback(recivedBytes, totalBytes);
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      Navigator.pop(context);
      Navigator.pop(context);
      if(pdf){
        var snackBar = SnackBar(content: Text('Downloaded Succesfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        OpenFilex.open(path);
      }
      else
        {
          var snackBar = SnackBar(content: Text('Downloaded Succesfully'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }


    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/');  // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }
}