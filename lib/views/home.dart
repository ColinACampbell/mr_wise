import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_wise/models/advice_model.dart';

class Home extends StatefulWidget {
  createState() => _HomeState();
}

class _HomeState extends State<Home> {

  FutureBuilder adviceRefreshed;
  Future<Advice> _advice = Advice.getAdvice("");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mr Wise",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: homeBody(context),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        onPressed: searchDialogue,
        child: Icon(Icons.search),
      ),
    );
  }

  Widget homeBody(BuildContext context)
  {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 50,),
            width: double.infinity,
            child: Center(
              child: Text("Advice", style: TextStyle(fontSize: 50)),
            )),
        Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 350,
            child: Center(
              child: FutureBuilder(
                future: _advice,
                builder: (context,snapshot){

                  Advice advice = snapshot.data;
                  if (snapshot.hasData)
                    return Text(  advice.advice , style: TextStyle(fontSize: 30),softWrap: true,overflow: TextOverflow.clip,);
                  else
                    return CircularProgressIndicator();

                },
              ),
            )),
        Container(
            margin: EdgeInsets.only(
                top: 10
            ),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: RaisedButton(
              color: Colors.lightBlue,
              child: Text("Generate Random Advice", style: TextStyle(color: Colors.white),),
              onPressed: updateAdvice,
            )
        )
      ],
    );
  }

  updateAdvice()
  {
    setState(() {
      // update the future of Advice on press
      _advice = Advice.getAdvice(""); // load in a future to update the widget that used the future builder
    });
  }

  searchDialogue()
  {
    TextEditingController searchController = new TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Search"),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "A word for a priceful advice"
            ),
          ),
          actions: <Widget>[
            FlatButton(onPressed: (){
              setState(() {
                String query = searchController.text;
                _advice = Advice.getAdvice(query);
                Navigator.pop(context); // close the dialog
              });
            }, child: Text("Search")),
            FlatButton(onPressed: ()=> Navigator.pop(context), child: Text("Cancel")),

          ],
        );
      }
    );
  }
  
}
