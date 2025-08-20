import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_state.dart';
import 'package:yegna_gebeya/features/auth/presentation/widgets/text_form_widget.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isVisible = false;
  String? _sellectedRole;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }

            if (state is SignUpSuccess) {
              // context.go(Routes.verify);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.1,
                    left: width * 0.05,
                  ),
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: height * 0.02),
                        TextFormWidget(
                          controller: _fullNameController,
                          labelText: 'FULL NAME',
                          icon: Icon(Icons.person_2_outlined),
                          focusNode: _fullNameFocusNode,
                        ),
                        TextFormWidget(
                          controller: _emailController,
                          labelText: 'EMAIL',
                          icon: Icon(Icons.email_outlined),
                          focusNode: _emailFocusNode,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            // Simple email regex
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        TextFormWidget(
                          controller: _passwordController,
                          labelText: 'PASSWORD',
                          icon: Icon(Icons.key),
                          focusNode: _passwordFocusNode,
                        ),
                        TextFormWidget(
                          controller: _confirmPasswordController,
                          labelText: 'CONFIRM PASSWORD',
                          icon: Icon(Icons.key),
                          focusNode: _confirmPasswordFocusNode,
                        ),
                        DropdownButtonFormField<String>(
                          value: _sellectedRole,
                          decoration: InputDecoration(
                            labelText: 'ROLE',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'buyer',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Buyer'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'seller',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.storefront_outlined,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Seller'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _sellectedRole = value;
                            });
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Align(
                          alignment: Alignment.centerRight,
                          child: BlocBuilder<SignUpCubit, SignUpState>(
                            builder: (context, state) {
                              if (state is SignUpLoading) {
                                return Container(
                                  margin: EdgeInsets.only(right: width * 0.05),
                                  width: width * 0.08,
                                  height: width * 0.08,
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return SizedBox(
                                width: width * 0.32,
                                height: height * 0.06,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    foregroundColor: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<SignUpCubit>().signUp(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        weight:
                                            800, // Makes the icon thicker (Flutter 3.10+)
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(Routes.signIn);
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
