import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/resources/icons/icons_manager.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../authentication/widgets/custom_text_button.dart';
import '../../../core/resources/colors/colors_manager.dart';
import '../../../core/resources/constant_data/constant_data.dart';
import '../../tabs/home/widgets/tab_item.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "Book Club", "icon": Icons.menu_book},
    {"title": "Sport", "icon": Icons.sports_soccer},
    {"title": "Birthday", "icon": Icons.cake},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          "Create Event",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(ImagesManager.BookClub),
            ),


            const SizedBox(height: 20),

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ConstantManager.categories.length,
                itemBuilder: (context, index) {
                  final category = ConstantManager.categories[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: CustomTabItem(
                      categoryDM: category,
                      isSelected: selectedIndex == index,
                      selectedBackgroundColor: ColorsManager.blue,
                      selectedContentColor: ColorsManager.offWhite,
                      unselectedContentColor:  ColorsManager.blue,
                      unselectedBorderColor:  ColorsManager.blue,
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
            Text("Title",style: Theme.of(context).textTheme.labelSmall,),

            CustomTextFormField(hint: "Event Title", prefixIcon: Icons.edit),


             SizedBox(height: 8.h),
            Text("Description",style: Theme.of(context).textTheme.labelSmall,),
            SizedBox(height: 8.h),

            CustomTextFormField(hint: "Event Description",lines: 4, ),

            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.date_range_outlined,color: ColorsManager.black),
                SizedBox(width: 10.w,),
                Text("Event Date",style:Theme.of(context).textTheme.labelSmall ,),
                Spacer(),
                CustomTextButton(title: "Choose Date",onClick: _selectEventDate,)
              ],
            ),
            Row(
              children: [
                Icon(Icons.date_range_outlined,color: ColorsManager.black),
                SizedBox(width: 10.w,),
                Text("Event Time",style:Theme.of(context).textTheme.labelSmall ,),
                Spacer(),
                CustomTextButton(title: "Choose Time",onClick: _selectEventTime,)
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
                      "Choose Event Location",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 16
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),

            const SizedBox(height: 30),

            CustomElevatedButton(title: "Add Event", onClick: (){})
          ],
        ),
      ),
    );
  }


  void _selectEventTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
  void _selectEventDate() {
    showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
  }
}