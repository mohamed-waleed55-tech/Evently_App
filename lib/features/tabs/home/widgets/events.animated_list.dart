
import 'package:evently/features/tabs/home/cubit/home_cubit.dart';
import 'package:evently/features/tabs/home/widgets/animated_event_card_wrapper.dart';
import 'package:evently/features/tabs/home/widgets/evenItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsAnimatedList extends StatelessWidget {
  const EventsAnimatedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return SliverList.separated(
            itemCount: 4,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (context, index) => const EventCardSkeleton(),
          );
        }

        if (state.status == HomeStatus.failure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 60.r,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    state.errorMessage ?? "An unexpected error occurred.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }

        if (state.events.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy_rounded,
                    size: 64.r,
                    color: Theme.of(context).disabledColor,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "No events found in this category",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverList.separated(
          itemCount: state.events.length,
          separatorBuilder: (_, _) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final event = state.events[index];

            return AnimatedEventCardWrapper(
              key: ValueKey("${event.id}_$index"),
              index: index,
              child: EventCard(event: event),
            );
          },
        );
      },
    );
  }
}