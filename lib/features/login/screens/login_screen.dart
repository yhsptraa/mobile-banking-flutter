import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';
import '../widgets/password_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login', style: textTheme.headlineLarge),
                    const SizedBox(height: 150),
                    AppInput(
                      label: 'Username',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PasswordInput(
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Password wajib diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    Builder(
                      builder: (buttonContext) {
                        return AppButton(
                          label: 'Login', 
                          onPressed: () {
                            FocusScope.of(buttonContext).unfocus();

                            if(!Form.of(buttonContext).validate()) {
                              return;
                            }

                            ScaffoldMessenger.of(buttonContext).showSnackBar(
                              const SnackBar(
                                content: Text('Berhasil validasi data')
                              ),
                            );
                          },
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}