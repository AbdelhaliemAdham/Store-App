import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../consts/global_colors.dart';
import '../services/user_model.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final usersModelProvider = Provider.of<UsersModel>(context);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          height: size.width * 0.15,
          width: size.width * 0.15,
          errorBuilder: ((context, error, stackTrace) => const Icon(
                IconlyBold.danger,
                color: Colors.red,
                size: 28,
              )),
          usersModelProvider.avatar.toString(),
          fit: BoxFit.fill,
        ),
      ),
      title: Text(
        usersModelProvider.name.toString(),
        textScaleFactor: 1.2,
      ),
      subtitle: Text(usersModelProvider.email.toString()),
      trailing: Text(
        usersModelProvider.role.toString(),
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
