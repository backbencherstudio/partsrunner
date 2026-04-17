import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/my_order/presentation/providers/order_provider.dart';
import 'package:partsrunner/features/my_order/presentation/screens/order_details_screen.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LiveTrackingScreens extends ConsumerStatefulWidget {
  const LiveTrackingScreens({super.key, required this.id});

  final String id;

  @override
  ConsumerState<LiveTrackingScreens> createState() =>
      _LiveTrackingScreensState();
}

class _LiveTrackingScreensState extends ConsumerState<LiveTrackingScreens> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(23.7687735, 90.4255921);
  final Set<Polyline> _polylines = {};
  final String _googleApiKey = "AIzaSyC1Ec3gpghSa04uXd_qs7xx3lC3_xyLwHY";

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  bool _boundsFitted = false;

  void _fitBounds(DeliveryModel order) async {
    if (order.pickupLat == null ||
        order.pickupLng == null ||
        order.deliveryLat == null ||
        order.deliveryLng == null)
      return;

    final controller = await _controller.future;

    final southWestLat = math.min(order.pickupLat!, order.deliveryLat!);
    final southWestLng = math.min(order.pickupLng!, order.deliveryLng!);
    final northEastLat = math.max(order.pickupLat!, order.deliveryLat!);
    final northEastLng = math.max(order.pickupLng!, order.deliveryLng!);

    final bounds = LatLngBounds(
      southwest: LatLng(southWestLat, southWestLng),
      northeast: LatLng(northEastLat, northEastLng),
    );

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  void _getPolyline(DeliveryModel order) async {
    if (order.pickupLat == null ||
        order.pickupLng == null ||
        order.deliveryLat == null ||
        order.deliveryLng == null)
      return;

    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: _googleApiKey,
        request: PolylineRequest(
          origin: PointLatLng(order.pickupLat!, order.pickupLng!),
          destination: PointLatLng(order.deliveryLat!, order.deliveryLng!),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = [];
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }

        setState(() {
          _polylines.add(
            Polyline(
              polylineId: const PolylineId('road_polyline'),
              points: polylineCoordinates,
              color: Colors.blue,
              width: 5,
            ),
          );
        });
      } else {
        debugPrint("Polyline Error: ${result.errorMessage}");
      }
    } catch (e) {
      debugPrint("Error fetching polyline: $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Live Tracking"),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: ref.watch(getOrderDetailsProvider((widget.id)).future),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final order = snapshot.data;

          if (order != null && !_boundsFitted) {
            _fitBounds(order);
            _getPolyline(order);
            _boundsFitted = true;
          }

          // If road polylines aren't loaded yet, show a fallback straight line
          final polylines = _polylines.isNotEmpty
              ? _polylines
              : {
                  Polyline(
                    polylineId: const PolylineId('fallback_line'),
                    points: [
                      LatLng(order!.pickupLat!, order.pickupLng!),
                      LatLng(order.deliveryLat!, order.deliveryLng!),
                    ],
                    color: Colors.blue.withOpacity(0.5),
                    width: 5,
                  ),
                };

          final markers = <Marker>{};
          if (order!.pickupLat != null && order.pickupLng != null) {
            markers.add(
              Marker(
                markerId: const MarkerId('pickup'),
                position: LatLng(order.pickupLat!, order.pickupLng!),
                infoWindow: const InfoWindow(title: 'Pickup Location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ),
            );
          }
          if (order.deliveryLat != null && order.deliveryLng != null) {
            markers.add(
              Marker(
                markerId: const MarkerId('delivery'),
                position: LatLng(order.deliveryLat!, order.deliveryLng!),
                infoWindow: const InfoWindow(title: 'Delivery Location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ),
            );
          }

          return Stack(
            children: [
              GoogleMap(
                polylines: polylines,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                markers: markers,
              ),
              Positioned(
                bottom: 20,
                left: 15,
                right: 15,
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  // height: 200,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, color: Colors.red),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              "The package is estimated to arrive within the next ${order.estimatedTimeMin} minutes.",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      DeliveryTrackerCard(order: order),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DeliveryTrackerCard extends StatelessWidget {
  const DeliveryTrackerCard({super.key, required this.order});

  final DeliveryModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- 1. Profile Section ---
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: Image.asset(
                  'assets/images/profile1.png',
                ).image,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.runner?.user?.name ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Runner',
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey[400]),
                  ),
                ],
              ),
            ],
          ),
          8.verticalSpace,
          const Divider(color: Color(0xFFEEEEEE), thickness: 1),
          8.verticalSpace,

          // --- 2. Timeline Section ---

          // Step 1: On Delivery
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Line Column
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF5722), // Deep Orange
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  // Dashed Line
                  SizedBox(
                    height: 60, // Height of the gap
                    child: CustomPaint(painter: DashedLinePainter()),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Content Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'On Delivery',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Runner is delivering the package.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${order.estimatedTimeMin} minutes estimation',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Step 2: Delivered
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.blueGrey[400],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Delivered',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
