
import 'package:evently/features/events/create_event/widgets/event_Info_row.dart';
import 'package:evently/features/tabs/map/provider/location_map.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectionBox extends StatelessWidget {
  final LatLng? selectedLocation;
  final LocationMapProvider mapProvider;
  final VoidCallback onTap;

  const LocationSelectionBox({
    super.key,
    required this.selectedLocation,
    required this.mapProvider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LocationSelector(
        selectedLocation: selectedLocation,
        mapProvider: mapProvider,
        loc: loc,
        onTap: onTap,
      ),
    );
  }
}