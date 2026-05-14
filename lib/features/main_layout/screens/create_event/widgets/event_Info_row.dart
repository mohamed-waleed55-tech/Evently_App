import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import '../../../../authentication/widgets/custom_text_button.dart';
import '../../../tabs/map/provider/location_map.dart';
import '../bloc/create_event_bloc.dart';

class EventInfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final String buttonTitle;
  final VoidCallback onPressed;

  const EventInfoRow({
    super.key,
    required this.icon,
    required this.value,
    required this.buttonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: ColorsManager.black),
        SizedBox(width: 10.w),
        Text(value, style: Theme.of(context).textTheme.labelSmall),
        const Spacer(),
        CustomTextButton(title: buttonTitle, onClick: onPressed),
      ],
    );
  }
}

class LocationSelector extends StatelessWidget {
  final LatLng? selectedLocation;
  final LocationMapProvider mapProvider;
  final AppLocalizations loc;
  final VoidCallback onTap;

  const LocationSelector({
    super.key,
    this.selectedLocation,
    required this.mapProvider,
    required this.loc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.location_on, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedLocation == null
                    ? loc.chooseEventLocation
                    : (mapProvider.city.isEmpty || mapProvider.country.isEmpty)
                    ? '${selectedLocation!.latitude.toStringAsFixed(6)} , ${selectedLocation!.longitude.toStringAsFixed(6)}'
                    : '${mapProvider.city} , ${mapProvider.country}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}