import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../data/models/property_model.dart';

class DetailPropertyScreen extends StatefulWidget {
  const DetailPropertyScreen({super.key});

  @override
  State<DetailPropertyScreen> createState() => _DetailPropertyScreenState();
}

class _DetailPropertyScreenState extends State<DetailPropertyScreen> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    // ── Receive data from Navigator ──
    final property =
        ModalRoute.of(context)!.settings.arguments as PropertyModel;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Scrollable Content ──
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image
                _HeroSection(
                  property: property,
                  isSaved: isSaved,
                  onSavedToggle: () => setState(() => isSaved = !isSaved),
                  onBack: () => Navigator.pop(context),
                ),

                // White card content
                Transform.translate(
                  offset: const Offset(0, -24),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Special offer badge
                        _SpecialOfferBadge(price: property.price),
                        const SizedBox(height: 14),

                        // Title + Rating
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    property.name,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 13,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        property.location,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            _RatingBadge(rating: property.rating),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Property chips
                        _PropertyChips(property: property),
                        const SizedBox(height: 24),

                        Divider(color: Colors.grey[100], thickness: 1.5),
                        const SizedBox(height: 20),

                        // Description
                        const _SectionTitle(title: 'Description'),
                        const SizedBox(height: 10),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur adipiscing elit. '
                          'Ut id massa mi. Aliquam in hendrerit urna. Pellentesque '
                          'sit amet sapien fringilla, mattis ligula consectetur, '
                          'ultrices mauris.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.7,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Gallery
                        const _SectionTitle(title: 'Gallery'),
                        const SizedBox(height: 14),
                        _GallerySection(color: property.color),
                        const SizedBox(height: 24),

                        // Location
                        const _SectionTitle(title: 'Location'),
                        const SizedBox(height: 14),
                        _MapPlaceholder(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Bar ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomBar(price: property.price),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HERO SECTION
// ─────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final PropertyModel property;
  final bool isSaved;
  final VoidCallback onSavedToggle;
  final VoidCallback onBack;

  const _HeroSection({
    required this.property,
    required this.isSaved,
    required this.onSavedToggle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          // Background gradient using property color
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [property.color.withOpacity(0.7), property.color],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.home_work_rounded,
                size: 130,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),

          // Bottom fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.25), Colors.transparent],
                ),
              ),
            ),
          ),

          // Top nav buttons
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircleButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: onBack,
                ),
                Row(
                  children: [
                    _CircleButton(
                      icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                      onTap: onSavedToggle,
                    ),
                    const SizedBox(width: 10),
                    _CircleButton(icon: Icons.share_outlined, onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CIRCLE BUTTON
// ─────────────────────────────────────────────
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SPECIAL OFFER BADGE
// ─────────────────────────────────────────────
class _SpecialOfferBadge extends StatelessWidget {
  final String price;

  const _SpecialOfferBadge({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🏷️ Special offer  ',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            '+40%  ',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF43A047),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// RATING BADGE
// ─────────────────────────────────────────────
class _RatingBadge extends StatelessWidget {
  final double rating;

  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFEE58)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            '$rating',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PROPERTY CHIPS
// ─────────────────────────────────────────────
class _PropertyChips extends StatelessWidget {
  final PropertyModel property;

  const _PropertyChips({required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoChip(icon: Icons.bed_outlined, label: '${property.beds} Bedrooms'),
        const SizedBox(width: 12),
        _InfoChip(
          icon: Icons.square_foot_rounded,
          label: '${property.sqft} sqft',
        ),
        const SizedBox(width: 12),
        _InfoChip(
          icon: Icons.bathtub_outlined,
          label: '${property.baths} Bath',
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.grey),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// SECTION TITLE
// ─────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: -0.2,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GALLERY SECTION
// ─────────────────────────────────────────────
class _GallerySection extends StatelessWidget {
  final Color color;

  const _GallerySection({required this.color});

  @override
  Widget build(BuildContext context) {
    final colors = [
      color.withOpacity(0.4),
      color.withOpacity(0.6),
      color.withOpacity(0.8),
      color,
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: colors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Container(
            width: 90,
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.home_work_rounded,
              color: Colors.white.withOpacity(0.6),
              size: 30,
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MAP PLACEHOLDER
// ─────────────────────────────────────────────
class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EFF5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 36, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              'Map View',
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BOTTOM BAR
// ─────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  final String price;

  const _BottomBar({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total amount',
                  style: TextStyle(fontSize: 12, color: AppColors.grey),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
