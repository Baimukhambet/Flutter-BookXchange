import 'package:cubit_test/features/auth/bloc/auth_bloc.dart';
import 'package:cubit_test/features/auth/providers/auth_manager.dart';
import 'package:cubit_test/features/auth/services/auth_service.dart';
import 'package:cubit_test/features/auth/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  AuthService authService = AuthService.shared;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  final TextEditingController _regRepeatPasswordController =
      TextEditingController();

  final AuthBloc bloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is AuthInitial) {
              return Consumer<AuthManager>(
                builder: (context, provider, child) {
                  if (provider.currentType == AuthType.login) {
                    return _showLoginUI(context, bloc);
                  }
                  return _showRegisterUI(context, bloc);
                },
              );
            } else if (state is AuthFailed) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.failMessage),
                  TextButton(
                      onPressed: () {
                        bloc.add(AuthRetryTapped());
                      },
                      child: Text("Попробовать снова"))
                ],
              ));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _showLoginUI(BuildContext context, AuthBloc bloc) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Войдите в аккаунт", style: theme.textTheme.displayLarge),
          const SizedBox(height: 24),
          InputField(
            controller: _emailController,
            hintText: "Email",
            hide: false,
          ),
          const SizedBox(height: 24),
          InputField(
            controller: _passwordController,
            hintText: "Password",
            hide: true,
          ),
          const SizedBox(height: 24),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    bloc.add(AuthLoginTapped(
                        email: _emailController.text,
                        password: _passwordController.text));
                  },
                  child: const Text("Войти"))),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Нет аккаунта? "),
              GestureDetector(
                onTap: () =>
                    context.read<AuthManager>().changeType(AuthType.register),
                child: Text("Зарегистрироваться ",
                    style: TextStyle(color: Colors.blueAccent)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _showRegisterUI(BuildContext context, AuthBloc bloc) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Регистрация", style: theme.textTheme.displayLarge),
          const SizedBox(height: 24),
          InputField(
            controller: _regEmailController,
            hintText: "Почта",
            hide: false,
          ),
          const SizedBox(height: 24),
          InputField(
            controller: _regPasswordController,
            hintText: "Пароль",
            hide: true,
          ),
          const SizedBox(height: 24),
          InputField(
            controller: _regRepeatPasswordController,
            hintText: "Повторите пароль",
            hide: true,
          ),
          const SizedBox(height: 24),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    bloc.add(AuthRegisterTapped(
                        email: _regEmailController.text,
                        password: _regPasswordController.text,
                        repeatPassword: _regRepeatPasswordController.text));
                  },
                  child: const Text("Зарегистрироваться"))),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Уже есть аккаунт? "),
              GestureDetector(
                onTap: () =>
                    context.read<AuthManager>().changeType(AuthType.login),
                child:
                    Text("Войти", style: TextStyle(color: Colors.blueAccent)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
