import 'dart:io' show Directory, File, Platform;
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:video_compress/video_compress.dart';
import 'app_color.dart';
import 'logger.dart';
import 'utils.dart';
import 'channel/platform_channel.dart';
import '../localization/localization.dart';
import '../utils/navigation/navigation_service.dart';
import 'package:image_cropper/image_cropper.dart';

//Type:0 Image 1 Video
typedef ImageSelectionCallBack = void Function(List<File>? file,int type);

enum MediaFor {
  profile,
  post,
  article,
  advertisement,
  moment,
  chatGroupPhoto,
  businessGroupPhoto,
  chatMedia
}

class MediaSelector {

  factory MediaSelector() {
    return _singleton;
  }
  static final MediaSelector _singleton = MediaSelector._internal();
  MediaSelector._internal() {
    Logger().v("Instance created MediaSelector");
  }

  String _getMessageForTitle(MediaFor purpose) {
    if (purpose == MediaFor.profile) {
      return Translations.of(NavigationService().context).msgProfilePhotoSelection;
    }
    return "";
  }

  String _getMessageForPermission(MediaFor purpose, ImageSource source) {
    if (source == ImageSource.camera) {
      if (purpose == MediaFor.profile) {
        return Translations.of(NavigationService().context).msgCameraPermissionProfile;
      }  else {
        return Translations.of(NavigationService().context).msgCameraPermission;
      }
    }
    else {
      if (purpose == MediaFor.profile) {
        return Translations.of(NavigationService().context).msgPhotoPermissionProfile;
      } else {
        return Translations.of(NavigationService().context).msgPhotoPermission;
      }
    }
  }
  //endregion

  //region Open setting
  Future<void> _openSetting(BuildContext context, {required String message}) async {
    Utils.showAlert(context, title: "", message: message, arrButton: [
      Translations.of(NavigationService().context).btnCancel,
      Translations.of(NavigationService().context).btnOk
    ], callback: (index) async {
      if (index == 1) {
        Future.delayed(Duration(seconds: 1), () async {
          await PlatformChannel().openSettings();
        });
      }
    });
  }
  //endregion

  //region Ask user for option
  void chooseImageWithOption(BuildContext context, {required MediaFor purpose, required ImageSelectionCallBack callBack, bool isImageResize = true, bool isCropImage = false}) {

    var arrButton = [
      Translations.of(NavigationService().context).strTakePhoto,
      Translations.of(NavigationService().context).strChooseFromExisting
    ];

    if (Platform.isAndroid) {
      arrButton.insert(0, Translations.of(NavigationService().context).btnCancel);
    }

    final message = _getMessageForTitle(purpose);
    if (Platform.isAndroid) {
      Utils.showAlert(context,
          message: message,
          barrierDismissible: true,
          arrButton: arrButton, callback: (int index) {
            if (index == 0) { return; }
            ImageSource sourceType = (index == 1) ? ImageSource.camera : ImageSource.gallery;
            onPickImageAction(context,isCropImage: isCropImage, purpose: purpose, source: sourceType, callBack: callBack, isImageResize: isImageResize);
          });
    } else if (Platform.isIOS) {
      Utils.showBottomSheet(context,
          title: message,
          arrButton: arrButton, callback: (int index) {
            if (index == -1) { return; }
            ImageSource sourceType =
            (index == 0) ? ImageSource.camera : ImageSource.gallery;
            onPickImageAction(context,isCropImage: isCropImage, purpose: purpose, source: sourceType, callBack: callBack, isImageResize: isImageResize);
          });
    }
  }
  //endregion

