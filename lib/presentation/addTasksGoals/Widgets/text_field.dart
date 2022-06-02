import 'package:bank_misr/presentation/resources/color_manager.dart';
import 'package:bank_misr/presentation/resources/styles_manager.dart';
import 'package:bank_misr/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container getTextField(String hintText, double height, int lines, double padding,raduis,
    TextEditingController titleTextController, Null Function(dynamic text) set,) {
  return Container(
      padding: EdgeInsets.only(left: AppPadding.p12,top: padding),
      height: height,
      width: 265.83,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(topRight:Radius.circular(raduis) ,bottomLeft: Radius.circular(raduis)),
          color: ColorManager.lightPrimary),
      child:  TextField(
        onChanged:set ,
        controller: titleTextController,
        maxLines: lines,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          hintStyle:getRegularStyle(color: ColorManager.grey1),
        ),
        style: getRegularStyle(color: ColorManager.darkGrey),
      )
  );
}
