import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../authentication/widgets/custom_text_form_field.dart';
import '../../home/widgets/evenItem.dart';
import '../cubit/favourite_cubit.dart';
class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavorites(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Favourite Events"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorsManager.blue),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            // 1. Search Bar
            Padding(
              padding: REdgeInsets.all(16.0),
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                buildWhen: (previous, current) => false,
                builder: (context, state) {
                  return CustomTextFormField(
                    prefixIcon: Icons.search,
                    label: "Search",
                    onChange: (query) => context.read<FavoriteCubit>().search(query),
                  );
                },
              ),
            ),

            Expanded(
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  if (state.status == FavoriteStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.filteredFavorites.isEmpty) {
                    return Center(
                      child: Text(
                        state.searchQuery.isEmpty ? "No favourite events" : "No results found",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: state.filteredFavorites.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: EventCard(event: state.filteredFavorites[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}