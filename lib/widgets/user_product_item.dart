import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imgUrl;

  UserProductItem({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(5),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {},
          ),
        ]),
      ),
    );
  }
}
