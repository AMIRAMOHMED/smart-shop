import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/models/user_model.dart';
import 'package:shop_smart/provider/user_provider.dart';
import 'package:shop_smart/screens/inner_screens/order_screen/order_screen.dart';
import 'package:shop_smart/screens/inner_screens/wishlist_screen.dart';
import 'package:shop_smart/services/assest_manger.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../provider/them_provider.dart';
import '../services/my_app_methods.dart';
import '../widgets/app_name_text.dart';
import 'auth/login_screen.dart';
import 'inner_screens/loading_manger.dart';
import 'inner_screens/viewd_recently.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;

  bool _isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await MyAppMethods.showErrorOrWarningDialog(
          fct: () {},
          subTitle: "An error has been occured $error",
          context: context,
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const AppNameTextWidget(),
          leading: Image.asset(AssetsManager.shoppingCart),
        ),
        body: LoadingManger(
          isLoading: _isLoading,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Visibility(
                  visible: user == null ? true : false,
                  child: const TitlesTextWidget(
                    label: "Please Login to Have Unltimate acces",
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                userModel == null
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                    width: 3,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                image: DecorationImage(
                                    image: NetworkImage(userModel!.userIamge),
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(
                                  label: userModel!.userName, fontSize: 20),
                              SubtitleTextWidget(
                                  label: userModel!.userEmail, fontSize: 18)
                            ],
                          )
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitlesTextWidget(label: "General", fontSize: 20),
                    CustomListTile(
                      text: "All orders ",
                      function: () async {
                        await Navigator.pushNamed(context, OrderScreen.id);
                      },
                      imagePath: AssetsManager.orderSvg,
                    ),
                    CustomListTile(
                      text: "WishList",
                      function: () async {
                        await Navigator.pushNamed(context, WishListScreen.id);
                      },
                      imagePath: AssetsManager.wishlistSvg,
                    ),
                    CustomListTile(
                      text: "Viewed recently",
                      function: () async {
                        await Navigator.pushNamed(
                            context, ViewedRecentlyPage.id);
                      },
                      imagePath: AssetsManager.recent,
                    ),
                    CustomListTile(
                      text: "Address",
                      function: () {},
                      imagePath: AssetsManager.address,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const TitlesTextWidget(label: "Settings", fontSize: 20),
                    SwitchListTile(
                      secondary: Image.asset(
                        AssetsManager.theme,
                        height: 30,
                      ),
                      title: Text(themProvider.getIsDarkTheme
                          ? "Dark Mode"
                          : "Light Mode"),
                      value: themProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themProvider.setDarkTheme(themeValue: value);
                      },
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CustomListTile(
                      text: "Privacy & Policy",
                      function: () {},
                      imagePath: AssetsManager.privacy,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // adjust the value as needed
                            ),
                          ),
                          onPressed: () async {
                            if (user == null) {
                              Navigator.pushNamed(
                                context,
                                LoginScreen.id,
                              );
                            } else {
                              await MyAppMethods.showErrorOrWarningDialog(
                                subTitle: "Are You Sure?",
                                context: context,
                                isError: false,
                                fct: () async {
                                  await FirebaseAuth.instance.signOut();
                                  if (!mounted) return;
                                  Navigator.pushNamed(context, LoginScreen.id);
                                },
                              );
                            }
                          },
                          icon: Icon((user == null
                              ? IconlyLight.login
                              : IconlyLight.logout)),
                          label: Text(user == null ? "Login" : " LogOut ")),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.text,
      required this.function,
      required this.imagePath});

  final String imagePath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleTextWidget(
        label: text,
        fontSize: 10,
      ),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
