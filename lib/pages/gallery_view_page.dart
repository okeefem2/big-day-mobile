import 'package:big_day_mobile/models/gallery_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GalleryViewPage extends StatelessWidget { 
  final GalleryItem galleryItem;
  final dateFormatter = DateFormat('MMMEd');


  GalleryViewPage(this.galleryItem);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              title: Text(dateFormatter.format(galleryItem.created)),
          ),
          body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.all(10.0),
            child:  Column(
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(galleryItem.photoUrl),
                height: 500.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/sun-mountain.png'),
              ),
              SizedBox(height: 10.0,),
              Text(galleryItem.description),
              SizedBox(height: 10.0,)
            ],
          ),)
          )
        );
    
  }
}
