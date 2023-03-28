import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:web_panel_amigo/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String timeText = "";
  String dateText = "";


  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime()
  {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if(this.mounted)
    {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState()
  {
    super.initState();

    //time
    timeText = formatCurrentLiveTime(DateTime.now());

    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorGreen,
        title: Text('Admin Web Portal',style: GoogleFonts.ibmPlexSans(fontWeight: FontWeight.w400,fontSize: 24),),
        centerTitle: true,
      ),
body: Center(
  child: Padding(
    padding: const EdgeInsets.only(left: 75,right: 75),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            timeText + "\n" + dateText,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        //users activate and block accounts button ui
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //active
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person_add, color: Colors.white,),
                label: Text(
                  "Activate Users".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(40), backgroundColor: Colors.black,
                ),
                onPressed: ()
                {

                },
              ),
            ),

            const SizedBox(width: 20,),

            //block
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.block_flipped, color: Colors.white,),
                label: Text(
                  "Block Users".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(40), backgroundColor: kColorGreen,
                ),
                onPressed: ()
                {

                },
              ),
            ),
          ],
        ),

        //sellers activate and block accounts button ui
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //active
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person_add, color: Colors.white,),
                label: Text(
                  "Activate Sellers".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(40), backgroundColor: kColorGreen,
                ),
                onPressed: ()
                {

                },
              ),
            ),

            const SizedBox(width: 20,),

            //block
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.block_flipped, color: Colors.white,),
                label: Text(
                  "Block Sellers".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(40), backgroundColor: Colors.black,
                ),
                onPressed: ()
                {

                },
              ),
            ),
          ],
        ),

        //riders activate and block accounts button ui

        //logout button
        ElevatedButton.icon(
          icon: const Icon(Icons.logout, color: Colors.white,),
          label: Text(
            "Logout".toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              letterSpacing: 3,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(40), backgroundColor: Colors.black,
          ),
          onPressed: ()
          {

          },
        ),
      ],
    ),
  ),
),
    );
  }
}
