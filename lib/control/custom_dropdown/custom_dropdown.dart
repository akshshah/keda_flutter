import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_color.dart';
import '../../utils/ui_text_style.dart';

class CustomDropDown<T> extends StatelessWidget {
  EdgeInsets? margin;
  EdgeInsets? padding;

  double width;
  double? dropDownHeight;
  double? height;
  T? selectedItem;
  List<DropdownMenuItem<T>> items;
  bool? isLabelText;
  String? labelText;
  String? hintText;
  Function onChanged;

  CustomDropDown({required this.items, this.labelText,this.hintText,this.isLabelText = true,this.dropDownHeight,this.height,required this.selectedItem, required this.onChanged, this.margin, this.padding, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: margin ?? EdgeInsets.zero,
              padding: padding ?? EdgeInsets.zero,
              height: dropDownHeight ?? 45.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.whiteColor,
                  border: Border.all(color: AppColor.dividerColor, style: BorderStyle.solid, width: 1)),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<T>(
                    hint: Text(
                      hintText ?? "", style:  UITextStyle.regularTextStyle(fontSize: 18,color:AppColor.dividerColor),
                    ),
                    icon: Icon(Icons.arrow_drop_down_sharp, color: AppColor.dividerColor, size: 24.h),
                    items: items,
                    isExpanded: true,
                    onChanged: (selectedItem) {
                      onChanged(selectedItem);
                    },
                    value: selectedItem,
                  ),
                ),
              ),
            ),
          ),
          isLabelText! ? Positioned(
            left: 14,
            top: 0,
            child: Container(
              color: AppColor.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                labelText!,
                style: UITextStyle.regularTextStyle(fontSize: 10),
              ),
            ),
          ):Container(),
        ],
      ),
    );
  }
}
