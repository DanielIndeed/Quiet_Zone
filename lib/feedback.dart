import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Navig_bar/navig_bar.dart';
import 'package:flutter_application_1/utils/style/text.dart';

void main() => runApp(const MaterialApp(home: Feedback()));

class Feedback extends StatefulWidget {
  const Feedback({Key? key}) : super(key: key);

  @override
  State<Feedback> createState() => _FeedbackState();
}
Widget someFunction({String? textArgument}) {
  if (textArgument == 'DA') {
    return Text(
      'Name',
     style: appText_smaller2(),
       textAlign: TextAlign.start,
       
    );
  } else {
    return Text(
      'Contact',
      style: appText_smaller2(),
       textAlign: TextAlign.start,
    );
  }
}

double inaltime1=0.05;
class _FeedbackState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        home: Scaffold(
            appBar: AppBar(
        title: Text(
          'Feedback',
        style:appText_smaller2(),
        ),
        backgroundColor: Colors.black,
        toolbarHeight:MediaQuery.of(context).size.width*inaltime1, 
        shape: Border(
    bottom: BorderSide(
      color: Color.fromARGB(255, 192, 174, 174),
      width: 0.3,
    ),
  ),
   
      ),
       body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 80),
           Row(
    children: [
      Expanded(
  child: Container(
    margin: EdgeInsets.all(8.0),
    child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        someFunction(textArgument: 'DA'),
         SizedBox(height: 10),
        TextField(
          maxLines: 1,
          style: TextStyle(color: const Color.fromARGB(255, 192, 174, 174)),
          decoration: InputDecoration(
            hintText: 'Your name',
            hintStyle: TextStyle(color: Color.fromARGB(255, 192, 174, 174)),
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color.fromARGB(32, 48, 48, 47),
          ),
        ),
      ],
    ),
  ),
),
     Expanded(
  child: Container(
    margin: EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        someFunction(textArgument: 'NU'),
         SizedBox(height: 10),
        TextField(
          maxLines: 1,
          style: TextStyle(color: const Color.fromARGB(255, 192, 174, 174)),
          decoration: InputDecoration(
            hintText: 'Your email',
            hintStyle: TextStyle(color: Color.fromARGB(255, 192, 174, 174)),
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color.fromARGB(32, 48, 48, 47),
          ),
        ),
      ],
    ),
  ),
),
    ],
  ),
             SizedBox(height: 30),
            Text(
              'message',
              style: appText_smaller2(),
            ),
            SizedBox(height: 10),
           TextField(
             maxLines: 10,
           style: TextStyle(color: const Color.fromARGB(255, 192, 174, 174)),  
           decoration: InputDecoration(
          hintText: 'Leave your message',
          hintStyle: TextStyle(color: Color.fromARGB(255, 192, 174, 174)),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Color.fromARGB(31, 1, 1, 1),
  ),
),
            SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: () {
               
              
              },
              
                style: ButtonStyle(
                     
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
     minimumSize: MaterialStateProperty.all(Size(200, 50)),
     backgroundColor:MaterialStateProperty.all(
Color.fromRGBO(244, 165, 74, 0.776)
          ),
                ),
              child:Text('Send'),
            )
            
          ]
        ), 
  
      ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: BottomNav(),
            )));
  }
}
