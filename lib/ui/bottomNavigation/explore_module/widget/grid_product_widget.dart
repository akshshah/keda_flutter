import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_image.dart';
import '../../../../utils/ui_text_style.dart';
import '../models/product_model.dart';

class GridProductWidget extends StatelessWidget {
  const GridProductWidget({Key? key, required this.product, required this.isRecent}) : super(key: key);

  final Product product;
  final bool isRecent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: FadeInImage(
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 100),
                    placeholder: AssetImage(AppImage.itemPlaceholder,),
                    image: NetworkImage(product.productMedias?.first.mediaPath ?? "",),
                    imageErrorBuilder: (ctx, error, stacktrace) {
                      return Image.asset( AppImage.itemPlaceholder, fit: BoxFit.cover, height: 150, width: double.infinity,);
                    },
                  ),
                ),
                if (isRecent)
                  Positioned(
                    top: -3.5,
                    right: -3.5,
                    child: Image.asset(
                      AppImage.closeButton,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            product.categoryName ?? "",
                            style: UITextStyle.semiBoldItalicTextStyle(overflow: TextOverflow.ellipsis, color: AppColor.dark_sky_blue)
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          print("Saved");
                        },
                        icon: Icon(product.isFavorite == 1 ? Icons.bookmark : Icons.bookmark_border, color: AppColor.colorPrimary,),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text(
                      product.title ?? "",
                      maxLines: 2,
                      style: UITextStyle.semiBoldTextStyle()),
                  const SizedBox(height: 5,),
                  if(product.rentDurationUnit == "hours" || product.rentDurationUnit == "both")
                    Text("\$ ${product.price}/hr",
                      maxLines: 2,
                      style: UITextStyle.semiBoldTextStyle(color: AppColor.price_color),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 3,),
                  if(product.rentDurationUnit == "days" || product.rentDurationUnit == "both")
                    Text("\$ ${product.pricePerDay}/day",
                      maxLines: 2,
                      style: UITextStyle.semiBoldTextStyle(color: AppColor.price_color),
                      textAlign: TextAlign.left,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}