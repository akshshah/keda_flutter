import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keda_flutter/utils/app_image.dart';
import 'package:keda_flutter/utils/mixin/common_widget.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../../../../utils/logger.dart';
import '../../../../utils/media_selector.dart';
import '../../../../utils/utils.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.submitFn, required this.isLoading}) : super(key: key);

  final void Function(String email, String password, String username, File? imageFile, bool isLogin) submitFn;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var isLogin = true;
  File? imageFile;
  Uri? imageUri;
  var imagePicked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _submitForm(){
    FocusScope.of(context).unfocus();

    if(imageFile == null && !isLogin){
      Utils.showSnackBarWithContext(context, "Please pick an image.");
      return;
    }

    widget.submitFn(_emailController.text.trim(), _passwordController.text.trim(), _usernameController.text.trim(), imageFile, isLogin);
  }

  _checkPermissionAndUploadImage() async {
    MediaSelector mediaSelector = MediaSelector();
    mediaSelector.chooseImageWithOption(context, purpose: MediaFor.profile, callBack: (file, type) async {
      if(file != null){
        imageFile = file.first;
        imageUri = imageFile?.uri;
        Logger().v("Selected path ${imageUri?.path}");
        Logger().v("Last Path ${imageUri?.pathSegments.last}");

        if(imageFile != null){
          setState(() {
            imagePicked = true;
          });
        }

        // //For saving a file to device
        // final appDir = await sys_paths.getApplicationDocumentsDirectory();
        // final fileName = path.basename(imageFile?.path ?? "newFile");
        // final savedImage = await imageFile?.copy("${appDir.path}/$fileName");
        // Logger().v("Saved Path ${savedImage?.path}");
      }
    }, isCropImage: true);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text( isLogin ? "Login" : "Signup", style: UITextStyle.boldTextStyle(fontSize: 30),),
                  const SizedBox(height: 20,),
                  if (!isLogin)
                    InkWell(
                    onTap: (){
                      _checkPermissionAndUploadImage();
                    },
                    child: !imagePicked ?
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(AppImage.personImage),
                      ) : CircleAvatar(
                      radius: 45,
                      backgroundImage: FileImage(imageFile!),
                    ),
                  ),
                  if(!isLogin)
                    const SizedBox(height: 15,),
                  CommonWidget.createTextField(
                    labelText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (!isLogin)
                    CommonWidget.createTextField(
                      labelText: "Username",
                      action: TextInputAction.next,
                      controller: _usernameController,
                    ),
                  if (!isLogin)
                    const SizedBox(
                      height: 15,
                    ),
                  CommonWidget.createTextField(
                    labelText: "Password",
                    obscureText: true,
                    action: TextInputAction.done,
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if(widget.isLoading)
                    const CircularProgressIndicator(),
                  if(!widget.isLoading)
                    CommonWidget.myFullButton(isLogin ? "Login" : "Signup", (){
                      _submitForm();
                    }),
                  if(!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: TextButton(
                        onPressed: () {
                          setState((){
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin ? "Create new account." : "I already have an account.",
                          style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
