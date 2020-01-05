import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class ItemTwo extends StatefulWidget {
  @override
  _ItemTwoState createState() => _ItemTwoState();
}


class _ItemTwoState extends State<ItemTwo> {

  Future getHomePost()async{

    var firestore = Firestore.instance;

    QuerySnapshot snap = await firestore.collection("HomeData").getDocuments();

    return snap.documents;

  }


  Future<Null>getRegresh()async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getHomePost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      backgroundColor: Colors.white12,

      body: FutureBuilder(
        future: getHomePost(),
        builder: (context,snapshot){

          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return RefreshIndicator(
                onRefresh: getRegresh,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {

                    var ourData = snapshot.data[index];


                    return Container(
                      height: 550.0,
                      margin: EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                          ),
                        child: Column(
                          children: <Widget>[
                            
                            Container(
                              child: Row( 
                                children: <Widget>[

                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                           Container(
                                            margin: EdgeInsets.all(10.0),
                                            child: CircleAvatar(
                                            child: Text(ourData.data["title"][0],style: TextStyle(fontSize: 20.0),),
                                            backgroundColor: Colors.black26,
                                            ),),
                                            SizedBox(width: 5.0,),
                                            Container(
                                              child: Text(ourData.data['title'],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black26,
                                                fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                
                                          ],
                                      ),
                                    ),


                               
                                Container(
                                  margin: EdgeInsets.only(right: 20.0),
                                  child: InkWell(
                                    onTap: (){
                                      customDialog(context,
                                      ourData.data['image'],
                                      ourData.data['title'],
                                      ourData.data['des']
                                      );
                                    },
                                  child: Icon(Icons.more_horiz,size: 30.0,)),
                                  
                                  
                                  ),

                                ],
                                ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(ourData.data['image'],
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              ),
                              ),
                          ),

                          SizedBox(height: 10.0,),

                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(ourData.data['des'],
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black
                              ),
                            ),
                          )


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


  customDialog(BuildContext context,String img,String title, String des){

    return showDialog(
      context: context,
      builder: (BuildContext context){

        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)
            ),
        child: Container(
          height: MediaQuery.of(context).size.height/1.20,
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