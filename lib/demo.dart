import 'package:flutter/material.dart';
import 'sharedPref.dart';
import 'user.dart';

class Demo extends StatefulWidget {
  @override
  DemoView createState() {
    return DemoView();
  }
}

class DemoView extends State<Demo> {
  SharedPref sp = SharedPref();
  User us = User();
  User ul = User();

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sp.read("user"));
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Loaded!"),
          duration: const Duration(milliseconds: 500)));
      setState(() {
        ul = user;
      });
    } catch (Excepetion) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Nothing found!"),
          duration: const Duration(milliseconds: 500)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  height: 50.0,
                  width: 300.0,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Name"),
                    onChanged: (value) {
                      setState(() {
                        us.name = value;
                      });
                    },
                  )),
              Container(
                  height: 50.0,
                  width: 300.0,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Age"),
                    onChanged: (value) {
                      setState(() {
                        us.age = value;
                      });
                    },
                  )),
              Container(
                  height: 50.0,
                  width: 300.0,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Location"),
                    onChanged: (value) {
                      setState(() {
                        us.location = value;
                      });
                    },
                  )),
            ],
          ),
        ),
        Container(
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  sp.save("user", us);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: new Text("Saved!"),
                      duration: const Duration(milliseconds: 500)));
                },
                child: Text('Save', style: TextStyle(fontSize: 20)),
              ),
              RaisedButton(
                onPressed: () {
                  loadSharedPrefs();
                },
                child: Text('Load', style: TextStyle(fontSize: 20)),
              ),
              RaisedButton(
                onPressed: () {
                  sp.remove("user");
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: new Text("Cleared!"),
                      duration: const Duration(milliseconds: 500)));
                  setState(() {
                    ul = User();
                  });
                },
                child: Text('Clear', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Name: " + (ul.name ?? ""),
                  style: TextStyle(fontSize: 16)),
              Text("Age: " + (ul.age ?? ""),
                  style: TextStyle(fontSize: 16)),
              Text("Location: " + (ul.location ?? ""),
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
