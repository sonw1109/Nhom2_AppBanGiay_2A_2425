import 'package:flutter/material.dart';
import 'package:project/screen/login.dart';

class NotifyDialog extends StatelessWidget {
  const NotifyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Log out'),
      content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Hủy'),
        ),
        TextButton(
          onPressed:
              () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => LoginScreen())),
          child: Text('Đăng xuất'),
        ),
      ],
    );
  }
}
