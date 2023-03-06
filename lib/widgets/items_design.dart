import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/model/items.dart';




class ItemsDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}



class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        //Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: kColorRed,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 210,
          width: 90,
          margin:
          const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: kColorRed,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 20,
                color: kColorRed.withOpacity(0.32),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemsScreen(model: widget.model)));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(
                        widget.model!.thumbnailUrl!,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      widget.model!.title!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
