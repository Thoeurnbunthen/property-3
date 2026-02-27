import 'package:flutter/material.dart';

class PropertyModel {
  final String name;
  final String location;
  final String price;
  final double rating;
  final int beds;
  final int baths;
  final int sqft;
  final Color color;
  final bool isPopular;

  const PropertyModel({
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.color,
    this.isPopular = false,
  });
}

// Dummy data
const List<PropertyModel> dummyProperties = [
  PropertyModel(
    name: 'Opera House Villa',
    location: 'Downtown, NYC',
    price: '\$99,800',
    rating: 4.9,
    beds: 5,
    baths: 3,
    sqft: 2050,
    color: Color(0xFF4A90D9),
    isPopular: true,
  ),
  PropertyModel(
    name: 'Sunset Ridge',
    location: 'Beverly Hills, LA',
    price: '\$145,000',
    rating: 4.8,
    beds: 4,
    baths: 3,
    sqft: 1800,
    color: Color(0xFFE8845A),
    isPopular: true,
  ),
  PropertyModel(
    name: 'Green Valley',
    location: 'Austin, TX',
    price: '\$78,500',
    rating: 4.7,
    beds: 3,
    baths: 2,
    sqft: 1500,
    color: Color(0xFF5CB85C),
    isPopular: true,
  ),
  PropertyModel(
    name: 'Modern Loft 21',
    location: 'Chicago, IL',
    price: '\$62,000',
    rating: 4.5,
    beds: 2,
    baths: 1,
    sqft: 980,
    color: Color(0xFF9B59B6),
    isPopular: false,
  ),
  PropertyModel(
    name: 'Harbor View',
    location: 'Seattle, WA',
    price: '\$115,000',
    rating: 4.6,
    beds: 4,
    baths: 2,
    sqft: 2200,
    color: Color(0xFF1ABC9C),
    isPopular: false,
  ),
  PropertyModel(
    name: 'Garden Cottage',
    location: 'Portland, OR',
    price: '\$55,000',
    rating: 4.4,
    beds: 3,
    baths: 2,
    sqft: 1200,
    color: Color(0xFFE74C3C),
    isPopular: false,
  ),
  PropertyModel(
    name: 'Sky Penthouse',
    location: 'Miami, FL',
    price: '\$220,000',
    rating: 5.0,
    beds: 6,
    baths: 4,
    sqft: 3500,
    color: Color(0xFF3498DB),
    isPopular: false,
  ),
];
