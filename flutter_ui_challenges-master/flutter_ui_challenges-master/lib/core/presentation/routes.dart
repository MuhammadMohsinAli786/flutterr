import 'package:flutter/material.dart';
import 'package:flutter_ui_challenges/core/data/models/menu.dart' as menu;
import 'package:flutter_ui_challenges/src/furniture_app/furniture_app.dart';
import 'package:flutter_ui_challenges/src/khalti_clone/main.dart';
import 'package:flutter_ui_challenges/src/nic_asia_clone/nic_asia_app.dart';
import 'package:flutter_ui_challenges/src/pages/animations/anim4.dart';
import 'package:flutter_ui_challenges/src/pages/animations/anim5.dart';
import 'package:flutter_ui_challenges/src/pages/lists/grid_view.dart';
import 'package:flutter_ui_challenges/src/pages/bike/bike_details.dart';
import 'package:flutter_ui_challenges/src/pages/bike/bikeshop_ui.dart';
import 'package:flutter_ui_challenges/src/pages/bike/home_page.dart';
import 'package:flutter_ui_challenges/src/pages/food/food_checkout.dart';
import 'package:flutter_ui_challenges/src/pages/hotel/hotelbooking.dart';
import 'package:flutter_ui_challenges/src/pages/invitation/inauth.dart';
import 'package:flutter_ui_challenges/src/pages/invitation/inlanding.dart';
import 'package:flutter_ui_challenges/src/pages/invitation/invitation1.dart';
import 'package:flutter_ui_challenges/src/pages/login/signup3.dart';
import 'package:flutter_ui_challenges/src/pages/login/auth3.dart';
import 'package:flutter_ui_challenges/src/pages/login/login10.dart';
import 'package:flutter_ui_challenges/src/pages/login/login11.dart';
import 'package:flutter_ui_challenges/src/pages/login/login12.dart';
import 'package:flutter_ui_challenges/src/pages/login/login14.dart';
import 'package:flutter_ui_challenges/src/pages/login/login13.dart';
import 'package:flutter_ui_challenges/src/pages/login/login8.dart';
import 'package:flutter_ui_challenges/src/pages/food/cake.dart';
import 'package:flutter_ui_challenges/src/pages/navigation/menu1.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile10.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile11.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile8.dart';
import 'package:flutter_ui_challenges/src/pages/settings/profilesettings.dart';
import 'package:flutter_ui_challenges/src/pages/settings/settings1.dart';
import 'package:flutter_ui_challenges/src/pages/settings/settings2.dart';
import 'package:flutter_ui_challenges/src/pages/settings/settings3.dart';
import 'package:flutter_ui_challenges/src/pages/settings/settings4.dart';
import 'package:flutter_ui_challenges/src/pages/todo/todo_home3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ui_challenges/src/pages/todo/todo2.dart';
import 'package:flutter_ui_challenges/src/pages/login/auth1.dart';
import 'package:flutter_ui_challenges/src/pages/lists/list2.dart';
import 'package:flutter_ui_challenges/src/pages/lists/list1.dart';
import 'package:flutter_ui_challenges/src/pages/hotel/hhome.dart';
import 'package:flutter_ui_challenges/src/pages/food/fdhome.dart';
import 'package:flutter_ui_challenges/src/pages/login/auth2.dart';
import 'package:flutter_ui_challenges/src/pages/login/login5.dart';
import 'package:flutter_ui_challenges/src/pages/login/login4.dart';
import 'package:flutter_ui_challenges/src/pages/login/login3.dart';
import 'package:flutter_ui_challenges/src/pages/login/login1.dart';
import 'package:flutter_ui_challenges/src/pages/travel/thome.dart';
import 'package:flutter_ui_challenges/src/pages/food/avocado.dart';
import 'package:flutter_ui_challenges/src/pages/login/login7.dart';
import 'package:flutter_ui_challenges/src/pages/login/login6.dart';
import 'package:flutter_ui_challenges/src/pages/login/signup2.dart';
import 'package:flutter_ui_challenges/src/pages/hotel/details.dart';
import 'package:flutter_ui_challenges/src/pages/dialogs/dialogs.dart';
import 'package:flutter_ui_challenges/src/pages/todo/todo_home2.dart';
import 'package:flutter_ui_challenges/src/pages/todo/todo_home1.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile3.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile2.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile1.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile7.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile6.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile5.dart';
import 'package:flutter_ui_challenges/src/pages/profile/profile4.dart';
import 'package:flutter_ui_challenges/src/pages/food/recipe_list.dart';
import 'package:flutter_ui_challenges/src/pages/animations/anim3.dart';
import 'package:flutter_ui_challenges/src/pages/navigation/drawer2.dart';
import 'package:flutter_ui_challenges/src/pages/food/recipe_single.dart';
import 'package:flutter_ui_challenges/src/pages/travel/travel_home.dart';
import 'package:flutter_ui_challenges/src/pages/navigation/drawer1.dart';
import 'package:flutter_ui_challenges/src/pages/travel/travel_nepal.dart';
import 'package:flutter_ui_challenges/src/pages/food/recipe_details.dart';
import 'package:flutter_ui_challenges/src/pages/travel/tdestination.dart';
import 'package:flutter_ui_challenges/src/pages/animations/animation1/animation1.dart';

