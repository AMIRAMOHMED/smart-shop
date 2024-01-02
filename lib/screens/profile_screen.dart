import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/screens/inner_screens/order_screen/order_screen.dart';
import 'package:shop_smart/screens/inner_screens/wishlist_screen.dart';
import 'package:shop_smart/services/assest_manger.dart';
import 'package:shop_smart/services/my_app_methods.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../provider/them_provider.dart';
import '../widgets/app_name_text.dart';
import 'auth/login_screen.dart';
import 'inner_screens/viewd_recently.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const AppNameTextWidget(),
          leading: Image.asset(AssetsManager.shoppingCart),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Visibility(
                visible: false,
                child: TitlesTextWidget(
                  label: "Please Login to Have Unltimate acces",
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            width: 3,
                            color: Theme.of(context).colorScheme.background),
                        image: const DecorationImage(
                            image: NetworkImage(
                              "https://t4.ftcdn.net/jpg/03/32/59/65/240_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitlesTextWidget(label: "AmiraMohamed", fontSize: 20),
                      SubtitleTextWidget(
                          label: "mero72124@gmail.com", fontSize: 18)
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
                      await Navigator.pushNamed(context, ViewedRecentlyPage.id);
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
                          Navigator.pushNamed(
                            context,
                            LoginScreen.id,
                          );

                          // await MyAppMethods.showErrorOrWarningDialog(
                          //     subTitle: "Are You Sure?",
                          //     fct: () {},
                          //     context: context,
                          //     isError: false);
                        },
                        icon: const Icon(
                          IconlyLight.login,
                        ),
                        label: const Text("Login")),
                  )
                ],
              )
            ],
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

  final imagePath, text;
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