  //region Ask user for option
  void chooseMediaWithOption(BuildContext context, ImageSource source,{required MediaFor purpose, required ImageSelectionCallBack callBack, int maxImages = 1, bool isImageResize = true, bool isCropImage = false}) {

    var arrButton = [
      Translations.of(NavigationService().context).strImage,
      Translations.of(NavigationService().context).strVideo
    ];

    if (Platform.isAndroid) {
      arrButton.insert(0, Translations.of(NavigationService().context).btnCancel);
    }

    final message = _getMessageForTitle(purpose);
    if (Platform.isAndroid) {
      Utils.showAlert(context,
          message: message,
          barrierDismissible: true,
          arrButton: arrButton, callback: (int index) {
            if (index == 0) { return; }
            ImageSource sourceType = source;
            if(index == 1){
              onPickImageAction(context,isCropImage: isCropImage, purpose: purpose, source: sourceType, maxImages: maxImages, callBack: callBack, isImageResize: isImageResize);
            }
            // else{
            //   this.onPickVideoAction(context, purpose: purpose, source: sourceType, callBack: callBack, isImageResize: isImageResize);
            // }
          });
    } else if (Platform.isIOS) {
      Utils.showBottomSheet(context,
          title: message,
          arrButton: arrButton, callback: (int index) {
            if (index == -1) { return; }
            ImageSource sourceType = source;
            if(index == 0){
              onPickImageAction(context,isCropImage: isCropImage, purpose: purpose, source: sourceType, maxImages: maxImages, callBack: callBack, isImageResize: isImageResize);
            }
            // else{
            //   this.onPickVideoAction(context, purpose: purpose, source: sourceType, callBack: callBack, isImageResize: isImageResize);
            // }
          });
    }

  }
  //endregion


  //region PickImage with option
  Future onPickImageAction(BuildContext context, {required MediaFor purpose, required ImageSource source, int maxImages = 1, required ImageSelectionCallBack callBack, bool isImageResize = true,bool isCropImage = false}) async {
    String messageDecline = _getMessageForPermission(purpose, source);

    if (source == ImageSource.camera) {
      bool permissionAllowed = await PlatformChannel().checkForPermission(Permission.camera);
      if (permissionAllowed && Platform.isAndroid) {
        permissionAllowed = await PlatformChannel().checkForPermission(Permission.storage);
      }
      if (!permissionAllowed) {
        Logger().w("Permission Declined for Camera");
        _openSetting(context, message: messageDecline);
        if (callBack != null) {
          callBack(null,0);
        }
        return;
      }
    } else {
      Permission permission = Platform.isIOS ? Permission.photos : Permission.storage;
      bool permissionAllowed = await PlatformChannel().checkForPermission(permission);
      if (!permissionAllowed) {
        Logger().w("Permission Declined for Photo");
        _openSetting(context, message: messageDecline);
        if (callBack != null) {
          callBack(null,0);
        }
        return;
      }
    }

    if ((source == ImageSource.gallery) && (purpose == MediaFor.post || purpose == MediaFor.moment || purpose == MediaFor.article)) {
      List<Asset> resultList = [];

      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: maxImages,
          enableCamera: false,
          selectedAssets: [],
          cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#199EFC",
            actionBarTitle: Translations.of(context).appName,
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );

        List<File> arrFiles = [];
        for (var asset in resultList) {
          String filename = 'file_${DateTime.now().millisecondsSinceEpoch}_${resultList.indexOf(asset)}.jpg';
          File file = await writeAssetToFile(asset, filename);
          arrFiles.add(file);
        }

        if (callBack != null) {
          callBack(arrFiles, 0 );
        }
      } on Exception catch (e) {
        Logger().e("Error Multi image :: ${e.toString()}") ;
        callBack(null, 0);
      }

