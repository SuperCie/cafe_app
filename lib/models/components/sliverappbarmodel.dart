import 'package:coffee_app/models/components/containerappbar.dart';
import 'package:coffee_app/screens/inboxscreen.dart';
import 'package:coffee_app/screens/profilescreen.dart';
import 'package:coffee_app/screens/settingscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sliverappbarmodel extends StatelessWidget {
  const Sliverappbarmodel({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate Function
    // ignore: non_constant_identifier_names
    void NavigateSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Settingscreen()),
      );
    }

    // ignore: non_constant_identifier_names
    void NavigateProfile() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profilescreen()),
      );
    }

    // ignore: non_constant_identifier_names
    void NavigateInbox() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inboxscreen()),
      );
    }

    return SliverAppBar(
      expandedHeight: 100,
      automaticallyImplyLeading: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' HI CHARLES PUTRA👋',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Containerappbar(
                          ontap: NavigateProfile,
                          widget: Row(
                            children: [
                              Image.asset(
                                'assets/icons/personicon.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'PROFILE',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Containerappbar(
                          ontap: NavigateInbox,
                          widget: Row(
                            children: [
                              Image.asset(
                                'assets/icons/mailicon.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'INBOX',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 10),
                        Containerappbar(
                          ontap: NavigateSettings,
                          widget: Row(
                            children: [
                              Image.asset(
                                'assets/icons/settingsicon.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'SETTING',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
