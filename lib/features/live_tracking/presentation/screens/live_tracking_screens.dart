import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/job_details/presentation/providers/job_details_provider.dart';
import 'package:partsrunner/features/live_tracking/presentation/widgets/contractor_live_card.dart';
import 'package:partsrunner/features/live_tracking/presentation/widgets/runner_live_card.dart';
import 'package:partsrunner/features/my_order/presentation/providers/order_provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LiveTrackingScreens extends ConsumerStatefulWidget {
  const LiveTrackingScreens({super.key, required this.id, this.isContractor = true});

  final String id;
  final bool isContractor;

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
        future: widget.isContractor ? ref.watch(getOrderDetailsProvider((widget.id)).future) : ref.watch(getRequestById((widget.id)).future),
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
                child: widget.isContractor
                    ? ContractorLiveCard(order: order)
                    : RunnerLiveCard(order: order),
              ),
            ],
          );
        },
      ),
    );
  }
}
