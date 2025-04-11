import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/model/product_model.dart';
import 'package:project/screen/cart.dart';
import 'package:project/widget/color.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final double price;
  final String imageUrl;
  final List<Color> color;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.color,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = '38.5';

  final List<String> _listSize = [
    '38.5',
    '39',
    '39.5',
    '40',
    '40.5',
    '41',
    '41.5',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.color,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 100.w),
              child: Image.asset('assets/images/bgnike.png'),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 100.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(widget.imageUrl, fit: BoxFit.contain),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 100.w),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Men’s shoes",
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ],
            ),
            Positioned(
              bottom: 180.w,
              left: 20.w,
              right: 20.w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "\$${widget.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Size",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10.w),
                          ColorCirlce(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40.w,
              left: 20.w,
              right: 20.w,
              child: Column(
                children: [
                  _buildListSize(),
                  SizedBox(height: 20.w),
                  _buildShoppingCart(widget.color.first),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSize() {
    return Padding(
      padding: EdgeInsets.only(top: 0.w),
      child: SizedBox(
        height: 40.w,
        child: ListView.builder(
          itemCount: _listSize.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = _listSize[index];
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color:
                      _selectedSize == _listSize[index]
                          ? Colors.black
                          : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Center(
                  child: Text(
                    _listSize[index],
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color:
                          _selectedSize == _listSize[index]
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShoppingCart(final Color color) {
    return ElevatedButton(
      onPressed: () {
        final product = ProductModel(
          title: widget.title,
          price: widget.price,
          imageUrl: widget.imageUrl,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen(product: product)),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 45.w),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Row(
        children: [
          Text("Add to Cart"),
          Spacer(),
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: widget.color.last,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add_shopping_cart_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
