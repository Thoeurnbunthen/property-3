import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_color.dart';
import '../../../data/models/property_model.dart';
import '../../../routes/app_routes.dart';
import '../../providers/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final favorites = favoriteProvider.favorites;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Favorites ❤️',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${favorites.length} properties saved',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),

                  // Clear all button
                  if (favorites.isNotEmpty)
                    GestureDetector(
                      onTap: () => _confirmClearAll(context, favoriteProvider),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEEEE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Clear all',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Content ──
            Expanded(
              child: favorites.isEmpty
                  ? _EmptyState()
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: favorites.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return _FavoriteCard(
                          property: favorites[index],
                          onRemove: () =>
                              favoriteProvider.removeFavorite(favorites[index]),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detail,
                              arguments: favorites[index],
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

  // Confirm clear all dialog
  void _confirmClearAll(BuildContext context, FavoriteProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Clear All?',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        content: const Text(
          'Are you sure you want to remove all saved properties?',
          style: TextStyle(color: AppColors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              provider.clearAll();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FAVORITE CARD
// ─────────────────────────────────────────────
class _FavoriteCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const _FavoriteCard({
    required this.property,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [property.color.withOpacity(0.6), property.color],
                ),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.home_work_rounded,
                    color: Colors.white.withOpacity(0.3),
                    size: 55,
                  ),
                  const Icon(
                    Icons.home_work_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ],
              ),
            ),

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + remove button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            property.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Remove from favorite
                        GestureDetector(
                          onTap: onRemove,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEEEE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          property.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Beds + Baths
                    Row(
                      children: [
                        _MiniChip(
                          icon: Icons.bed_outlined,
                          label: '${property.beds} Bed',
                        ),
                        const SizedBox(width: 8),
                        _MiniChip(
                          icon: Icons.bathtub_outlined,
                          label: '${property.baths} Bath',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Price + rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.accent,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${property.rating}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EMPTY STATE
// ─────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 50,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the ❤️ button on any property\nto save it here',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: AppColors.grey, height: 1.6),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MINI CHIP
// ─────────────────────────────────────────────
class _MiniChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MiniChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.grey),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
