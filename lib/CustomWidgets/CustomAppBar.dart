import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(backgroundColor: Color(0xff90cd6c)),
        Stack(
          children: [
            Container(
              color: Color(0xff90cd6c),
              height: AppBar().preferredSize.height / 2,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/startL.png',height: AppBar().preferredSize.height,)
            )
          ],
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
}