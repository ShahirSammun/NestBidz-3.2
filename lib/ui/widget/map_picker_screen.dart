import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerScreen extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;
  final String? initialAddress;

  const MapPickerScreen({Key? key, this.initialLat, this.initialLng, this.initialAddress}) : super(key: key);

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late LatLng _pickedLocation;
  String _address = "";
  GoogleMapController? _mapController;
  bool _isReverseLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialLat != null && widget.initialLng != null) {
      _pickedLocation = LatLng(widget.initialLat!, widget.initialLng!);
    } else {
      // default to Dhaka center
      _pickedLocation = const LatLng(23.8103, 90.4125);
    }
    if (widget.initialAddress != null && widget.initialAddress!.isNotEmpty) {
      _address = widget.initialAddress!;
    } else {
      _reverseGeocode(_pickedLocation);
    }
  }

  Future<void> _reverseGeocode(LatLng point) async {
    setState(() {
      _isReverseLoading = true;
    });
    try {
      final placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          if (p.street != null && p.street!.isNotEmpty) p.street,
          if (p.subLocality != null && p.subLocality!.isNotEmpty) p.subLocality,
          if (p.locality != null && p.locality!.isNotEmpty) p.locality,
          if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty) p.administrativeArea,
          if (p.country != null && p.country!.isNotEmpty) p.country,
        ];
        setState(() {
          _address = parts.join(', ');
          _pickedLocation = point;
        });
      }
    } catch (e) {
      // ignore errors - keep address blank
    } finally {
      setState(() {
        _isReverseLoading = false;
      });
    }
  }

  void _onMapTap(LatLng latLng) {
    _reverseGeocode(latLng);
    _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Location"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                'address': _address,
                'lat': _pickedLocation.latitude,
                'lng': _pickedLocation.longitude,
              });
            },
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _pickedLocation, zoom: 14),
            onMapCreated: (c) => _mapController = c,
            onTap: _onMapTap,
            markers: {
              Marker(markerId: const MarkerId('picked'), position: _pickedLocation),
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
          ),
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isReverseLoading ? "Detecting address..." : (_address.isNotEmpty ? _address : "Tap map to pick location"),
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // recenter to picked location
                      _mapController?.animateCamera(CameraUpdate.newLatLng(_pickedLocation));
                    },
                    icon: const Icon(Icons.gps_fixed),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}