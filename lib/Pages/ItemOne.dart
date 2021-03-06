import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemOne extends StatefulWidget {
  @override
  _ItemOneState createState() => _ItemOneState();
}

class _ItemOneState extends State<ItemOne> {
 
 
 Future getPost()async{

   var firestore = Firestore.instance;

   QuerySnapshot snap = await firestore.collection("itemone").getDocuments();

   return snap.documents;

 }

 Future<Null>getRefres()async{
   await Future.delayed(Duration(seconds: 3));
   setState(() {
     getPost();

   });
 }

List<MaterialColor>colorItems=[
  Colors.deepOrange,
  Colors.purple,
  Colors.green,
  Colors.pink,
  Colors.yellow,
  Colors.red,
  Colors.deepOrange
];
  MaterialColor color;

 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
        body: FutureBuilder(
          future: getPost(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),
              );
            }else{
              return RefreshIndicator(
                onRefresh: getRefres,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){

                      var ourData = snapshot.data[index];

                      color=colorItems[index % colorItems.length];

                    return Container(
                      height: 200.0,
                      margin: EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Row(
                          children: <Widget>[

                                Expanded(flex: 1,
                                child: ClipRRect(borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(ourData.data['img'],
                                height: 200.0,    
                                    fit: BoxFit.cover,

                                ),
                                ),
                                ),
                              SizedBox(width: 10.0,),

                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Container(child: Text(ourData.data['title'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    ),
                                  SizedBox(height: 5.0,),

                                  Container(
                                    child: Text(ourData.data['des'],
                                    maxLines: 5,
                                    style: TextStyle(
                                      fontSize: 17.0
                                      ,color: Colors.black26
                                    ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: (){
                                        customDialog(context,ourData.data['img'],ourData.data['title'],ourData.data['des']
                                        );
                                      },


                                      child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.all(5.0),
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(20.0)
                                      ),
                                      child: Text("view Details",
                                      style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white
                                      ),
                                    ),
                                  ),
                                    ),
                                  )

                                  ],
                                ),
                                
                                ),

                          ],
                        ),
                      ),
                      );

                  }
                ),
              );
              
            }
            
 

          }
          ),

    );


  }
      customDialog(BuildContext context, String img, String title, String des){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          
          ),
          child: Container(
            height: MediaQuery.of(context).size.height/1.2,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                    Colors.blueGrey,
                    Colors.blueAccent,
                    Colors.blue
                ]
              )
            ),
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  Container(
                    height: 150.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                    
                    child: Image.network(img,
                    height: 150.0,
                    width: MediaQuery.of(context).size.width,
                    fit:  BoxFit.cover,
                    ),
                  ), 
                  ),
                  SizedBox(height: 6.0,),

                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    ),
                    ),
                  ),
                  
                  SizedBox(height: 6.0,),

                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(des,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                    ),
                  ),

                ],
              ),
            ),
            
          ),
        );
      }
    );
  }
}