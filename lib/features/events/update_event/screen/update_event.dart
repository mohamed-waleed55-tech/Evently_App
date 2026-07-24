import 'package:evently/features/events/update_event/widgets/category_selector_widget.dart';
import 'package:evently/features/events/update_event/widgets/date_time_row_widget.dart';
import 'package:evently/features/events/update_event/widgets/event_header_image.dart';
import 'package:evently/features/events/update_event/widgets/event_text_field.dart';
import 'package:evently/features/events/update_event/widgets/location_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../DM/CategoryDM.dart';
import '../../../../../DM/eventDM.dart';
import '../../../../../core/app_validators/app_validators.dart';
import '../../../../../core/extesions/getMonthNameExFun.dart';
import '../../../../../core/firebase_service/firestore/firestore_service.dart';
import '../../../../../core/resources/constant_data/constant_data.dart';
import '../../../../../core/resources/routes/routes_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../authentication/widgets/custom_elevated_button.dart';
import '../../../tabs/map/provider/location_map.dart';
import '../../../tabs/profile/provider/config_provider.dart';


class UpdateEvent extends StatefulWidget {
  const UpdateEvent({super.key, required this.event});

  final EventDM event;

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  LatLng get initialLocation => LatLng(widget.event.lat ?? 0, widget.event.lng ?? 0);

  int selectedIndex = 0;
  late final TextEditingController titleController;
  late final TextEditingController descController;
  late CategoryDM selectedCategory;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LatLng? newSelectedLocation;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final categories = ConstantManager.getCategories(context);
    final current = widget.event;

    titleController.text = current.title;
    descController.text = current.description;
    selectedDate = current.dateTime;
    selectedTime = TimeOfDay.fromDateTime(current.dateTime);

    final index = categories.indexWhere((c) => c.id == current.category);
    selectedIndex = index == -1 ? 0 : index;
    selectedCategory = categories[selectedIndex];

    context.read<LocationMapProvider>().convertLatLong(initialLocation);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.pushNamed(context, RoutesManager.pickLocation);
    if (result is LatLng) {
      setState(() => newSelectedLocation = result);
      if (mounted) {
        context.read<LocationMapProvider>().convertLatLong(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final categories = ConstantManager.getCategories(context);
    selectedCategory = categories[selectedIndex];
    final isLight = context.watch<ConfigProvider>().isLight;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          loc.updateEvent ?? "Update Event",
          style: theme.textTheme.labelMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventHeaderImage(
                imagePath: isLight ? selectedCategory.lightImgPath : selectedCategory.darkImgPath,
              ),
              SizedBox(height: 16.h),
              CategorySelectorWidget(
                categories: categories,
                selectedIndex: selectedIndex,
                onCategorySelected: (index) => setState(() => selectedIndex = index),
              ),
              SizedBox(height: 16.h),
              EventTextField(
                label: loc.title,
                hint: loc.eventTitle,
                prefixIcon: Icons.edit,
                controller: titleController,
                validator: AppValidators.validateTitle,
              ),
              SizedBox(height: 16.h),
              EventTextField(
                label: loc.description,
                hint: loc.eventDesc,
                maxLines: 4,
                controller: descController,
                validator: AppValidators.validateDescription,
              ),
              SizedBox(height: 16.h),
              DateTimeRowWidget(
                icon: Icons.date_range_outlined,
                title: selectedDate.toFormattedDate,
                buttonTitle: loc.chooseDate,
                onTap: _selectEventDate,
              ),
              DateTimeRowWidget(
                icon: Icons.timer_outlined,
                title: selectedTime.format(context),
                buttonTitle: loc.chooseTime,
                onTap: _selectEventTime,
              ),
              SizedBox(height: 16.h),
              LocationSelectorWidget(onTap: _pickLocation),
              SizedBox(height: 24.h),
              CustomElevatedButton(
                title: loc.updateEvent ?? "Update Event",
                onClick: updateEvent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectEventTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ),
    );
    if (pickedTime != null) setState(() => selectedTime = pickedTime);
  }

  Future<void> _selectEventDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (pickedDate != null) setState(() => selectedDate = pickedDate);
  }

  Future<void> updateEvent() async {
    if (!formKey.currentState!.validate()) return;

    final dateTime = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );

    final updatedEvent = EventDM(
      id: widget.event.id,
      title: titleController.text.trim(),
      description: descController.text.trim(),
      category: selectedCategory.id,
      imagePath: widget.event.imagePath,
      dateTime: dateTime,
      lat: newSelectedLocation?.latitude ?? widget.event.lat,
      lng: newSelectedLocation?.longitude ?? widget.event.lng,
      createdById: widget.event.createdById,
    );

    await FirestoreService.updateEvent(updatedEvent);
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      RoutesManager.eventDetails,
      arguments: updatedEvent,
    );
  }
}