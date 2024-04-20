import 'dart:async';
import 'dart:convert';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ints/base/base_controller.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapSearchAndPickWidget extends StatefulWidget {
  final void Function(PickedData pickedData) onPicked;

  final Color buttonColor;
  final Color locationPinIconColor;
  final String hintText;
  final TextStyle buttonTextStyle;
  final String baseUri;
  final String initialText;
  final LatLng initialMapCenter;
  const OpenStreetMapSearchAndPickWidget({
    Key? key,
    required this.onPicked,
    this.buttonColor = Colors.blue,
    this.locationPinIconColor = Colors.blue,
    this.hintText = 'Tìm kiếm',
    this.buttonTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    this.baseUri = 'https://nominatim.openstreetmap.org',
    this.initialText = '',
    this.initialMapCenter =
        const LatLng(20.990752819016954, 105.78315150878022),
  }) : super(key: key);

  @override
  State<OpenStreetMapSearchAndPickWidget> createState() =>
      _OpenStreetMapSearchAndPickWidgetState();
}

class _OpenStreetMapSearchAndPickWidgetState
    extends State<OpenStreetMapSearchAndPickWidget> {
  late TextEditingController _searchController;
  late MapController _mapController;
  String selectedCurrentAddress = '';
  String selectedDetailAddress = '';
  final FocusNode _focusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;
  var client = http.Client();
  late Future<Position?> latlongFuture;
  String ward = '';
  String district = '';
  String city = '';
  Future<Position?> getCurrentPosLatLong() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();

    /// do not have location permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      return await getPosition(locationPermission);
    }

    /// have location permission
    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  Future<Position?> getPosition(LocationPermission locationPermission) async {
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      return null;
    }
    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  void setNameCurrentPos() async {
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  void setNameCurrentPosAtInit(double latitude, double longitude) async {
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }

    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    List<String> addressNameParts = decodedResponse['display_name'].split(', ');

    if (addressNameParts.length > 5) {
      addressNameParts.removeRange(
          addressNameParts.length - 2, addressNameParts.length);
      List<String> currentAddressParts =
          addressNameParts.sublist(addressNameParts.length - 3);
      List<String> detailAddressParts =
          addressNameParts.sublist(0, addressNameParts.length - 3);
      String currentAddress = currentAddressParts.join(', ');
      String detailAddress = detailAddressParts.join(', ');
      final specificCurrentAddressParts = currentAddress.split(", ");
      ward = specificCurrentAddressParts[0];
      district = specificCurrentAddressParts[1];
      city = specificCurrentAddressParts[2];
      setState(() {
        selectedDetailAddress = detailAddress;
        selectedCurrentAddress = currentAddress;
      });
    } else if (addressNameParts.length == 5) {
      addressNameParts.removeRange(
          addressNameParts.length - 2, addressNameParts.length);
      String currentAddress = addressNameParts.join(', ');
      final specificCurrentAddressParts = currentAddress.split(", ");
      ward = specificCurrentAddressParts[0];
      district = specificCurrentAddressParts[1];
      city = specificCurrentAddressParts[2];
      setState(() {
        selectedDetailAddress = '';
        selectedCurrentAddress = currentAddress;
      });
    } else if (addressNameParts.length == 4) {
      if (int.tryParse(addressNameParts[addressNameParts.length - 2]) != null) {
        addressNameParts.removeRange(
            addressNameParts.length - 2, addressNameParts.length);
        district = addressNameParts[0];
        city = addressNameParts[1];
      } else {
        addressNameParts.removeRange(
            addressNameParts.length - 1, addressNameParts.length);
        ward = addressNameParts[0];
        district = addressNameParts[1];
        city = addressNameParts[2];
      }
    } else if (addressNameParts.length == 3) {
      addressNameParts.removeRange(
          addressNameParts.length - 1, addressNameParts.length);
      district = addressNameParts[0];
      city = addressNameParts[1];
    }
  }

  @override
  void initState() {
    _searchController = TextEditingController(text: widget.initialText);
    _mapController = MapController();

    _mapController.mapEventStream.listen(
      (event) async {
        if (event is MapEventMoveEnd) {
          var client = http.Client();
          String url =
              '${widget.baseUri}/reverse?format=json&lat=${event.camera.center.latitude}&lon=${event.camera.center.longitude}&zoom=18&addressdetails=1';

          var response = await client.get(Uri.parse(url));
          // var response = await client.post(Uri.parse(url));
          var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
              as Map<dynamic, dynamic>;

          _searchController.text = decodedResponse['display_name'];
          List<String> addressNameParts =
              decodedResponse['display_name'].split(', ');

          if (addressNameParts.length > 5) {
            addressNameParts.removeRange(
                addressNameParts.length - 2, addressNameParts.length);
            List<String> currentAddressParts =
                addressNameParts.sublist(addressNameParts.length - 3);
            List<String> detailAddressParts =
                addressNameParts.sublist(0, addressNameParts.length - 3);
            String currentAddress = currentAddressParts.join(', ');
            String detailAddress = detailAddressParts.join(', ');
            final specificCurrentAddressParts = currentAddress.split(", ");
            ward = specificCurrentAddressParts[0];
            district = specificCurrentAddressParts[1];
            city = specificCurrentAddressParts[2];
            setState(() {
              selectedDetailAddress = detailAddress;
              selectedCurrentAddress = currentAddress;
            });
          } else if (addressNameParts.length == 5) {
            addressNameParts.removeRange(
                addressNameParts.length - 2, addressNameParts.length);
            String currentAddress = addressNameParts.join(', ');
            final specificCurrentAddressParts = currentAddress.split(", ");
            ward = specificCurrentAddressParts[0];
            district = specificCurrentAddressParts[1];
            city = specificCurrentAddressParts[2];
            setState(() {
              selectedDetailAddress = '';
              selectedCurrentAddress = currentAddress;
            });
          } else if (addressNameParts.length == 4) {
            if (int.tryParse(addressNameParts[addressNameParts.length - 2]) !=
                null) {
              addressNameParts.removeRange(
                  addressNameParts.length - 2, addressNameParts.length);
              district = addressNameParts[0];
              city = addressNameParts[1];
              setState(() {
                selectedDetailAddress = '';
                selectedCurrentAddress = '$district, $city';
              });
            } else {
              addressNameParts.removeRange(
                  addressNameParts.length - 1, addressNameParts.length);
              ward = addressNameParts[0];
              district = addressNameParts[1];
              city = addressNameParts[2];
              setState(() {
                selectedDetailAddress = '';
                selectedCurrentAddress = '$district, $city';
              });
            }
          } else if (addressNameParts.length == 3) {
            addressNameParts.removeRange(
                addressNameParts.length - 1, addressNameParts.length);
            district = addressNameParts[0];
            city = addressNameParts[1];
            setState(() {
              selectedDetailAddress = '';
              selectedCurrentAddress = '$district, $city';
            });
          }
        }
      },
    );

    latlongFuture = getCurrentPosLatLong();

    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String? _autocompleteSelection;
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor),
      borderRadius: BorderRadius.circular(8),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor, width: 3.0),
    );
    return FutureBuilder<Position?>(
      future: latlongFuture,
      builder: (context, snapshot) {
        LatLng? mapCentre;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // if (snapshot.hasError) {
        //   return const Center(
        //     child: Text("Something went wrong"),
        //   );
        // }

        if (snapshot.hasData && snapshot.data != null) {
          mapCentre = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
        }
        return SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: FlutterMap(
                  options: MapOptions(
                      initialCenter: widget.initialMapCenter,
                      initialZoom: 15,
                      center: mapCentre,
                      zoom: 15.0,
                      maxZoom: 18,
                      minZoom: 6),
                  mapController: _mapController,
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                      // attributionBuilder: (_) {
                      //   return Text("© OpenStreetMap contributors");
                      // },
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Icon(
                            Icons.location_on,
                            size: 50,
                            color: widget.locationPinIconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 270,
                right: 5,
                child: Container(
                  width: 30,
                  height: 30,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn1',
                      backgroundColor: Colors.green,
                      onPressed: () {
                        _mapController.move(
                            _mapController.center, _mapController.zoom + 1);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 230,
                right: 5,
                child: Container(
                  width: 30,
                  height: 30,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn2',
                      backgroundColor: Colors.green,
                      onPressed: () {
                        _mapController.move(
                            _mapController.center, _mapController.zoom - 1);
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 190,
                right: 5,
                child: Container(
                  width: 30,
                  height: 30,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn3',
                      backgroundColor: Colors.green,
                      onPressed: () async {
                        if (mapCentre != null) {
                          _mapController.move(
                              LatLng(mapCentre.latitude, mapCentre.longitude),
                              _mapController.zoom);
                        } else {
                          _mapController.move(
                              LatLng(50.5, 30.51), _mapController.zoom);
                        }
                        setNameCurrentPos();
                      },
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 30,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(23, 23, 23, 1).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        XR().svgImage.ic_back,
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  )),
              Positioned(
                top: 15,
                left: 56,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            border: inputBorder,
                            focusedBorder: inputFocusBorder,
                            prefixIcon: Container(
                              margin: EdgeInsets.all(10),
                              child: SvgPicture.asset(XR().svgImage.ic_search),
                            ),
                          ),
                          onChanged: (String value) {
                            if (_debounce?.isActive ?? false) {
                              _debounce?.cancel();
                            }

                            _debounce = Timer(
                                const Duration(milliseconds: 2000), () async {
                              if (kDebugMode) {
                                print(value);
                              }
                              var client = http.Client();
                              try {
                                String url =
                                    '${widget.baseUri}/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';
                                if (kDebugMode) {
                                  print(url);
                                }
                                var response = await client.get(Uri.parse(url));
                                // var response = await client.post(Uri.parse(url));
                                var decodedResponse =
                                    jsonDecode(utf8.decode(response.bodyBytes))
                                        as List<dynamic>;
                                if (kDebugMode) {
                                  print(decodedResponse);
                                }
                                _options = decodedResponse
                                    .map(
                                      (e) => OSMdata(
                                        displayname: e['display_name'],
                                        lat: double.parse(e['lat']),
                                        lon: double.parse(e['lon']),
                                      ),
                                    )
                                    .toList();
                                setState(() {});
                              } finally {
                                client.close();
                              }

                              setState(() {});
                            });
                          }),
                      ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(height: 1, color: Color(0xffD9D9D9)),
                        shrinkWrap: true,
                        itemCount: _options.length > 5 ? 5 : _options.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                            title: Align(
                              alignment: FractionalOffset.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  _mapController.move(
                                      LatLng(_options[index].lat,
                                          _options[index].lon),
                                      15.0);
                                  setState(() {
                                    selectedCurrentAddress =
                                        _options[index].displayname;
                                    selectedDetailAddress = '';
                                    _searchController.text =
                                        _options[index].displayname;
                                  });
                                  _focusNode.unfocus();
                                  _options.clear();
                                },
                                child: Text(
                                  '${_options[index].displayname}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(78, 79, 84, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: (selectedCurrentAddress == '' &&
                        selectedDetailAddress == '')
                    ? Container()
                    : Container(
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(225, 226, 227, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            XR().svgImage.ic_location,
                                            width: 24,
                                            height: 24),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        selectedDetailAddress == ''
                                            ? Flexible(
                                                fit: FlexFit.loose,
                                                child: Text(
                                                  selectedCurrentAddress,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        23, 23, 23, 1),
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Text(
                                                        selectedDetailAddress,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color.fromRGBO(
                                                              23, 23, 23, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Text(
                                                        selectedCurrentAddress,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromRGBO(
                                                              78, 79, 84, 1),
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      final value = await pickData();
                                      widget.onPicked(value);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(34, 161, 33, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        'Xác nhận',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        '${widget.baseUri}/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];
    return PickedData(center, displayName, decodedResponse["address"]);
  }
}

class OSMdata {
  final String displayname;
  final double lat;
  final double lon;
  OSMdata({required this.displayname, required this.lat, required this.lon});
  @override
  String toString() {
    return '$displayname, $lat, $lon';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;
  const LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String addressName;
  final Map<String, dynamic> address;

  PickedData(this.latLong, this.addressName, this.address);
}
