import 'package:flutter/material.dart';
import 'package:medium_app/screens/HomeScreen.dart';
import 'package:medium_app/screens/ProfileScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [
    HomeScreen(),
    ProfileScreen(),
  ];
  List<String> titleString = ['Home Page','Profile Page'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [DrawerHeader(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      width: 60,

                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text('@Username'),
                  ListTile(
                    title: Text('All Post'),
                    leading: Icon(Icons.book),
                  ),
                ],
              )
          )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF55006c),
        title: Text(titleString[currentState]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,color: Colors.white,),
            onPressed: null,

          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF55006c),
        onPressed: null,
        child: Text(
          '+',
          style: TextStyle(fontSize: 40.0),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF55006c),
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.white : Colors.white54,
                  onPressed: (){
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 35.0,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: currentState == 1 ? Colors.white : Colors.white54,
                  onPressed:  (){
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 35.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }
}
