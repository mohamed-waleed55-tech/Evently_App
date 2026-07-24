import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../authentication/widgets/custom_text_form_field.dart';
import '../../home/widgets/evenItem.dart';
import '../cubit/favourite_cubit.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavorites(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Favourite Events",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.colorScheme.primary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            // 1. Animated Search Bar Section
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                buildWhen: (previous, current) => false,
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CustomTextFormField(
                      prefixIcon: Icons.search_rounded,
                      label: "Search your favourites...",
                      onChange: (query) =>
                          context.read<FavoriteCubit>().search(query),
                    ),
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

                  // حالة القائمة الفارغة
                  if (state.filteredFavorites.isEmpty) {
                    return _EmptyStateWidget(
                      message: state.searchQuery.isEmpty
                          ? "No favourite events yet"
                          : "No matching events found",
                    );
                  }

                  return ListView.builder(
                    padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.filteredFavorites.length,
                    itemBuilder: (context, index) {
                      final event = state.filteredFavorites[index];

                      return _StaggeredItemWrapper(
                        key: ValueKey(event.id),
                        index: index,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: EventCard(event: event),
                        ),
                      );
                    },
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

class _StaggeredItemWrapper extends StatefulWidget {
  final Widget child;
  final int index;

  const _StaggeredItemWrapper({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<_StaggeredItemWrapper> createState() => _StaggeredItemWrapperState();
}

class _StaggeredItemWrapperState extends State<_StaggeredItemWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25), 
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(Duration(milliseconds: widget.index * 60), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  final String message;

  const _EmptyStateWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.8, end: 1.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: REdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 64.r,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.hintColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}