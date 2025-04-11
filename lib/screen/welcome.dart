import 'package:flutter/material.dart';
import 'package:project/screen/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(
                'assets/images/login.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Lorem id sit',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Image.asset('assets/images/continue.png'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
