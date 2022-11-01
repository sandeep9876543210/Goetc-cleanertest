import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/loginscreen.dart';
import 'package:flutter/material.dart';

class GuestDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [

        Positioned(
          left: 0, right: 0, top: -50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset("assets/logoo.png", height: 80, width: 80),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text('Alert', style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black),),
              SizedBox(height: 20),
              Text('Please login to continue',style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey)),
              SizedBox(height: 20),

              Divider(height: 0, color: Theme.of(context).hintColor),
              Row(children: [

                Expanded(child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
                    child: Text('Cancel', style: TextStyle(
                        fontSize: 14.0,
                        color: ConstantColors.newcolor)),
                  ),
                )),

                Expanded(child: InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: ConstantColors.newcolor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
                    child: Text('Login', style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white)),
                  ),
                )),

              ]),
            ],
          ),
        ),

      ]),
    );
  }
}
