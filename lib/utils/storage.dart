import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
// class Storage{
//   SharedPreferences spfs;
//   Storage(){
//     init();
//   }
//   init()async{
//     this.spfs=await SharedPreferences.getInstance();
//     print(this.spfs);
//   }
//   setStorage(key,value)async{
//     print(this.spfs);
//     switch (value.runtimeType) {
//       case bool:
//         spfs.setBool(key, value);
//         break;
//       case String:
//         spfs.setString(key, value);
//         break;
//       case double:
//         spfs.setDouble(key, value);
//         break;
//       case int:
//         spfs.setInt(key, value);
//         break;
//       default:
//         spfs.setStringList(key, value);
//     }
//   }

//   getStorage(String key)async{
//     print(this.spfs);
//     return this.spfs.get(key);
//   }

//   removeStorage(String key) async{
//     print(this.spfs);
//     this.spfs.remove(key);
//   }

//   getStorages()async{
//   }
// }
// getStorage(){
//   Storage storage=new Storage();
//   return storage;
// }
setStorage(key,value)async{
  SharedPreferences spfs=await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case bool:
      spfs.setBool(key, value);
      break;
    case String:
      spfs.setString(key, value);
      break;
    case double:
      spfs.setDouble(key, value);
      break;
    case int:
      spfs.setInt(key, value);
      break;
    default:
      spfs.setStringList(key, value);
  }
}
getStorage(String key)async{
  SharedPreferences spfs=await SharedPreferences.getInstance();
  if(spfs.get(key).startsWith("{")){
    return JsonDecoder().convert(spfs.get(key));
  }else{
    return spfs.get(key);
  }
}

removeStorage(String key) async{
  SharedPreferences spfs=await SharedPreferences.getInstance();
  spfs.remove(key);
}

getStorages()async{
  SharedPreferences spfs=await SharedPreferences.getInstance();
}