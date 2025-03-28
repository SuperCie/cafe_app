import 'package:coffee_app/data/database/userprovider.dart';
import 'package:coffee_app/models/components/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Personalscreen extends StatefulWidget {
  const Personalscreen({super.key});

  @override
  State<Personalscreen> createState() => _PersonalscreenState();
}

class _PersonalscreenState extends State<Personalscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Userprovider>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Userprovider>(context, listen: false).userData;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Personal Detail',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      "${userData?['name']}".toUpperCase() ??
                          userData?['displayName'],
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(thickness: 1.0),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text(
                      userData?['email'],
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(thickness: 1.0),

                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.calendar_month_outlined),
                    title: Text(
                      userData?['datebirth'],
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(thickness: 1.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
