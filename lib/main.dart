import 'package:coding_test/features/create_post/data/post_remote_data_source.dart';
import 'package:coding_test/features/create_post/domain/use_cases/create_post.dart';
import 'package:coding_test/features/create_post/presentation/screens/create_post_screen.dart';
import 'package:coding_test/features/create_post/presentation/state_management/create_post_bloc.dart';
import 'package:coding_test/features/homepage/data/homepage_remote_data_source.dart';
import 'package:coding_test/features/homepage/domain/use_cases/fetch_posts.dart';
import 'package:coding_test/features/homepage/presentation/screens/homepage_screen.dart';
import 'package:coding_test/features/homepage/presentation/state_management/homepage_bloc.dart';
import 'package:coding_test/features/homepage/presentation/state_management/homepage_event.dart';
import 'package:coding_test/features/profile/data/profile_remote_data_source.dart';
import 'package:coding_test/features/profile/domain/use_cases/fetch_profile.dart';
import 'package:coding_test/features/profile/presentation/screens/profile_screen.dart';
import 'package:coding_test/features/profile/presentation/state_management/profile_bloc.dart';
import 'package:coding_test/features/profile/presentation/state_management/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/authentication/presentation/screens/login_screen.dart';
import 'features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/use_cases/login_user.dart';
import 'features/authentication/presentation/state_management/login_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Dio and dependencies
    final dio = Dio();

    // Authentication dependencies
    final authRemoteDataSource = AuthRemoteDataSource(dio: dio);
    final authRepository =
        AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
    final loginUserUseCase = LoginUser(repository: authRepository);

    // Homepage dependencies
    final homepageRemoteDataSource = HomepageRemoteDataSource(dio: dio);
    final fetchPostsUseCase =
        FetchPosts(remoteDataSource: homepageRemoteDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(loginUser: loginUserUseCase),
        ),
        BlocProvider(
          create: (_) => HomepageBloc(fetchPosts: fetchPostsUseCase),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(
            fetchProfile: FetchProfile(
              remoteDataSource: ProfileRemoteDataSource(dio: dio),
            ),
            remoteDataSource: ProfileRemoteDataSource(dio: dio),
          )..add(FetchProfileEvent()),
        ),
        BlocProvider(
          create: (_) => CreatePostBloc(
            createPost: CreatePost(
              remoteDataSource: PostRemoteDataSource(dio: dio),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => BlocProvider.value(
                value: context.read<HomepageBloc>()..add(FetchPostsEvent()),
                child: const HomepageScreen(),
              ),
          '/profile': (context) => BlocProvider.value(
                value: context.read<ProfileBloc>(),
                child: const ProfileScreen(),
              ),
          '/create-post': (context) => BlocProvider.value(
                value: context.read<CreatePostBloc>(),
                child: CreatePostScreen(),
              ),
        },
      ),
    );
  }
}
