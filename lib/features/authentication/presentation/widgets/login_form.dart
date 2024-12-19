import 'package:coding_test/core/widgets/custom_text_field.dart';
import 'package:coding_test/features/authentication/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coding_test/features/authentication/presentation/state_management/login_bloc.dart';
import 'package:coding_test/features/authentication/presentation/state_management/login_event.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginForm({required this.formKey, super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Email',
            obscureText: false,
            onSaved: (email) => emailController.text = email ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CustomTextField(
              hintText: 'Password',
              obscureText: true,
              onSaved: (password) => passwordController.text = password ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
          ),
          LoginButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.read<LoginBloc>().add(LoginButtonPressed(
                      email: emailController.text,
                      password: passwordController.text,
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
