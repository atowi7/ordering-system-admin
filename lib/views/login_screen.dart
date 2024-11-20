import 'package:flutter/material.dart';
import 'package:ordering_system_admin/constant/app_routes.dart';
import 'package:ordering_system_admin/constant/app_links.dart';
import 'package:ordering_system_admin/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[350],
      body: Form(
          key: userProvider.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Image.network(
                    AppLinks.logo,
                    scale: 1.5,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image,
                      size: 100,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Login',
                        style: Theme.of(context).textTheme.displayLarge),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: userProvider.emailController,
                    validator: (value) => userProvider.validateName(value),
                    decoration: InputDecoration(
                        prefixIcon: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(Icons.person)),
                        hintText: "Email",
                        hintStyle: Theme.of(context).textTheme.displayMedium,
                        labelText: "Fxuoidu",
                        labelStyle: Theme.of(context).textTheme.displayMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        fillColor: Colors.transparent.withOpacity(0.1),
                        filled: true),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: userProvider.passwordController,
                    validator: (value) => userProvider.validatePassword(value),
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(Icons.lock)),
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.displayMedium,
                      labelText: "password",
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fillColor: Colors.transparent.withOpacity(0.1),
                      filled: true,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  userProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              //  await userProvider.login();
                              Navigator.pushReplacementNamed(context, AppRoutes.home);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Theme.of(context).primaryColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Text(
                              "Sign in",
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )),
    ));
  }
}
