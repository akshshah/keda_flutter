import 'package:flutter/material.dart';

import 'localization.dart';

class $zh extends Translations {

 const $zh();

  @override TextDirection get textDirection => TextDirection.ltr;

  @override String get appName => 'Steel Trading Customer';

  /* SerVice Message */
  @override String get msgSomethingWrong => '出现了一些问题';
  @override String get msgInternetMessage => '请检查您的网络连接.';
  @override String get msgSessionExpired => '会话已过期，请再次登录';

  /* Permission Ask Message */
  @override String get msgProfilePhotoSelection => 'ENTRISE 需要您的相机或相册权限去设置您的图片.';
  @override String get msgQrCodePhotoSelection => 'ENTRISE 需要您的相机或相册权限去设置您的二维码照片.';
  @override String get msgCameraPermissionProfile => 'ENTRISE 需要您的相机权限上传您的图片,请去设置给予权限';
  @override String get msgPhotoPermissionProfile => 'ENTRISE 需要您的相册权限上传您的图片,请去设置给予权限';
  @override String get msgCameraPermission => 'App 需要您的相机权限去截取图片, 请去设置给予权限';
  @override String get msgPhotoPermission => 'App 需要您的相册权限上传图片, 请去设置给予权限';
  @override String get msgMicroPhonePermission => 'App 需要您的麦克风权限通话, 请去设置给予权限';
  @override String get msgCameraPermissionToCall => 'App 需要您的摄像头权限, 请去设置给予权限';
  @override String get msgCameraPermissionToScanQrCode => 'App 需要相机权限扫描二维码, 请去设置给予权限';
  @override String get msgNotificationPermission => '应用需要通知权限才能获取更新，进入设置并允许访问';
  @override String get msgPhotoPermissionForSave => '应用需要照片权限才能将照片保存在您的照片库中，进入设置并允许访问';

  /* Media Selection */
  @override String get strAlert => "警报";
  @override String get strTakePhoto => "照相";
  @override String get strChooseFromExisting => "选择照片";
  @override String get strImage => "图片";
  @override String get strVideo => "视频";

  /* Common Button List */
  @override String get btnCancel => '取消';
  @override String get btnOk => '好';
  @override String get btnDelete => '删除';
  @override String get btnDecline => '拒绝';
  @override String get btnSave => '保存';
  @override String get btnSubmit => '上传';
  @override String get btnYes => '是';
  @override String get btnNo => '否';
  @override String get btnDone => '完成';
  @override String get btnEdit => '编辑';
  @override String get btnAdd => '添加';
  @override String get btnConfirm => '确认';
  String get btnSearch => '搜索';
}