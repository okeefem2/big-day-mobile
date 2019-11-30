import 'package:big_day_mobile/models/gallery_item.dart';
import 'package:big_day_mobile/pages/gallery_view_page.dart';
import 'package:big_day_mobile/services/gallery_service.dart';
import 'package:big_day_mobile/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Gallery extends StatefulWidget {
  @override
  GalleryState createState() => GalleryState();
}

class GalleryState extends State<Gallery> {
  final _controller = ScrollController();

  Widget _buildGalleryRow(GalleryItem galleryItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GalleryViewPage(galleryItem)));
          },
          child: FadeInImage(
            image: NetworkImage(galleryItem.photoUrl),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/sun-mountain.png'),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(galleryItem.description),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  Widget _buildListView(List<GalleryItem> gallery) {
    return ListView.builder(
      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        return _buildGalleryRow(gallery[index]);
      },
      itemCount: gallery.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    var gallery = Provider.of<List<GalleryItem>>(context);

    return _buildListView(gallery);
  }
}

class GalleryPage extends StatelessWidget {
  static const route = '/gallery';
  final GlobalKey<ScaffoldState> _scaffoldKeyGallery = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final galleryService = Provider.of<GalleryService>(context);
    return Scaffold(
        key: _scaffoldKeyGallery,
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Gallery'),
        ),
        body: StreamProvider<List<GalleryItem>>.value(
          value: galleryService.getGallery(),
          initialData: [],
          child: new Gallery(),
        ));
  }
}
