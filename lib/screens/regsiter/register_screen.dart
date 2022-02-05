import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/screens/home/home_screen.dart';
import 'package:new_shop_appl/screens/login/components/custom_text_form_filed.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/bloc/register_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final userNameController = TextEditingController();
  static final passwordController = TextEditingController();
  static final phoneController = TextEditingController();

  void clearController() {
    emailController.clear();
    userNameController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var registerCubit = RegisterBloc.object(context);

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(start: kDefaultPadding),
                child: Text(
                  'REGISTER',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              const Divider(color: Colors.white),
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(start: kDefaultPadding),
                child: Text(
                  'Register now to browse our hot offers',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const Divider(color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: CustomTextFormFiled(
                  validateMessage: 'User Name must not be empty',
                  keyboardType: TextInputType.name,
                  controller: userNameController,
                  prefixIcon: Icons.person_outlined,
                  hintLabel: 'User Name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: CustomTextFormFiled(
                  validateMessage: 'Email Address must not be empty',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  hintLabel: 'Email Address',
                ),
              ),
              BlocConsumer<RegisterBloc, ShopStates>(
                listener: (BuildContext context, state) {},
                builder: (BuildContext context, Object? state) {
                  return Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: CustomTextFormFiled(
                      validateMessage: 'Password must not be empty',
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: registerCubit.isPasswordHidden,
                      suffixIcon: IconButton(
                        onPressed: () {
                          registerCubit.changeIcon();
                        },
                        icon: registerCubit.isPasswordHidden
                            ? const Icon(
                                Icons.visibility_outlined,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.black,
                              ),
                      ),
                      controller: passwordController,
                      prefixIcon: Icons.lock_outlined,
                      hintLabel: 'Password',
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: CustomTextFormFiled(
                  keyboardType: TextInputType.phone,
                  validateMessage: 'Phone number not must be empty',
                  controller: phoneController,
                  prefixIcon: Icons.phone_outlined,
                  hintLabel: 'Phone',
                ),
              ),
              Divider(
                color: Colors.black,
                indent: width / 25,
                endIndent: width / 25,
              ),
              BlocConsumer<RegisterBloc, ShopStates>(
                listener: (BuildContext context, state) {
                  if (state is RegisterSuccess) {
                    if (state.registerModel.status as bool) {
                      //ToDo:Go To Home Screen
                      navigateToWithReplacement(
                        context: context,
                        nextPage: const HomeScreen(),
                      );
                      clearController();
                    } else {
                      errorToast(state.registerModel.message.toString())
                          .show(context);
                    }
                  }
                },
                builder: (BuildContext context, Object? state) {
                  return state is RegisterLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: TextButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                Size(
                                  double.infinity,
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? height / 15
                                      : height / 8,
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              validateAndRegister(registerCubit);
                            },
                            child: Text(
                              'register'.toUpperCase(),
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndRegister(RegisterBloc registerCubit) {
    if (formKey.currentState!.validate()) {
      registerCubit.registerMethod(
        name: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      );
    }
  }
}
