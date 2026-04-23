import 'package:evently/DM/CategoryDM.dart';
import 'package:evently/DM/eventDM.dart';
import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/extesions/getMonthNameExFun.dart';
import 'package:evently/firebase_service/firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../authentication/widgets/custom_text_button.dart';
import '../../../core/app_validators/app_validators.dart';
import '../../../core/resources/colors/colors_manager.dart';
import '../../../core/resources/constant_data/constant_data.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/config_provider.dart';
import '../../tabs/home/widgets/tab_item.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  late TextEditingController titleController ;
  late TextEditingController descController ;
  late CategoryDM selectedCategory;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();

  }
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context)!;
    final categories = ConstantManager.getCategories(context);
    selectedCategory = categories[selectedIndex];
    var configProvider = Provider.of<ConfigProvider>(context);

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorsManager.blue,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          loc.createEvent,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key:formKey ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(configProvider.isLight ? selectedCategory.lightImgPath : selectedCategory.darkImgPath, ),
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
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
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
                  Spacer(),
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
                  Spacer(),
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
                        loc.chooseEventLocation,
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(fontSize: 16),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              CustomElevatedButton(title: loc.addEvent, onClick: createEvent),
            ],
          ),
        ),
      ),
    );
  }

  void _selectEventTime() async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now(), builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        },) ??
        selectedTime;
    setState(() {

    });
  }

  void createEvent() {
    if(!formKey.currentState!.validate()){
      return;
    }
    selectedDate=selectedDate.copyWith(hour: selectedTime.hour,minute: selectedTime.minute);
    EventDM event = EventDM(
      title: titleController.text,
      description: descController.text,
      category: selectedCategory.id,
      imagePath: "  ",
      dateTime: selectedDate,
      lat: 22,
      lng: 55,
    );
    FirestoreService.addEvent(event);
    formKey.currentState!.reset();

  }

  void _selectEventDate() async {
    selectedDate =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
        selectedDate;
    setState(() {});
  }
}
