import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/Pages/ItemOne.dart';
import 'package:news/Pages/ItemTwo.dart';
import 'package:news/Pages/ItemThree.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _indexpage = 0;

  final pageOptions = [
      ItemOne(),
      ItemTwo(),
      ItemThree()
  ];

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      appBar: AppBar(
        title: Text("Kabar Kabar Bekasi"),
        backgroundColor: Colors.lightBlueAccent,
      ),          

    drawer: Drawer(
      child: ListView(
        children: <Widget>[

          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text("Berita Seputar Bekasi",
            style: TextStyle(
              fontSize: 20.0
            ),
          ),
            decoration: BoxDecoration(
              color: Colors.blueAccent
            ),
          ),

          ListTile(
            onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemOne()));
            },
            title: Text("Bekasi Update",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black
            ),
            ),
            leading: Icon(Icons.more,color: Colors.blueAccent,),
          ),
          ListTile(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemTwo()));
            },
            title: Text("Lowongan Kerja Bekasi",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black
            ),),
            leading: Icon(Icons.work,color: Colors.blueAccent,), 
          ),
          ListTile(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemThree()));
            },
            title: Text("Wisata/Kuliner",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black
            ),
            ),
            leading: Icon(Icons.card_travel,color: Colors.blueAccent,),
          )


        ],
      ),
    ),


    body: pageOptions[_indexpage],

    bottomNavigationBar: CurvedNavigationBar(

      color: Colors.lightBlueAccent,
      buttonBackgroundColor: Colors.blueGrey,
      backgroundColor: Colors.blue,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      index: 1,
      items: <Widget>[
        Icon(Icons.poll, size: 30.0,color: Colors.white,),
        Icon(Icons.home, size: 30.0,color: Colors.white,),
        Icon(Icons.library_books, size: 30.0,color: Colors.white,)
      ],

      onTap: (int index) {
        setState(() {
          _indexpage=index;
        });
      },
    ),


    );
  }
}