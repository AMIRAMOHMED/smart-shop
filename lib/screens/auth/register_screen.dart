import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_smart/services/my_app_methods.dart';

import '../../consts/my_validators.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/auth/pick_image_widget.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text_.dart';

class RegisterScreen extends StatefulWidget {
  static const id = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _confirmPasswordController;
  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  XFile? _pickImage;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _registerFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
        context: context,
        galleryFct: () async {
          _pickImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFct: () {
          setState(() {
            _pickImage = null;
          });
        },
        cameraFct: () async {
          _pickImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                const AppNameTextWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitlesTextWidget(
                        label: "Welcome",
                        fontSize: 20,
                      ),
                      SubtitleTextWidget(
                        label:
                            "Sign up now ro receive specail offers and update from our app",
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: size.height * .3,
                  width: size.height * .3,
                  child: PickImageWidget(
                    pickImage: _pickImage,
                    function: () async {
                      await localImagePicker();
                    },
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Full name",
                          prefixIcon: Icon(
                            IconlyLight.message,
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.displayNamevalidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email address",
                          prefixIcon: Icon(
                            IconlyLight.message,
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "*********",
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_confirmPasswordFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "*********",
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.repeatPasswordValidator(
                              value: value,
                              password: _passwordController.text);
                        },
                        onFieldSubmitted: (value) {
                          _registerFct();
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            // backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          icon: const Icon(IconlyLight.add_user),
                          label: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            _registerFct();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
