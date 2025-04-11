import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/model/product_model.dart';
import 'package:project/widget/quantity_selector.dart';

class CartScreen extends StatefulWidget {
  final ProductModel? product;
  const CartScreen({super.key, required this.product});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff84fab0), Color(0xff8fd3f4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.w),
                Text(
                  'My Cart',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.w),
                _buildProductCard(),
                SizedBox(height: 20.w),
                _buildTotalPrice(),
                SizedBox(height: 20.w),
                _buildCheckoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      width: double.infinity,
      height: 150.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              widget.product?.imageUrl != null
                  ? Image.asset(
                    widget.product!.imageUrl ?? 'assets/images/bgnike.png',
                    width: 80.w,
                    height: 80.h,
                  )
                  : SizedBox(width: 80.w, height: 80.h),

              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product?.title ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  Text(
                    widget.product?.price.toString() ?? '',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  QuantitySelector(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Container(
      width: double.infinity,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Subtotal: \$${widget.product?.price?.toStringAsFixed(2) ?? '0.00'}',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      width: double.infinity,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
