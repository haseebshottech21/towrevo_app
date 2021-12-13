import 'package:flutter/material.dart';
class DrawerListItem extends StatelessWidget {

  IconData iconsData;
  String title;
  VoidCallback onPressed;

  DrawerListItem({Key? key, required this.iconsData, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(contentPadding: EdgeInsets.zero,leading: Icon(iconsData,color: Theme.of(context).primaryColor,),title: Text(title,style: const TextStyle(color: Colors.white,fontSize: 20),),onTap: onPressed,);
  }
}
