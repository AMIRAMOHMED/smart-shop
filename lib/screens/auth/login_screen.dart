import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../consts/my_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFoucsNode;
  late final FocusNode _passwordlFoucsNode;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordlFoucsNode = FocusNode();
    _emailFoucsNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _emailFoucsNode.dispose();
    _passwordlFoucsNode.dispose();
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: _emailFoucsNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "Email Address",
                  prefixIcon: Icon(IconlyLight.message)),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_passwordlFoucsNode);
              },
              validator: (value) {
                return MyValidators.emailValidator(value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onFieldSubmitted: (value) {
                _loginFct();
              },
              controller: _passwordController,
              focusNode: _passwordlFoucsNode,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                  hintText: "*****", prefixIcon: Icon(IconlyLight.lock)),
              validator: (value) {
                return MyValidators.passwordValidator(value);
              },
            ),
          ],
        )),
      ),
    );
  }
}
