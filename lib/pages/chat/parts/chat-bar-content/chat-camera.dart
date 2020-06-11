part of '../../chat.dart';

openCamera(){
  ImagePicker.pickImage(source: ImageSource.camera).then((value)=>{
    print(value)
  });
}