final List<dynamic> pages = [
  menu.MenuItem(
      title: "Animations",
      icon: FontAwesomeIcons.truckMoving,
      items: [
        menu.SubMenuItem("Fancy Appbar Animation", const FancyAppbarAnimation(),
            path: FancyAppbarAnimation.path),
        menu.SubMenuItem("Hero Animation", const AnimationOnePage(),
            path: AnimationOnePage.path),

        menu.SubMenuItem("Animated Bottom Bar", const AnimatedBottomBar(),
            path: AnimatedBottomBar.path),
        menu.SubMenuItem(
          "Animated List One",
          const AnimatedListOnePage(),
          path: AnimatedListOnePage.path,
        ),
      ]),
  menu.MenuItem(title: "Profile", icon: Icons.person, items: [
    menu.SubMenuItem("Profile 11", const ProfileElevenPage(),
        path: ProfileElevenPage.path),
    menu.SubMenuItem("Profile 10", const ProfileTenPage(),
        path: ProfileTenPage.path),

    menu.SubMenuItem("Profile One", const ProfileOnePage(),
        path: ProfileOnePage.path),
    menu.SubMenuItem("Profile Two",  ProfileTwoPage(),
        path: ProfileTwoPage.path),
    menu.SubMenuItem("Profile Three",  ProfileThreePage(),
        path: ProfileThreePage.path),
    menu.SubMenuItem("Profile Four", const ProfileFourPage(),
        path: ProfileFourPage.path),
    menu.SubMenuItem("Profile Five", const ProfileFivePage(),
        path: ProfileFivePage.path),
    menu.SubMenuItem("Profile Six", ProfileSixPage(sid),
        path: ProfileSixPage.path),
    menu.SubMenuItem("Profile Seven", const ProfileSevenPage(),
        path: ProfileSevenPage.path),
    menu.SubMenuItem("Profile Eight", const ProfileEightPage(),
        path: ProfileEightPage.path),
  ]),
  menu.MenuItem(title: "Authentication", icon: Icons.lock, items: [
    menu.SubMenuItem("Login 14", const LoginPageFourteen(),
        path: LoginPageFourteen.path),
    menu.SubMenuItem("Login 13", const LoginPageThirdteen(),
        path: LoginPageThirdteen.path),
    menu.SubMenuItem("Login 12", const LoginTwelvePage(),
        path: LoginTwelvePage.path),
    menu.SubMenuItem("Login 11", const LoginElevenPage(),
        path: LoginElevenPage.path),
    menu.SubMenuItem("Login 10", const LoginTenPage(), path: LoginTenPage.path),
    menu.SubMenuItem("Auth Three", const AuthThreePage(),
        path: AuthThreePage.path),
    menu.SubMenuItem("Auth One", const AuthOnePage(), path: AuthOnePage.path),
    menu.SubMenuItem("Auth Two", const AuthTwoPage(), path: AuthTwoPage.path),
    menu.SubMenuItem("Login One", const LoginOnePage(),
        path: LoginOnePage.path),

    menu.SubMenuItem("Login Three", const LoginThreePage(),
        path: LoginThreePage.path),
    menu.SubMenuItem("Login Four", const LoginFourPage(),
        path: LoginFourPage.path),
    menu.SubMenuItem("Login Five", const LoginFivePage(),
        path: LoginFivePage.path),
    menu.SubMenuItem("Login Six", const LoginSixPage(),
        path: LoginSixPage.path),
    menu.SubMenuItem("Login Seven", const LoginSevenPage(),
        path: LoginSevenPage.path),
    menu.SubMenuItem("Login Eight", const LoginEightPage(),
        path: LoginEightPage.path),

    menu.SubMenuItem("Signup Two", const SignupTwoPage(),
        path: SignupTwoPage.path),
    menu.SubMenuItem("Signup Three", const SignupThreePage(),
        path: SignupThreePage.path),
  ]),
  menu.MenuItem(title: "Settings", icon: Icons.dashboard, items: [
    menu.SubMenuItem("Settings One", const SettingsOnePage(),
        path: SettingsOnePage.path),
    menu.SubMenuItem("Settings Two", SettingsTwoPage(),
        path: SettingsTwoPage.path),
    menu.SubMenuItem("Settings Three", SettingsThreePage(),
        path: SettingsThreePage.path),
    menu.SubMenuItem("Profile Setting", const ProfileSettingsPage(),
        path: ProfileSettingsPage.path),
    menu.SubMenuItem("Settings Four", const SettingsFourPage(),
        path: SettingsFourPage.path),
  ]),
  menu.MenuItem(
    title: "Quotes App",
    icon: FontAwesomeIcons.quoteLeft,
    items: [

    ],
  ),
  menu.MenuItem(title: "Motorbike App", icon: Icons.list, items: [
    menu.SubMenuItem("MoterBike Shop Page", const MoterBikeShopPage(),
        path: MoterBikeShopPage.path),
    menu.SubMenuItem("Home Page", const BikeHomePage(),
        path: BikeHomePage.path),
    menu.SubMenuItem("Bike Details Page", const BikeDetailsPage(),
        path: BikeDetailsPage.path),
  ]),
  menu.MenuItem(title: "Lists", icon: Icons.list, items: [
    menu.SubMenuItem("Grid View", const GridViewAnimationPage(),
        path: GridViewAnimationPage.path),
    menu.SubMenuItem("Places List One", const PlaceList1(),
        path: PlaceList1.path),
    menu.SubMenuItem("List Two", const SchoolList(), path: SchoolList.path),
  ]),
  menu.MenuItem(title: "Invitation", icon: Icons.list, items: [
    menu.SubMenuItem("Auth Page", const InvitationAuthPage(),
        path: InvitationAuthPage.path),
    menu.SubMenuItem("Landing Page", const InvitationLandingPage(),
        path: InvitationLandingPage.path),
    menu.SubMenuItem("Details Page", InvitationPageOne(),
        path: InvitationPageOne.path),
  ]),
  menu.MenuItem(title: "Ecommerce", icon: Icons.shopping_basket, items: [
    ]),
  menu.MenuItem(title: "Blog", icon: Icons.pages, items: [
   ]),
  menu.MenuItem(title: "Dashboard", icon: Icons.dashboard, items: [

  ]),
  menu.MenuItem(title: "Food", icon: Icons.fastfood, items: [
    menu.SubMenuItem("Food Order Checkout", const FoodCheckoutOnePage(),
        path: FoodCheckoutOnePage.path),
    menu.SubMenuItem("Fruits Add to Cart", const AvocadoPage(),
        path: AvocadoPage.path),
    menu.SubMenuItem("Cake Details", const CakePage(), path: CakePage.path),
    menu.SubMenuItem("Recipe List", RecipeListPage(),
        path: RecipeListPage.path),
    menu.SubMenuItem("Recipe Single", const RecipeSinglePage(),
        path: RecipeSinglePage.path),
    menu.SubMenuItem("Recipe Details", const RecipeDetailsPage(),
        path: RecipeDetailsPage.path),
    menu.SubMenuItem("Food Delivery",  FoodDeliveryHomePage(),
        path: FoodDeliveryHomePage.path),
  ]),
  menu.MenuItem(title: "Quiz app", icon: FontAwesomeIcons.question, items: [
    ]),
  menu.MenuItem(title: "Todo", icon: FontAwesomeIcons.listCheck, items: [
    menu.SubMenuItem("Todo Home Three", const TodoHomeThreePage(),
        path: TodoHomeThreePage.path),
    menu.SubMenuItem("Todo Week View", TodoTwoPage(), path: TodoTwoPage.path),
    menu.SubMenuItem("Todo Home One", TodoHomeOnePage(),
        path: TodoHomeOnePage.path),
    menu.SubMenuItem("Todo Home Two", const TodoHomeTwoPage(),
        path: TodoHomeTwoPage.path),
  ]),
  menu.MenuItem(title: "Travel", icon: Icons.airplanemode_active, items: [
    menu.SubMenuItem("Travel Home", const TravelHomePage(),
        path: TravelHomePage.path),
    menu.SubMenuItem("Travel Nepal", const TravelNepalPage(),
        path: TravelNepalPage.path),
    menu.SubMenuItem("Travel Destination Detail", const DestinationPage(),
        path: DestinationPage.path),
    menu.SubMenuItem("Travel Home2", const TravelHome(), path: TravelHome.path),
  ]),
  menu.MenuItem(title: "Hotel", icon: Icons.hotel, items: [
    menu.SubMenuItem("Hotel Booking Homepage", const HotelBookingPage(),
        path: HotelBookingPage.path),
    menu.SubMenuItem("Hotel Home", const HotelHomePage(),
        path: HotelHomePage.path),
    menu.SubMenuItem("Room Details", const HotelDetailsPage(),
        path: HotelDetailsPage.path),
  ]),
  menu.MenuItem(title: "Navigation", icon: Icons.menu, items: [
    menu.SubMenuItem("Menu One", const MenuOnePage(), path: MenuOnePage.path),

    menu.SubMenuItem("Dark Drawer Menu", DarkDrawerPage(),
        path: DarkDrawerPage.path),
    menu.SubMenuItem("Light Drawer Menu", LightDrawerPage(),
        path: LightDrawerPage.path),

  ]),
  menu.MenuItem(title: "Onboarding", icon: Icons.info, items: []),
  menu.MenuItem(
      title: "UI Kits (Clones)",
      items: [
        menu.SubMenuItem('Khalti App', const KhaltiApp(), path: KhaltiApp.path),

        menu.SubMenuItem("Bank App Clone", const NicAsiaApp(),
            path: NicAsiaApp.path),
        menu.SubMenuItem("Furniture App", const FurnitureApp(),
            path: FurnitureApp.path),
      ],
      icon: Icons.account_balance_wallet),
  menu.MenuItem(title: "Miscellaneous", items: [
  ]),
];

menu.SubMenuItem? getItemForKey(String key) {
  menu.SubMenuItem? item;
  List<dynamic> pag = List<dynamic>.from(pages);
  for (var page in pag) {
    if (page is menu.SubMenuItem && page.title == key) {
      item = page;
    } else if (page is menu.MenuItem) {
      for (var sub in page.items!) {
        if (sub.title == key) item = sub;
      }
    }
  }
  return item;
}
