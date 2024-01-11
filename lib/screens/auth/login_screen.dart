import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/root.dart';
import 'package:shop_smart/screens/auth/register_screen.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../../consts/my_validators.dart';
import '../../services/my_app_methods.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/auth/google_button.dart';
import '../inner_screens/loading_manger.dart';
import 'forgot_password_screen.dart';

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
  bool obscureText = true;
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;

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

    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _isLoading = true;
        });
        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        Navigator.pushNamed(context, RootScreen.id);
      } on FirebaseAuthException catch (error) {
        await MyAppMethods.showErrorOrWarningDialog(
          fct: () {},
          subTitle: "An error has been occured ${error.message}",
          context: context,
        );
      } catch (error) {
        await MyAppMethods.showErrorOrWarningDialog(
          context: context,
          fct: () {},
          subTitle: "An error has been occured $error",
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManger(
          isLoading: _isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const AppNameTextWidget(),
                  const SizedBox(height: 20),
                  const Align(
                      alignment: Alignment.topLeft,
                      child:
                          TitlesTextWidget(label: "Welome back", fontSize: 20)),
                  const SubtitleTextWidget(
                      label:
                          "Lets get you logged in so you can start exploring",
                      fontSize: 16),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                      key: _formKey,
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
                              FocusScope.of(context)
                                  .requestFocus(_passwordlFoucsNode);
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
                            obscureText: obscureText,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      obscureText = !obscureText;
                                      setState(() {});
                                    },
                                    icon: Icon(obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                hintText: "*****",
                                prefixIcon: const Icon(IconlyLight.lock)),
                            validator: (value) {
                              return MyValidators.passwordValidator(value);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgetPassswordScreen.id);
                              },
                              child: const SubtitleTextWidget(
                                label: "Forgot Password?",
                                fontSize: 22,
                                textDecoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await _loginFct();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(300,
                                    75), // Set your preferred minimum width and height
                              ),
                              child: const Text(
                                "Sign in",
                                style: TextStyle(fontSize: 22),
                              )),
                          const SizedBox(height: 30),
                          const TitlesTextWidget(
                            label: "OR CONNECT USING",
                            fontSize: 20,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(
                                child: GoogleButton(),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RootScreen.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(150, 50)),
                                  child: const Text(
                                    "Guest?",
                                    style: TextStyle(fontSize: 22),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SubtitleTextWidget(
                                  label: "Don`t have an account?",
                                  fontSize: 18),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RegisterScreen.id);
                                  },
                                  child: const SubtitleTextWidget(
                                    label: "Sign Up",
                                    fontSize: 18,
                                    textDecoration: TextDecoration.underline,
                                  ))
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
