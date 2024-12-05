import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/providers/user_provider.dart';
import 'package:ordering_system_admin/views/auth/login/widgets/custombutton.dart';
import 'package:ordering_system_admin/views/auth/login/widgets/logo.dart';
import 'package:ordering_system_admin/views/auth/login/widgets/customtextfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Form(
          key: userProvider.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  const Logo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                 const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Log in',
                        style:
                            AppTheme.loginHead),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    label: 'User name',
                    hint: "Fx: golyv",
                    obscureText: false,
                    controller: userProvider.emailController,
                    validator: (value) => userProvider.validateName(value),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Password',
                    hint: "•••••••••••••",
                    obscureText: true,
                    controller: userProvider.passwordController,
                    validator: (value) => userProvider.validateName(value),
                  ),
                  const SizedBox(height: 16),
                  userProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const CustomButton(text: 'Sign in')
                ],
              ),
            ),
          )),
    ));
  }
}
 // TextFormField(
                  //   controller: userProvider.emailController,
                  //   validator: (value) => userProvider.validateName(value),
                  //   decoration: InputDecoration(
                  //       prefixIcon: Container(
                  //           margin: const EdgeInsets.all(5),
                  //           decoration: BoxDecoration(
                  //               color: Colors.grey,
                  //               borderRadius: BorderRadius.circular(50)),
                  //           child: const Icon(
                  //             Icons.person,
                  //             color: Colors.white,
                  //           )),
                  //       hintStyle: Theme.of(context).textTheme.displayMedium,
                  //       labelText: "User name",
                  //        labelStyle: Theme.of(context)
                  //           .textTheme
                  //           .displayMedium!
                  //           .copyWith(color: Theme.of(context).primaryColor),
                  //       hintText: "Fx: golyv",
                  //       focusedBorder:
                  //           InputBorder.none,
                  //       enabledBorder: InputBorder.none,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       fillColor: Colors.grey[200],
                  //       filled: true),
                  // ),

// TextFormField(
                  //   controller: userProvider.passwordController,
                  //   validator: (value) => userProvider.validatePassword(value),
                  //   decoration: InputDecoration(
                  //     prefixIcon: Container(
                  //         margin: const EdgeInsets.all(5),
                  //         decoration: BoxDecoration(
                  //             color: Colors.grey,
                  //             borderRadius: BorderRadius.circular(50)),
                  //         child: const Icon(
                  //           Icons.lock,
                  //           color: Colors.white,
                  //         )),
                  //     labelText: "Password",
                  //     labelStyle: Theme.of(context)
                  //         .textTheme
                  //         .displayMedium!
                  //         .copyWith(color: Theme.of(context).primaryColor),
                  //     hintStyle: Theme.of(context).textTheme.displayMedium,
                  //     hintText: "0000000000",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     focusedBorder:
                  //         InputBorder.none, // Removes the border when focused
                  //     enabledBorder: InputBorder.none,
                  //     fillColor: Colors.grey[200],
                  //     filled: true,
                  //   ),
                  //   obscureText: true,
                  //   obscuringCharacter: '•',
                  // ),