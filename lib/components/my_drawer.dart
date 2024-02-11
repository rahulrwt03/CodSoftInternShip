import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          DrawerHeader(
              child: Icon(Icons.note_alt_sharp,color: Colors.grey.shade300,size: 35,)),

          ListTile(
            leading: Icon(Icons.home,color: Colors.grey.shade300,),
            title: const Text("H O M E"),
            titleTextStyle: TextStyle(
              color: Colors.grey.shade300
            ),
          ),

          ListTile(
            leading: Icon(Icons.settings,color: Colors.grey.shade300,),
            title: const Text("S E T T I N G"),
            titleTextStyle: TextStyle(
                color: Colors.grey.shade300
            ),
          )
        ],
      ),
    );
  }
}
