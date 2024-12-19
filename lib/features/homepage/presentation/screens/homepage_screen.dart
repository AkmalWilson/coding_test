import 'package:coding_test/core/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coding_test/features/homepage/presentation/state_management/homepage_bloc.dart';
import 'package:coding_test/features/homepage/presentation/state_management/homepage_event.dart';
import 'package:coding_test/features/homepage/presentation/state_management/homepage_state.dart';
import 'package:coding_test/features/homepage/presentation/widgets/post_list.dart';
import 'package:coding_test/features/homepage/presentation/widgets/navigation_buttons.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homepage',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const NavigationButtons(),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<HomepageBloc, HomepageState>(
                builder: (context, state) {
                  if (state is HomepageLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomepageLoaded) {
                    return PostList(posts: state.posts);
                  } else if (state is HomepageError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(
                      child: Text('Press refresh to load posts.'));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomepageBloc>().add(FetchPostsEvent());
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}
