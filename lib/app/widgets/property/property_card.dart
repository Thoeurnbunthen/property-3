import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/property_model.dart';
import '../../../core/constants/app_color.dart';
import '../../../routes/app_routes.dart';
import '../../providers/favorite_provider.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onTap;

  const PropertyCard({super.key, required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final isFav = favoriteProvider.isFavorite(property);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.detail,
          arguments: property, // ← sends PropertyModel to detail screen
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
            // Image placeholder
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
                    // Name + bookmark
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
                        GestureDetector(
                          onTap: () =>
                              favoriteProvider.toggleFavorite(property),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : AppColors.grey,
                            size: 20,
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

                    // Beds + Baths chips
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
