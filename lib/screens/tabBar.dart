import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachersapp/Models/Auth.dart';
import 'package:teachersapp/screens/DataOutput.dart';
import 'package:teachersapp/screens/Forms.dart';

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _pageindex = 0;

  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'screen': AddNewData(),
      },
      {
        'screen': DataOutput(),
      }
    ];
    super.initState();
  }

  void _selectPages(index) {
    setState(() {
      _pageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: _pages[_pageindex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPages,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _pageindex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('Form'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              title: Text('Student Data'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ]),
    );
  }
}
