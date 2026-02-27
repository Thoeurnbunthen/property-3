import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_color.dart';
import '../../../data/models/property_model.dart';
import '../../../routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/category_chips.dart';
import '../../widgets/common/bottom_navbar.dart';
import '../../widgets/property/popular_card.dart';
import '../../widgets/property/property_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  int _selectedNav = 0;

  final List<String> categories = [
    'All',
    'House',
    'Apartment',
    'Villa',
    'Condo',
  ];

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final popular = dummyProperties.where((p) => p.isPopular).toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      bottomNavigationBar: BottomNavBar(
        selected: _selectedNav,
        onTap: (i) => setState(() => _selectedNav = i),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Header ──
            SliverToBoxAdapter(
              child: _buildHeader(auth.currentUser?.name ?? 'User'),
            ),

            // ── Search Bar ──
            SliverToBoxAdapter(child: _buildSearchBar()),

            // ── Most Popular Title ──
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Most Popular', onSeeAll: () {}),
            ),

            // ── Popular Horizontal List ──
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: popular.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return PopularCard(property: popular[index]);
                  },
                ),
              ),
            ),

            // ── Category Chips ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CategoryChips(
                  categories: categories,
                  selected: _selectedCategory,
                  onSelect: (i) => setState(() => _selectedCategory = i),
                ),
              ),
            ),

            // ── All Properties Title ──
            SliverToBoxAdapter(
              child: SectionHeader(title: 'All Properties', onSeeAll: () {}),
            ),

            // ── All Properties List ──
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => PropertyCard(
                  property: dummyProperties[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.detail,
                      arguments: dummyProperties[index],
                    );
                  },
                ),
                childCount: dummyProperties.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  // ── Header Widget ──
  Widget _buildHeader(String userName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Morning 👋',
                style: TextStyle(fontSize: 13, color: AppColors.grey),
              ),
              const SizedBox(height: 2),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Notification
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Avatar
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Search Bar Widget ──
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.search_rounded,
                    color: AppColors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Search property...',
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Filter button
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
