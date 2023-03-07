import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/mainScreens/itemsScreen.dart';
import 'package:selller_amigo_app/model/menus.dart';

class InfoDesignWidget extends StatefulWidget {
  final Menus? model;
  BuildContext? context;

  InfoDesignWidget({super.key, this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.amber,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemsScreen(model: widget.model)));
        },
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemsScreen(model: widget.model)));
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.model!.menuTitle!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
