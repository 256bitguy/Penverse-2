import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:penverse/core/constants/app_colors.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../ui/widgets/custom_text_field.dart';
import 'forgot_password_screen.dart';
import '../../../features/entrypoint/entrypoint_ui.dart';

import '../ui/viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context, void Function(String, String) onLogin) {
    if (_formKey.currentState?.validate() ?? false) {
      onLogin(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      distinct: true,
      converter: (store) => LoginViewModel.fromStore(store, context),
      builder: (context, vm) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const EntryPointUI()),
            );
          } else if (vm.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(vm.errorMessage!)),
            );
          }
        });

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: ResponsiveUtils.getScreenPadding(context),
                child: Container(
                  width: ResponsiveUtils.getFormWidth(context),
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Log in',
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(height: 8),
                        Text('Welcome back!',
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 32),

                        /// Email
                        CustomTextField(
                          label: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        /// Password
                        CustomTextField(
                          label: 'Password',
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        /// Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        const SizedBox(height: 32),

                        /// Login Button
                        CustomButton(
                          text: 'Log in',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const EntryPointUI()),
                            );
                          },
                        ),

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/create-account');
                              },
                              child: const Text('Create an account'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ViewModel for Redux
