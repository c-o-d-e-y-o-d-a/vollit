import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vollit_wallet/pages/create_or_import_screen.dart';
import 'package:vollit_wallet/pages/generate_mnenomic_page.dart';
import 'package:vollit_wallet/pages/onboarding/onboarding_screens.dart';
import 'package:vollit_wallet/providers/wallet_provider.dart';
import 'package:vollit_wallet/utils/constants.dart';

void main() {
  runApp(ChangeNotifierProvider<WalletProvider>(
    create: (context) => WalletProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: AnimatedSplashScreen(
        splash: 'assets/images/logo.png',
        splashIconSize: 2000.0,
        centered: true,
        nextScreen: OnboardingScreen(),
        
        backgroundColor: darkBackgroundColor,
        duration: 4000,

      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBackgroundColor,
        title: Text('Vollit', style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            darkBackgroundColor,Color.fromARGB(255, 58, 59, 124), buttonColor
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
          )
        ),
        
        child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBackgroundColor, // Set the button color
                  padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.black.withOpacity(0.4),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateOrImportPage()),
                  );
                },
                child: Text(
                  'Generate Wallet',
                  style: TextStyle(
                    color: borderColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'RetroFont', // Replace with your desired retro font
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
