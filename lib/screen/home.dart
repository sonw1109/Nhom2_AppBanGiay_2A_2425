import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/screen/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Running',
    'Lifestyle',
    'Sports',
    'Street',
    'Vintage',
    'Casual',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'title': 'Nike Shoes Sneakers',
      'price': 199.99,
      'image': 'assets/images/1.png',
      'gradient': [Color(0xff5EFC8D), Color(0xff61FC5E)],
    },
    {
      'title': 'Nike Kyrie 1 Letterman',
      'price': 160.99,
      'image': 'assets/images/2.png',
      'gradient': [Color(0xff90CAF9), Color(0xff5ED6FC)],
    },
    {
      'title': 'Nike Kyrie 1 Letterman',
      'price': 160.99,
      'image': 'assets/images/3.png',
      'gradient': [Color(0xffF9BC90), Color(0xffFC7A5E)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBoxSearch(),
              SizedBox(height: 20.w),
              const Text(
                "New Collection",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.w),
              _buildCategoryFilter(),
              SizedBox(height: 30.w),
              _buildProductGrid(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildBoxSearch() {
    return Padding(
      padding: EdgeInsets.only(top: 20.w),
      child: Container(
        height: 270.w,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff90CAF9),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
                  Image.asset('assets/images/nike.png'),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/Avatar.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.w),
              Text(
                "Morning Michel",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1D1D1D),
                ),
              ),
              Text("Experience Fashion with Our Shoe Lineup"),
              SizedBox(height: 50.w),
              SearchBar(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16),
                ),
                leading: Text(
                  "Search",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: [Icon(Icons.search)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 40.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = _categories[index];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color:
                    _selectedCategory == _categories[index]
                        ? Colors.black
                        : Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black12, width: 1.0),
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color:
                        _selectedCategory == _categories[index]
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return SizedBox(
      height: 220.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProductDetailScreen(
                          title: item['title'] as String,
                          price: item['price'] as double,
                          imageUrl: item['image'] as String,
                          color: item['gradient'] as List<Color>,
                        ),
                  ),
                );
              },
              child: _buildProductCard(
                title: item['title'] as String,
                price: item['price'] as double,
                imageUrl: item['image'] as String,
                color: item['gradient'] as List<Color>,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required double price,
    required String imageUrl,
    required List<Color> color,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Card background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: color,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          width: 150.w,
          height: 170.w,
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_shopping_cart,
                      size: 16.w,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Heart icon
        Positioned(
          top: 40.w,
          right: 1.w,
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite, size: 18.w, color: Colors.red),
            ),
          ),
        ),

        // Shoe image
        Positioned(
          top: -5.w,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 140.w,
            child: Image.asset(imageUrl, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}
