import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/location_map.dart';

class GoogleMap extends StatelessWidget {
  const GoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    LocationMapProvider locationMapProvider=Provider.of<LocationMapProvider>(context);
    return  Center(child: Text(locationMapProvider.locationMessage,style: Theme.of(context).textTheme.labelMedium),);
  }
}
