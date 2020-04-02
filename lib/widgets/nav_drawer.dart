import 'package:flutter/material.dart';
import 'package:frases480/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

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
            leading: Icon(Icons.home),
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
            onTap: () async {
              const url = 'https://frases480.com/acerca';

              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: false);
              } else {
                throw 'No se puede abrir navegador, por favor visitar: $url';
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Contacto'),
            onTap: () async {
              const url = 'mailto:info@frases480.com?subject=Soporte';

              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'No se puede abrir cliente de email, por favor contactar a: $url';
              }
            },
          ),
        ],
      ),
    );
  }
}