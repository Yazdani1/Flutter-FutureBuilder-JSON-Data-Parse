import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {


  Future<List<User>> _getUser() async{

   var data = await http.get("https://jsonplaceholder.typicode.com/photos");

   var jsondata=json.decode(data.body);

   final List<User>users=[];

   for(var u in jsondata){

     User user= User(u["index"], u["title"], u["thumbnailUrl"]);
     users.add(user);

   }

   print(users.length);
    return users;


  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent.shade400,
        title: new Text(
          "Jason Parsing",
          style: new TextStyle(color: Colors.white)
        ),

      ),//Apbar

      body: new Container(

        child: FutureBuilder(
            future: _getUser(),
            builder: (BuildContext context,AsyncSnapshot snapshot){

              if(snapshot.data==null){
                return new Container(
                  child: new Center(
                    child: new Text(
                      "Loading Data.."
                    ),
                  ),
                );
              }else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(

                        leading: CircleAvatar(

                          backgroundImage: NetworkImage(
                            snapshot.data[index].url
                          ),


                        ),//circle avatar for image..
                        title: Text(snapshot.data[index].title),
                       subtitle: Text(snapshot.data[index].title),

                        //For details page..
                        onTap: (){

                          Navigator.push(context, 
                              new MaterialPageRoute(
                                  builder: (context)=>DetailPage(snapshot.data[index])));

                        },
                      );
                    }
                ); //list builder..
              }

          }
        ),

      ),



    );//Scafold
  }
}


//Detail page

class DetailPage extends StatelessWidget{

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      
      appBar: AppBar(
        title: new Text("Detail Page"),
        backgroundColor: Colors.lightBlue,

      ),

      backgroundColor: Colors.deepOrangeAccent,

      body: new Container(

        padding: EdgeInsets.all(35.0),
        margin: EdgeInsets.all(15.0),
        color: Colors.amber,

        child: new Column(

          children: <Widget>[

            new Image.network(user.url),

          new Text(
              "Title is:${user.title}"
          )


          ],

        ),


      ),
      
    );
    
  }
  
}



class User{

  final int index;
  final String title;
  final String url;


  User(this.index,this.title,this.url);


}
