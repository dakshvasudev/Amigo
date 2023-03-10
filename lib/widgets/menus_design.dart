import 'package:flutter/material.dart';
import 'package:user_amigo_app/mainScreens/items_screen.dart';
import 'package:user_amigo_app/model/menus.dart';


class MenusDesignWidget extends StatefulWidget
{
  Menus? model;
  BuildContext? context;

  MenusDesignWidget({this.model, this.context});

  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}



class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          color: Color(0xffd9d9d9),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 220.0,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 1.0,),
              Column(
                children: [
                  Text(
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 20,
                      fontFamily: "Train",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      widget.model!.menuInfo!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
