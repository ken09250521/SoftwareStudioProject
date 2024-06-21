import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'theme_setting_page.dart';
import 'Widgets/profile_menu_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage ({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //User Image
              Stack(
                children: [
                  SizedBox(height: 120, width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Icon(Icons.face), //temp for now, backend user image to be added
                    )
                  ),
                  
                ],
              ),
              const SizedBox(height: 10),
              Text('Temp',
                style: TextStyle(
                  color: Colors.black,
                )
              ),
              const SizedBox(height: 20),

              // Edit Button
              Container(
                width: 200,
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const EditProfile()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    side: BorderSide.none,
                    shape: const StadiumBorder()
                  ),
                  child: Text("Edit Profile",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    )
                  )
                )
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),   

              // List of Items
              ProfileMenuWidget(title: "Theme", icon: LineAwesomeIcons.palette_solid, onPress: () => Get.to(() => const ThemePage())),
              ProfileMenuWidget(title: "User Information", icon: LineAwesomeIcons.user_check_solid, onPress: () {}),
              ProfileMenuWidget(title: "Help", icon: LineAwesomeIcons.question_circle, onPress: () {}),
              const SizedBox(height: 30),
              ProfileMenuWidget(title: "Logout", icon: LineAwesomeIcons.sign_out_alt_solid, 
              textColor: Colors.red, endIcon: false, onPress: () {
                Get.defaultDialog(
                  title: "LOGOUT",
                  titleStyle: const TextStyle(fontSize: 20),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text("Confirm logging out?"),
                  ),
                  confirm: Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                      child: const Text("Yes"),
                    )
                  ),
                  cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                );
              }),
            ],
          )
        )
      )
    );
  }
}