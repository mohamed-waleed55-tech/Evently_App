

import 'package:evently/core/extesions/getMonthNameExFun.dart';
import 'package:evently/features/events/create_event/widgets/event_Info_row.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimeSelectionBox extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;

  const DateTimeSelectionBox({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateTap,
    required this.onTimeTap,
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
      child: Column(
        children: [
          EventInfoRow(
            icon: Icons.calendar_month_rounded,
            value: selectedDate.toFormattedDate,
            buttonTitle: loc.chooseDate,
            onPressed: onDateTap,
          ),
          Divider(
            height: 24.h,
            thickness: 0.8,
            color: colorScheme.outlineVariant.withOpacity(0.4),
          ),
          EventInfoRow(
            icon: Icons.access_time_filled_rounded,
            value: selectedTime.format(context),
            buttonTitle: loc.chooseTime,
            onPressed: onTimeTap,
          ),
        ],
      ),
    );
  }
}

