import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../DM/CategoryDM.dart';
import '../../../DM/eventDM.dart';
import '../../../authentication/widgets/custom_elevated_button.dart';
import '../../../authentication/widgets/custom_text_button.dart';
import '../../../authentication/widgets/custom_text_form_field.dart';
import '../../../core/app_validators/app_validators.dart';
import '../../../core/resources/colors/colors_manager.dart';
import '../../../core/resources/constant_data/constant_data.dart';
import '../../../core/resources/routes/routes_manager.dart';
import '../../../extesions/getMonthNameExFun.dart';
import '../../../firebase_service/firestore/firestore_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/config_provider.dart';
import '../../../providers/location_map.dart';
import '../../tabs/home/widgets/tab_item.dart';

class UpdateEvent extends StatefulWidget {
  const UpdateEvent({super.key, required this.event});

  final EventDM event;


  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  LatLng get location => LatLng(widget.event.lat??0, widget.event.lng??0);

  int selectedIndex = 0;
  late TextEditingController titleController;
  late TextEditingController descController;
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
      setState(() {
        newSelectedLocation = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mapProvider = Provider.of<LocationMapProvider>(context);
    mapProvider.convertLatLong(location);
    final loc = AppLocalizations.of(context)!;
    final categories = ConstantManager.getCategories(context);
    selectedCategory = categories[selectedIndex];
    final configProvider = Provider.of<ConfigProvider>(context);

    final currentShownLat = newSelectedLocation?.latitude ?? widget.event.lat;
    final currentShownLng = newSelectedLocation?.longitude ?? widget.event.lng;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsManager.blue),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Update Event",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  configProvider.isLight
                      ? selectedCategory.lightImgPath
                      : selectedCategory.darkImgPath,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: CustomTabItem(
                        categoryDM: category,
                        isSelected: selectedIndex == index,
                        selectedBackgroundColor: ColorsManager.blue,
                        selectedContentColor: ColorsManager.offWhite,
                        unselectedContentColor: ColorsManager.blue,
                        unselectedBorderColor: ColorsManager.blue,
                        onTap: () => setState(() => selectedIndex = index),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Text(loc.title, style: Theme.of(context).textTheme.labelSmall),
              SizedBox(height: 8.h),
              CustomTextFormField(
                validator: AppValidators.validateTitle,
                hint: loc.eventTitle,
                prefixIcon: Icons.edit,
                controller: titleController,
              ),
              SizedBox(height: 8.h),
              Text(
                loc.description,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                validator: AppValidators.validateDescription,
                hint: loc.eventDesc,
                lines: 4,
                controller: descController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.date_range_outlined, color: ColorsManager.black),
                  SizedBox(width: 10.w),
                  Text(
                    selectedDate.toFormattedDate,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const Spacer(),
                  CustomTextButton(
                    title: loc.chooseDate,
                    onClick: _selectEventDate,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: ColorsManager.black),
                  SizedBox(width: 10.w),
                  Text(
                    selectedTime.format(context),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const Spacer(),
                  CustomTextButton(
                    title: loc.chooseTime,
                    onClick: _selectEventTime,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.indigo),
                ),
                child: InkWell(
                  onTap: _pickLocation,
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
                          '${mapProvider.city}, ${mapProvider.country}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(title: "Update Event", onClick: updateEvent),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectEventTime() async {
    selectedTime =
        await showTimePicker(
          context: context,
          initialTime: selectedTime,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(alwaysUse24HourFormat: false),
              child: child!,
            );
          },
        ) ??
            selectedTime;
    setState(() {});
  }

  Future<void> _selectEventDate() async {
    selectedDate =
        await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 3650)),
          lastDate: DateTime.now().add(const Duration(days: 3650)),
        ) ??
            selectedDate;
    setState(() {});
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
