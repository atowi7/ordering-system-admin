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
      backgroundColor: Colors.grey[100],
      body: Form(
          key: userProvider.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Image.network(
                    AppLinks.logo,
                    scale: 6,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image,
                      size: 400,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Log in',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Row(
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.person_2,
                              color: Colors.white,
                              size: 20,
                            )),
                        const VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                          width: 2,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 8),
                                child: Text('User name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .primaryColor)),
                              ),
                              TextFormField(
                                controller: userProvider.emailController,
                                validator: (value) =>
                                    userProvider.validateName(value),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      color: Colors.grey[400],
                                      height: 1,
                                    ),
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: 20,
                                        color: Colors.grey[400],
                                        height: 1,
                                      ),
                                  hintText: "Fx: golyv",
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Row(
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 20,
                            )),
                        const VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                          width: 2,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 8),
                                child: Text('Password',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .primaryColor)),
                              ),
                              TextFormField(
                                controller: userProvider.passwordController,
                                validator: (value) =>
                                    userProvider.validateName(value),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                       color: Colors.grey[400],
                                      height: 1,
                                    ),
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                         color: Colors.grey[400],
                                        height: 1,
                                        fontSize: 20,
                                      ),
                                  hintText: "•••••••••••••",
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // contentPadding: EdgeInsets.zero,
                                ),
                                obscureText: true,
                                obscuringCharacter: '•',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  const SizedBox(height: 16),
                  userProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              //  await userProvider.login();
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.home);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                            child: Text(
                              "Sign in",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Colors.white),
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
