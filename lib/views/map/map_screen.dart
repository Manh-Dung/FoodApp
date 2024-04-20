import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/map/map_binding.dart';
import 'package:ints/views/map/widgets/open_and_pick_map_widget.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends BaseView<MapController> {
  Widget vBuilder() {
    return Scaffold(
      body: SafeArea(
        child: OpenStreetMapSearchAndPickWidget(
          buttonTextStyle: const TextStyle(fontSize: 18),
          buttonColor: Colors.white,
          initialMapCenter: LatLng(controller.latitude, controller.longtitude),
          onPicked: (pickedData) {
            controller.setCurrentAddress(pickedData.addressName);
          },
        ),
      ),
    );
  }
}
