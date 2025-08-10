import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubit/sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add listeners to rebuild on focus changes
    emailFocus.addListener(() => setState(() {}));
    passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();

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
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          emailController.clear();
          passwordController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Sign In successful!")),
          ); // Go back to login
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
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
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  if (state is SignInLoading) {
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
                        context.read<SignInCubit>().signIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "LOGIN",
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
    );
  }
}
