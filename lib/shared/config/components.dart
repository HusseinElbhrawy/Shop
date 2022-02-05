import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:new_shop_appl/screens/login/login_screen.dart';
import 'package:new_shop_appl/shared/SharedPref/shared_helper.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/bloc/login_bloc.dart';

void validateAndLogIn(
    {required BuildContext context,
    required String email,
    required String password}) {
  if (Form.of(context)!.validate()) {
    LoginBloc.object(context).loginMethod(
      email: email,
      password: password,
    );
  }
}

MotionToast errorToast(String messageState) {
  return MotionToast.error(
    title: const Text("Error"),
    description: Text(
      messageState,
    ),
  );
}

signOut(context) {
  SharedHelper.deleteValue(key: kLoginTokenKey);
  navigateToWithReplacement(context: context, nextPage: const LoginScreen());
}

navigateTo({required context, required nextPage}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );

navigateToWithReplacement({required context, required nextPage}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => nextPage,
      ),
    );

var information = Platform.localeName.characters.toList();
String lang = '${information[0]}${information[1]}';

class CachedNetworkImageErrorWidget extends StatelessWidget {
  const CachedNetworkImageErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.error,
      color: Colors.blue,
    );
  }
}

class CachedNetworkImageProgressIndicator extends StatelessWidget {
  const CachedNetworkImageProgressIndicator({
    Key? key,
    required this.downloadProgress,
  }) : super(key: key);
  final DownloadProgress downloadProgress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
      ),
    );
  }
}