      return;
    }

    try {
      final ImagePicker _picker = ImagePicker();
      XFile? pickedFile;
      if (isImageResize) {
        pickedFile = await _picker.pickImage(source: source, maxHeight: 1080.0, maxWidth: 720.0);
      } else {
        pickedFile = await _picker.pickImage(source: source, maxHeight: 1080.0, maxWidth: 720.0);
        // pickedFile = await _picker.getImage(source: source);
      }


      File? selectedFile = (pickedFile != null) ? File(pickedFile.path) : null;
      if ((pickedFile != null) && isCropImage) {
        selectedFile = (await ImageCropper().cropImage(
            sourcePath: File(pickedFile.path).path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  toolbarColor: AppColor.colorPrimary,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                minimumAspectRatio: 1.0,
                title: 'Cropper',
                doneButtonTitle: Translations.current!.btnSave,
                cancelButtonTitle: Translations.current!.btnCancel,
              )
            ],
        )) as File?;
      } else {
        selectedFile = null;
      }
      Logger().v("Path Galley :: ${selectedFile?.path ?? ''}");
      if (selectedFile != null) {
        File fixedRotationFile = await FlutterExifRotation.rotateAndSaveImage(path: selectedFile.path);
        Logger().v("Path Fixed Rotation Galley :: ${fixedRotationFile.path}");
        if (fixedRotationFile != null) {
          selectedFile = fixedRotationFile;
        }
      }
      if (callBack != null) {
        callBack((selectedFile != null) ? [selectedFile] : null, 0 );
      }
    } catch(error) {
      Logger().v("Error :: ${error.toString()}");
    }
  }
  //endregion

  // //region PickImagewith option
  // Future onPickVideoAction(BuildContext context, {required MediaFor purpose, required ImageSource source, required ImageSelectionCallBack callBack, required bool isImageResize}) async {
  //   String messageDecline = this._getMessageForPermission(purpose, source);
  //
  //   if (source == ImageSource.camera) {
  //     bool permissionAllowed = await PlatformChannel().checkForPermission(Permission.camera);
  //     if (!permissionAllowed) {
  //       Logger().w("Permission Declined for Camera");
  //       this._openSetting(context, message: messageDecline);
  //       if (callBack != null) {
  //         callBack(null,1);
  //       }
  //       return;
  //     }
  //   } else {
  //     Permission permission = Platform.isIOS ? Permission.photos : Permission.storage;
  //     bool permissionAllowed = await PlatformChannel().checkForPermission(permission);
  //     if (!permissionAllowed) {
  //       Logger().w("Permission Declined for Photo");
  //       this._openSetting(context, message: messageDecline);
  //       if (callBack != null) {
  //         callBack(null,1);
  //       }
  //       return;
  //     }
  //   }
  //
  //   try {
  //     final ImagePicker _picker = ImagePicker();
  //     PickedFile? pickedFile;
  //
  //
  //
  //     pickedFile = await _picker.getVideo(source: source, maxDuration: Duration(seconds: 30),);
  //
  //     File? selectedFile = (pickedFile != null) ? File(pickedFile.path) : null;
  //     Logger().v("Path Galley :: ${selectedFile?.path ?? ''}");
  //
  //     // if (selectedFile != null) {
  //     //   int fileSize = selectedFile.lengthSync();
  //     //   if (fileSize >= 10 * 1024 * 1024) {
  //     //     Utils.showProgressDialog(NavigationService().context);
  //     //     MediaInfo? mediaInfo = await VideoCompress.compressVideo(selectedFile.path, quality: VideoQuality.MediumQuality, deleteOrigin: false,);
  //     //     await Utils.dismissProgressDialog(NavigationService().context);
  //     //     if (mediaInfo != null) {
  //     //       if (callBack != null) {
  //     //         callBack((mediaInfo.file != null) ? [mediaInfo.file!] : null, 1);
  //     //         return;
  //     //       }
  //     //     }
  //     //   }
  //     // }
  //     if (callBack != null) {
  //       callBack((selectedFile != null) ? [selectedFile] : null, 1);
  //     }
  //   } catch(error) {
  //     Logger().v("Error :: ${error.toString()}");
  //   }
  // }
  // //endregion



  Future<File> writeAssetToFile(Asset asset, String filename) async {
    final data = await asset.getByteData(quality: 40);
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/$filename';
    File saveFile = File(filePath);
    await saveFile.writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    Logger().v('Save File :: ${saveFile.path}');
    // File fixedRotationFile = await FlutterExifRotation.rotateAndSaveImage(path: saveFile.path);
    // Logger().v('Path Fixed Rotation Galley :: ${fixedRotationFile?.path ?? ''}');
    return saveFile;
    // return fixedRotationFile;
  }

}
