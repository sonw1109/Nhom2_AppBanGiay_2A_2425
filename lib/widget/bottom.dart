import 'package:flutter/material.dart';
import 'package:project/model/product_model.dart';
import 'package:project/screen/cart.dart';
import 'package:project/screen/home.dart';
import 'package:project/screen/notification.dart';
import 'package:project/screen/profile.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    NotificationsScreen(),
    CartScreen(product: ProductModel()),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xffEFFFFE),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home, Icons.home_outlined, 0),
              _buildNavItem(Icons.search, Icons.search_outlined, 1),
              _buildNavItem(Icons.favorite, Icons.favorite_outline, 2),
              _buildNavItem(Icons.settings, Icons.settings_outlined, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData activeIcon, IconData inactiveIcon, int index) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? activeIcon : inactiveIcon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}
