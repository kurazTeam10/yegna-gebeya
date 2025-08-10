import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubit/sign_up_state.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode passwordConfirmFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add listeners to rebuild on focus changes
    fullNameFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    passwordFocus.addListener(() => setState(() {}));
    passwordConfirmFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();

    fullNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    passwordConfirmFocus.dispose();

    super.dispose();
  }

  InputDecoration getInputDecoration({
    required String label,
    required IconData icon,
    required bool isFocused,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
      // Gray bottom line when unfocused
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      // Remove underline when focused (transparent)
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    bool isFocused = focusNode.hasFocus;

    return Container(
      decoration: isFocused
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(6),
            )
          : null,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: getInputDecoration(
          label: label,
          icon: icon,
          isFocused: isFocused,
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          fullNameController.clear();
          emailController.clear();
          passwordController.clear();
          passwordConfirmController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Sign up successful!")),
          ); // Go back to login
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              // Scrollable form part
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildTextField(
                        controller: fullNameController,
                        focusNode: fullNameFocus,
                        label: 'FULL NAME',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                      buildTextField(
                        controller: emailController,
                        focusNode: emailFocus,
                        label: 'EMAIL',
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 20),
                      buildTextField(
                        controller: passwordController,
                        focusNode: passwordFocus,
                        label: 'PASSWORD',
                        icon: Icons.key,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      buildTextField(
                        controller: passwordConfirmController,
                        focusNode: passwordConfirmFocus,
                        label: 'CONFIRM PASSWORD',
                        icon: Icons.key,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          if (state is SignUpLoading) {
                            return const CircularProgressIndicator();
                          }
                          return Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8D00DE),
                              ),
                              onPressed: () {
                                if (!RegExp(
                                  r"^[^@]+@[^@]+\.[^@]+",
                                ).hasMatch(emailController.text.trim())) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please enter a valid email address",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                context.read<SignUpCubit>().signUp(
                                  emailController.text,
                                  passwordController.text,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom link (fixed)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
