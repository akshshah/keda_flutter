import 'package:flutter/material.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_image.dart';
import '../../explore_module/models/product_model.dart';

class MyProductWidget extends StatelessWidget {
  const MyProductWidget({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: FadeInImage(
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 100),
                  placeholder: AssetImage(AppImage.itemPlaceholder,),
                  imageErrorBuilder: (ctx, error, stacktrace) {
                    return Image.asset( AppImage.itemPlaceholder, fit: BoxFit.cover, height: 130, width: 130,);
                  },
                  image: NetworkImage(product.productMedias?.first.mediaPath ?? "",),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.categoryName ?? "", style: UITextStyle.semiBoldItalicTextStyle(color: AppColor.dark_sky_blue)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(product.title ?? "", style: UITextStyle.semiBoldTextStyle(),),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("\$ ${product.price}/hr", style: UITextStyle.semiBoldTextStyle(color: AppColor.price_color),),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Project Status :", style: UITextStyle.semiBoldTextStyle(),),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColor.status_active,
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          child: const Text("Active", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
