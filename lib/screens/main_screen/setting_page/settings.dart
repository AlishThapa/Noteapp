import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/screens/main_screen/setting_page/models/style.dart';

import 'models/cloud_services.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: GoogleFonts.openSans(
                fontSize: 35,
                fontWeight: FontWeight.w100,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'CLOUD SERVICES',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(height: 10),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: cloudServices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cloudServices[index].headname,
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          cloudServices[index].tailname,
                          style: GoogleFonts.ubuntu(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.orange,
                          ),
                        ),
                        cloudServices[index].icon,
                      ],
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade400,
              ),
            ),
            const Text(
              'STYLE',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: styleModel.length,
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    styleModel[index].headname,
                    style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        styleModel[index].tailname,
                        style: GoogleFonts.ubuntu(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      styleModel[index].icon,
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade400,
              ),
            ),
            const Text(
              'QUICK FEATURES',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quick notes',
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade400,
              ),
            ),
            const Text(
              'QUICK FEATURES',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'High-priority reminders',
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Play sound even when Silent or DND mode is on',
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                const Icon(
                  Icons.radio_button_checked,
                  size: 40,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade400,
              ),
            ),
            const Text(
              'OTHER',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Privacy Policy',
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            )
          ],
        ),
      ),
    );
  }
}
