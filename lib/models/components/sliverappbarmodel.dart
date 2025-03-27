import 'package:coffee_app/data/database/userprovider.dart';
import 'package:coffee_app/models/components/containerappbar.dart';
import 'package:coffee_app/screens/historytrans.dart';
import 'package:coffee_app/screens/profilescreen.dart';
import 'package:coffee_app/screens/settingscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Sliverappbarmodel extends StatefulWidget {
  const Sliverappbarmodel({super.key});

  @override
  State<Sliverappbarmodel> createState() => _SliverappbarmodelState();
}

class _SliverappbarmodelState extends State<Sliverappbarmodel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<Userprovider>(context, listen: false).fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Userprovider>(context, listen: false).userData;

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
    void Navigatehistory() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Historytrans()),
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
                      "HI, ${userData?['name']}👋".toUpperCase(),
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
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 5),
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
                          ontap: Navigatehistory,
                          widget: Row(
                            children: [
                              Image.asset(
                                'assets/icons/transactionicon.png',
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'HISTORY',
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
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 5),
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
