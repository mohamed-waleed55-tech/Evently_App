import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/features/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/features/events/create_event/bloc/create_event_bloc.dart';
import 'package:evently/features/events/create_event/widgets/category_image_card.dart';
import 'package:evently/features/events/create_event/widgets/category_selector.dart';
import 'package:evently/features/events/create_event/widgets/datetime_selection_box.dart';
import 'package:evently/features/events/create_event/widgets/event_form_fields.dart';
import 'package:evently/features/events/create_event/widgets/location_selection_box.dart';
import 'package:evently/features/tabs/map/provider/location_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:evently/core/utils/dialog.dart';
import 'package:evently/core/resources/constant_data/constant_data.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/l10n/app_localizations.dart';



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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => CreateEventBloc(),
      child: BlocListener<CreateEventBloc, CreateEventState>(
        listener: _handleBlocListener,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: REdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colorScheme.primary,
                  size: 18.r,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              loc.createEvent,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Form(
              key: formKey,
              child: BlocBuilder<CreateEventBloc, CreateEventState>(
                builder: (blocContext, state) {
                  final categories = ConstantManager.getCategories(blocContext);
                  final selectedCategory = categories[state.selectedIndex];
                  final mapProvider = blocContext.watch<LocationMapProvider>();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryImageCard(selectedCategory: selectedCategory),
                      SizedBox(height: 16.h),

                      CategorySelector(
                        categories: categories,
                        selectedIndex: state.selectedIndex,
                      ),
                      SizedBox(height: 20.h),

                      EventFormFields(
                        titleController: titleController,
                        descController: descController,
                      ),
                      SizedBox(height: 20.h),

                      DateTimeSelectionBox(
                        selectedDate: state.selectedDate,
                        selectedTime: state.selectedTime,
                        onDateTap: () => _pickDate(blocContext, state),
                        onTimeTap: () => _pickTime(blocContext, state),
                      ),
                      SizedBox(height: 16.h),

                      LocationSelectionBox(
                        selectedLocation: state.selectedLocation,
                        mapProvider: mapProvider,
                        onTap: () => _pickLocation(blocContext),
                      ),
                      SizedBox(height: 28.h),

                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: CustomElevatedButton(
                          title: loc.addEvent,
                          onClick: () => _submitForm(
                            blocContext,
                            state,
                            selectedCategory.id,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
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
    // اغلاق الـ Dialog الخاص بالـ Loading
    Navigator.pop(context); 

    DialogUtils.showMessage(
      context,
      message: "Event added successfully",
      posActionTitle: "OK",
      posAction: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.mainLayout,
          (route) => false,
        );
      },
    );
  } else if (state.status == CreateEventStatus.failure) {
    Navigator.pop(context); 

    DialogUtils.showMessage(
      context,
      message: state.errorMessage ?? "Error",
    );
  }
}

void _pickDate(BuildContext blocContext, CreateEventState state) async {
  final date = await showDatePicker(
    context: blocContext,
    initialDate: state.selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );

  // التأكد من أن الـ Widget لا زال موجوداً قبل استدعاء الـ Bloc
  if (date != null && blocContext.mounted) {
    blocContext.read<CreateEventBloc>().add(DateChanged(date));
  }
}

void _pickTime(BuildContext blocContext, CreateEventState state) async {
  final time = await showTimePicker(
    context: blocContext,
    initialTime: state.selectedTime,
  );

  if (time != null && blocContext.mounted) {
    blocContext.read<CreateEventBloc>().add(TimeChanged(time));
  }
}

void _pickLocation(BuildContext blocContext) async {
  final result = await Navigator.pushNamed(
    blocContext,
    RoutesManager.pickLocation,
  );

  if (result is LatLng && blocContext.mounted) {
    blocContext.read<CreateEventBloc>().add(LocationPicked(result));
    blocContext.read<LocationMapProvider>().convertLatLong(result);
  }
}

void _submitForm(
  BuildContext blocContext,
  CreateEventState state,
  String categoryId,
) {
  if (formKey.currentState!.validate()) {
    if (state.selectedLocation == null) {
      DialogUtils.showMessage(
        blocContext,
        message: AppLocalizations.of(blocContext)!.chooseEventLocation,
        posActionTitle: "OK",
      );
      return;
    }

    blocContext.read<CreateEventBloc>().add(
          SubmitEventRequested(
            title: titleController.text.trim(),
            description: descController.text.trim(),
            categoryId: categoryId,
          ),
        );
  }
}
}

