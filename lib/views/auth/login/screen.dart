import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/providers/auth_provider.dart';
import 'package:ordering_system_admin/views/auth/login/manager/manager.dart';
import 'package:ordering_system_admin/views/auth/login/widgets/custombutton.dart';
import 'package:ordering_system_admin/views/auth/login/widgets/logo.dart';
import 'package:ordering_system_admin/views/auth/login/widgets/customtextfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthManager authManager = AuthManager(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Form(
          key: authManager.authProvider.loginFormKey,
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
                    child: Text('Log in', style: AppTheme.loginHead),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    label: 'User name',
                    hint: "Fx: golyv",
                    obscureText: false,
                    controller: authManager.authProvider.emailController,
                    validator: (value) =>
                        authManager.authProvider.validateName(value),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Password',
                    hint: "•••••••••••••",
                    obscureText: true,
                    controller: authManager.authProvider.passwordController,
                    validator: (value) =>
                        authManager.authProvider.validateName(value),
                  ),
                  const SizedBox(height: 16),
                  authManager.authProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Sign in',
                          login: () {
                            authManager.login();
                          },
                        )
                ],
              ),
            ),
          )),
    ));
  }
}
 // TextFormField(
                  //   controller: authProvider.emailController,
                  //   validator: (value) => authProvider.validateName(value),
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
                  //       labelText: "Auth name",
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
                  //   controller: authProvider.passwordController,
                  //   validator: (value) => authProvider.validatePassword(value),
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