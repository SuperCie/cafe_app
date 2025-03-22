import 'package:coffee_app/models/components/tilemodel.dart';
import 'package:coffee_app/models/theme/themerepo.dart';
import 'package:coffee_app/screens/deletescreen.dart';
import 'package:coffee_app/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Settingscreen extends StatefulWidget {
  Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  final Authserviceclass _auth = Authserviceclass();

  @override
  Widget build(BuildContext context) {
    void deleteAcc(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Deletescreen()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Switch to Dark Mode',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  CupertinoSwitch(
                    value: Provider.of<Themerepo>(context).darkThemeMode,
                    onChanged: (value) {
                      Provider.of<Themerepo>(
                        context,
                        listen: false,
                      ).switchToggle();
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0),
            Tilemodel(
              ontap: () {
                _auth.userLogOut(context);
              },
              text: 'Sign Out',
              imagePath: 'assets/icons/signoutacc.png',
            ),
            Divider(thickness: 1.0),
            Tilemodel(
              ontap: () => deleteAcc(context),
              text: 'Delete Account',
              imagePath: 'assets/icons/deleteacc.png',
            ),
          ],
        ),
      ),
    );
  }
}
