import 'package:flutter/material.dart';
import 'package:new_shop_appl/screens/regsiter/register_screen.dart';
import 'package:new_shop_appl/shared/config/components.dart';

class DontHaveAccountAndRegisterWidget extends StatelessWidget {
  const DontHaveAccountAndRegisterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        TextButton(
          onPressed: () {
            navigateTo(context: context, nextPage: RegisterScreen());
          },
          child: const Text(
            'REGISTER',
          ),
        ),
      ],
    );
  }
}
