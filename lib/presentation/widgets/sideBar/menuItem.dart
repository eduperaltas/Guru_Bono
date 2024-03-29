import 'package:guru_bono/core/framework/colors.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final dynamic onTap;

  const MenuItemWidget({Key key, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: greenPrimary,
              size: MediaQuery.of(context).size.height * 0.035,
            ),
            SizedBox(width: MediaQuery.of(context).size.height * 0.025),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.03,
                color: txtPrimary,
                fontFamily: "Poppins",
              ),
            )
          ],
        ),
      ),
    );
  }
}
