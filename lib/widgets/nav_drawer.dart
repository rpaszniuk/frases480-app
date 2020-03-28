import 'package:flutter/material.dart';
import 'package:frases480/routes/routes.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Frases 480',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Inicio'),
            onTap: () => {Navigator.pushReplacementNamed(context, Routes.home)},
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categorías'),
            onTap: () => {Navigator.pushReplacementNamed(context, Routes.categories)},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Acerca de'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Contacto'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}