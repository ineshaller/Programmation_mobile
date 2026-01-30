import 'package:flutter/material.dart';
import 'package:formation_flutter/res/app_colors.dart';

class ProductPage extends StatelessWidget {
  final String productName;
  final String brandName;

  const ProductPage({
    Key? key,
    required this.productName,
    required this.brandName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=1310&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 170,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        brandName,
                        style: TextStyle(fontSize: 18, color: AppColors.grey2),
                      ),
                      const SizedBox(height: 20),
                      InfoVentes(
                        label: 'Quantité',
                        value: '200g (égoutté : 130g)',
                      ),
                      InfoVentes(
                        label: 'Vendu',
                        value: 'France',
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoVentes extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const InfoVentes({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 16, color: AppColors.grey3)),
            Text(value, style: TextStyle(fontSize: 16, color: AppColors.blue)),
          ],
        ),
        if (showDivider) SizedBox(height: 10),
        if (showDivider) Divider(color: AppColors.grey2),
        if (showDivider) SizedBox(height: 10),
      ],
    );
  }
}
