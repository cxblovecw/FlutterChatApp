import 'package:FlutterStudy/utils/storage.dart';
import 'package:dio/dio.dart';

var request=Dio(BaseOptions(
  baseUrl: "http://172.30.92.225:4200",
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
));

getUserInfo(String account)async{
  return await request.get('/info',queryParameters: {"account":int.parse(account)});
}