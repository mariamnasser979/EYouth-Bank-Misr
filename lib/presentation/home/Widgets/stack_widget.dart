import 'package:bank_misr/Data/models/Profile.dart';
import 'package:bank_misr/presentation/home/home_view.dart';
import 'package:bank_misr/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:bank_misr/presentation/resources/color_manager.dart';
import 'package:bank_misr/presentation/resources/styles_manager.dart';
import 'package:bank_misr/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
class StackWidget extends StatelessWidget {
  Profile profile;
  StackWidget(this.profile);
  @override
  Widget build(BuildContext context) {
    var screensize=MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 1/825 * screensize.height * 200 ,
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(AppSize.s18),bottomLeft:Radius.circular(AppSize.s18))
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 1/825 * screensize.height * 25,),
                 Center(child: Text( profile.fullname.split(" ").length>1?(profile.fullname.split(" ")[0]+" "+profile.fullname.split(" ")[1]):profile.fullname,style: getMediumStyle(fontSize:20,color: ColorManager.white),)),
                 Center(child: Text( AppStrings.setyourGoalsLearnEarn.tr(),style: getMediumStyle(fontSize:15,color: ColorManager.white),)),
                SizedBox(height: 1/825 * screensize.height * 38,),
              //  Text(AppStrings.Balance.tr(),style: getMediumStyle(fontSize: 21,color: ColorManager.white)),
                SizedBox(height: 6.0)
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left:130,top: 135,right: 130),
          child: Container(
            height: 140 ,
            width: 140 ,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color:Colors.grey),
                borderRadius: BorderRadius.circular(80)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height:  125 ,
                width: 125 ,
                decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(80)
                ),
                child: Center(
                    child :Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(profile.balance.toString(),style: getBoldtStyle(fontSize:40,color: ColorManager.primary),),
                        Text(AppStrings.EGP.tr(),style: getBoldtStyle(fontSize: 20,color: ColorManager.primary),),

                      ],
                    )
                ),

              ),
            ),

          ),
        ),
      ],
    );
  }
}
