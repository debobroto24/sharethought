import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isNetworkAvabilable()async{
  var connectivityResult = await Connectivity().checkConnectivity(); 
  return connectivityResult != ConnectivityResult.none; 
}

Future<bool> isConnectedToMobile()async{
  var connectivityResult = await Connectivity().checkConnectivity(); 
  return connectivityResult != ConnectivityResult.mobile; 
}

Future<bool> isConnectedToWifi()async{
  var connectivityResult = await Connectivity().checkConnectivity(); 
  return connectivityResult != ConnectivityResult.wifi; 
}

