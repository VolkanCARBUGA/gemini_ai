import 'package:flutter/material.dart';
import 'package:gemini_ai/my_home_page.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'You AI Assistant',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  'Using this software, you can ask you questions and receive articles using artificial intelligence assistant',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium
                )
              ],
            ),
            SizedBox(height: 32,),
            Image.asset('assets/onboarding.png'),
            SizedBox(height: 32,),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                          (route) => false
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  shadowColor: Colors.black87,
                  backgroundColor: Colors.lightBlue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32)
                ),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Continue',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox.square(dimension: 16,),
                    Icon(Icons.arrow_forward,color: Colors.white,)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}