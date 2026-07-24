import 'package:evently/features/tabs/home/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/constant_data/constant_data.dart';
import '../cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ConstantManager.getCategoriesWithAll(context);

    return BlocProvider(
      create: (context) => HomeCubit()..getEvents(categories[0].id, 0),
      child: const Scaffold(
        body: HomeBody(),
      ),
    );
  }
}
  
