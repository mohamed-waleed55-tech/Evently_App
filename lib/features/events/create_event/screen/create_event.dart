import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:evently/core/utils/dialog.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/constant_data/constant_data.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import '../../../../../core/app_validators/app_validators.dart';
import '../../../../../core/extesions/getMonthNameExFun.dart';
import '../../../authentication/widgets/custom_elevated_button.dart';
import '../../../authentication/widgets/custom_text_form_field.dart';
import '../../../tabs/home/widgets/tab_item.dart';
import '../../../tabs/map/provider/location_map.dart';
import '../../../tabs/profile/provider/config_provider.dart';
import '../bloc/create_event_bloc.dart';


import '../widgets/event_Info_row.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final categories = ConstantManager.getCategories(context);
    final configProvider = Provider.of<ConfigProvider>(context);

    return BlocProvider(
      create: (context) => CreateEventBloc(),
      child: BlocListener<CreateEventBloc, CreateEventState>(
        listener: _handleBlocListener,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: ColorsManager.blue),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(loc.createEvent, style: Theme
                .of(context)
                .textTheme
                .labelMedium),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: BlocBuilder<CreateEventBloc, CreateEventState>(
                builder: (context, state) {
                  final selectedCategory = categories[state.selectedIndex];
                  final mapProvider = context.watch<LocationMapProvider>();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.asset(configProvider.isLight
                            ? selectedCategory.lightImgPath
                            : selectedCategory.darkImgPath),
                      ),
                      const SizedBox(height: 20),

                      _buildCategoryList(categories, state),

                      SizedBox(height: 16.h),
                      _buildTextFields(loc),

                      const SizedBox(height: 20),

                      EventInfoRow(
                        icon: Icons.date_range_outlined,
                        value: state.selectedDate.toFormattedDate,
                        buttonTitle: loc.chooseDate,
                        onPressed: () => _pickDate(context, state),
                      ),

                      EventInfoRow(
                        icon: Icons.timer_outlined,
                        value: state.selectedTime.format(context),
                        buttonTitle: loc.chooseTime,
                        onPressed: () => _pickTime(context, state),
                      ),

                      const SizedBox(height: 20),

                      LocationSelector(
                        selectedLocation: state.selectedLocation,
                        mapProvider: mapProvider,
                        loc: loc,
                        onTap: () => _pickLocation(context),
                      ),

                      const SizedBox(height: 30),

                      CustomElevatedButton(
                        title: loc.addEvent,
                        onClick: () =>
                            _submitForm(context, state, selectedCategory.id),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _handleBlocListener(BuildContext context, CreateEventState state) {
    if (state.status == CreateEventStatus.loading) {
      DialogUtils.showLoadingDialog(context, "Adding event...");
    } else if (state.status == CreateEventStatus.success) {
      Navigator.pop(context);
      DialogUtils.showMessage(
          context, message: "Event added successfully", posActionTitle: "OK",
          posAction: () =>
              Navigator.pushNamedAndRemoveUntil(
              context, RoutesManager.mainLayout, (route) => false));
    } else if (state.status == CreateEventStatus.failure) {
      Navigator.pop(context);
      DialogUtils.showMessage(context, message: state.errorMessage ?? "Error");
    }
  }

  Widget _buildCategoryList(List categories, CreateEventState state) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: CustomTabItem(
                categoryDM: categories[index],
                isSelected: state.selectedIndex == index,
                onTap: () =>
                    context.read<CreateEventBloc>().add(CategoryChanged(index)),
                selectedBackgroundColor: ColorsManager.blue,
                selectedContentColor: ColorsManager.offWhite,
                unselectedContentColor: ColorsManager.blue,
                unselectedBorderColor: ColorsManager.blue,
              ),
            ),
      ),
    );
  }

  Widget _buildTextFields(AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.title, style: Theme
            .of(context)
            .textTheme
            .labelSmall),
        SizedBox(height: 8.h),
        CustomTextFormField(validator: AppValidators.validateTitle,
            hint: loc.eventTitle,
            prefixIcon: Icons.edit,
            controller: titleController),
        SizedBox(height: 8.h),
        Text(loc.description, style: Theme
            .of(context)
            .textTheme
            .labelSmall),
        SizedBox(height: 8.h),
        CustomTextFormField(validator: AppValidators.validateDescription,
            hint: loc.eventDesc,
            lines: 4,
            controller: descController),
      ],
    );
  }

  void _pickDate(BuildContext context, CreateEventState state) async {
    final date = await showDatePicker(context: context,
        initialDate: state.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (date != null) context.read<CreateEventBloc>().add(DateChanged(date));
  }

  void _pickTime(BuildContext context, CreateEventState state) async {
    final time = await showTimePicker(
        context: context, initialTime: state.selectedTime);
    if (time != null) context.read<CreateEventBloc>().add(TimeChanged(time));
  }

  void _pickLocation(BuildContext context) async {
    final result = await Navigator.pushNamed(
        context, RoutesManager.pickLocation);
    if (result is LatLng) {
      context.read<CreateEventBloc>().add(LocationPicked(result));
      context.read<LocationMapProvider>().convertLatLong(result);
    }
  }

  void _submitForm(BuildContext context, CreateEventState state,
      String categoryId) {
    if (formKey.currentState!.validate()) {
      if (state.selectedLocation == null) {
        DialogUtils.showMessage(
            context, message: AppLocalizations.of(context)!.chooseEventLocation,
            posActionTitle: "OK");
        return;
      }
      context.read<CreateEventBloc>().add(SubmitEventRequested(
        title: titleController.text.trim(),
        description: descController.text.trim(),
        categoryId: categoryId,
      ));
    }
  }
}