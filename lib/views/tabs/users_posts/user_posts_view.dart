import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clone/state/posts/providers/user_posts_providers.dart';
import 'package:insta_clone/views/components/animations/empty_contents_with_text_animations_view.dart';
import 'package:insta_clone/views/components/animations/error_animation_view.dart';
import 'package:insta_clone/views/components/animations/loading_animation_view.dart';
import 'package:insta_clone/views/components/post/posts_grid_view.dart';
import 'package:insta_clone/views/constants/strings.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationsView(
              text: Strings.youHaveNoPosts,
            );
          } else {
            return PostsGridView(posts: posts);
          }
        },
        error: (error, stackTrace) {
          return ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
      onRefresh: () {
        ref.refresh(userPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
    );
  }
}
