import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/photo_cubit.dart';
import '../cubit/photo_state.dart';
import '../cubit/favorite_cubit.dart';
import '../cubit/favorite_state.dart';
import '../cubit/upload_cubit.dart';
import '../theme/app_theme.dart';
import '../widgets/photo_card.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _crossAxisCountFor(double width) {
    if (width >= 1100) return 5;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => context.read<PhotoCubit>().refreshPhotos(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppTheme.appBarGradient,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Photo Gallery Camera',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Jelajahi & abadikan momenmu',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: _buildSearchBar(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: _buildStatisticsCard(context),
              ),
            ),
            BlocBuilder<PhotoCubit, PhotoState>(
              builder: (context, state) {
                if (state is PhotoLoading || state is PhotoInitial) {
                  return const SliverFillRemaining(
                    hasScrollBody: true,
                    child: LoadingShimmer(),
                  );
                }

                if (state is PhotoError) {
                  return SliverFillRemaining(
                    child: ErrorStateView(
                      message: state.message,
                      onRetry: () => context.read<PhotoCubit>().fetchPhotos(),
                    ),
                  );
                }

                if (state is PhotoLoaded) {
                  if (state.filteredPhotos.isEmpty) {
                    return const SliverFillRemaining(
                      child: EmptyStateView(
                        icon: Icons.search_off_rounded,
                        title: 'Tidak Ditemukan',
                        message:
                            'Tidak ada foto yang cocok dengan pencarian Anda',
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossAxisCountFor(
                            MediaQuery.of(context).size.width),
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.78,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final photo = state.filteredPhotos[index];
                          return PhotoCard(
                            photo: photo,
                            onTap: () =>
                                context.push('/detail', extra: photo),
                          );
                        },
                        childCount: state.filteredPhotos.length,
                      ),
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          context.read<PhotoCubit>().searchPhotos(value);
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Cari nama fotografer...',
          prefixIcon: Icon(Icons.search_rounded, color: scheme.primary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () {
                    _searchController.clear();
                    context.read<PhotoCubit>().searchPhotos('');
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    final photoState = context.watch<PhotoCubit>().state;
    final favoriteState = context.watch<FavoriteCubit>().state;
    final uploadState = context.watch<UploadCubit>().state;

    final totalPhotos =
        photoState is PhotoLoaded ? photoState.allPhotos.length : 0;
    final favoriteCount =
        favoriteState is FavoriteLoaded ? favoriteState.favorites.length : 0;
    final uploadedCount =
        uploadState.history.where((item) => item.success).length;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _statItem(context, Icons.photo_library_rounded, '$totalPhotos',
              'Total Photos'),
          _statDivider(),
          _statItem(context, Icons.favorite_rounded, '$favoriteCount',
              'Favorites'),
          _statDivider(),
          _statItem(context, Icons.cloud_upload_rounded, '$uploadedCount',
              'Uploaded'),
        ],
      ),
    );
  }

  Widget _statDivider() {
    return Container(
      height: 36,
      width: 1,
      color: Colors.grey.withValues(alpha: 0.25),
    );
  }

  Widget _statItem(
      BuildContext context, IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
