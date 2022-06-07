import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:keda_flutter/service/request/edit_user_request.dart';
import 'package:keda_flutter/service/response/login_response.dart';
import 'package:keda_flutter/service/response/products_response.dart';
import 'package:keda_flutter/service/response/user_account_status_response.dart';
import 'package:keda_flutter/service/response/user_rate_review_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_s3/simple_s3.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys_paths;

import '../ui/authentication/models/login_data_model.dart';
import '../ui/bottomNavigation/profileModule/models/user_account_model.dart';
import '../ui/bottomNavigation/profileModule/models/user_rate_review_model.dart';
import '../utils/credentials.dart';
import '../utils/logger.dart';
import '../utils/media_selector.dart';

class ProfileProvider extends BaseBloc with ChangeNotifier{
  final userProducts = [];
  int? totalProducts = 0;
  int pageCount = 0;
  bool isLoading = false;
  File? imageFile;
  Uri? imageUri;
  UserAccount? userAccount;
  UserRateReview? userRateReview;

  Future<UserRateReviewResponse?> getUserRateReviewAPI() async {
    var user = await LoginData.getUserDetails();
    Map<String, dynamic> map = {};
    map["payment_status"] = "All";
    map["to_user_id"] = user.id;
    UserRateReviewResponse? response = await repository.fetchUserRateReview(map);
    userRateReview = response?.userRateReview;
    notifyListeners();
    return response;
  }

  Future<UserAccountStatusResponse?> getUserAccountDetails() async {
    var user = await LoginData.getUserDetails();
    Map<String, dynamic> map = {};
    map["user_id"] = user.id;
    UserAccountStatusResponse? response = await repository.fetchUserAccountStatus(map);
    userAccount = response?.userAccount;
    notifyListeners();
    return response;
  }

  Future<ProductsResponse?> getUserProducts({ bool? isPagination = false, bool? refresh = false}) async {

    if(isPagination == true){
      pageCount += 1;
      isLoading = true;
      notifyListeners();
    }

    if(refresh == true){
      userProducts.clear();
      pageCount = 0;
    }

    var user = await LoginData.getUserDetails();
    Map<String, dynamic> map = {};
    map["user_id"] = user.id;
    map["limit"] = 10;
    map["record_count"] = pageCount;
    ProductsResponse? response = await repository.fetchUserProductsAPI(map);
    userProducts.addAll(response?.items ?? []);
    totalProducts = response?.totalRecords ?? 0;
    isLoading = false;
    notifyListeners();
    return response;
  }

  checkPermissionAndUploadImage(BuildContext context) async {
    MediaSelector mediaSelector = MediaSelector();
    mediaSelector.chooseImageWithOption(context, purpose: MediaFor.profile, callBack: (file, type) async {
      if(file != null){
        imageFile = file.first;
        imageUri = imageFile?.uri;
        Logger().v("Selected path ${imageUri?.path}");
        Logger().v("Last Path ${imageUri?.pathSegments.last}");

        //For saving a file to device
        final appDir = await sys_paths.getApplicationDocumentsDirectory();
        final fileName = path.basename(imageFile?.path ?? "newFile");
        final savedImage = await imageFile?.copy("${appDir.path}/$fileName");
        Logger().v("Saved Path ${savedImage?.path}");
      }
      notifyListeners();
    }, isCropImage: true);
  }

  Future<LoginResponse> editUserAPI({String? name, String? email, String? phone, String? aboutUs }) async {
    var user = await LoginData.getUserDetails();
    EditUserRequest editUserRequest = EditUserRequest();
    editUserRequest.aboutUs = aboutUs;
    editUserRequest.countryCode = user.countryCode;
    editUserRequest.email = email;
    editUserRequest.id = user.id;
    editUserRequest.mobile = phone;
    editUserRequest.notificationStatus = user.notificationStatus;
    editUserRequest.registerType = user.registerType;
    editUserRequest.userName = name;
    if(imageUri != null){
      var result = await _upload();
      if(result != null){
        editUserRequest.mSelectedMediaPath = imageUri?.path;
        editUserRequest.profilePicture = imageUri?.pathSegments.last;
      }
    }
    LoginResponse response = await repository.editUserAPI(editUserRequest);
    return response;
  }

  Future<String?> _upload() async {
    String? result;
    SimpleS3 _simpleS3 = SimpleS3();

    /**
     * To get Upload percentage
      */
    // StreamBuilder<dynamic>(
    //     stream: _simpleS3.getUploadPercentage,
    //     builder: (context, snapshot) {
    //       return new Text(
    //         snapshot.data == null
    //             ? "Simple S3 Test"
    //             : "Uploaded: ${snapshot.data}",
    //       );
    //     })

    if (result == null) {
      try {
        result = await _simpleS3.uploadFile(
          imageFile!,
          Credentials.s3_bucketName,
          Credentials.s3_poolD,
          AWSRegions.apSouth1,
          debugLog: true,
          s3FolderPath: "keda/Temp",
          accessControl: S3AccessControl.publicRead,
        );

      } catch (e) {
        Logger().e(e);
      }
    }
    return result;
  }
}