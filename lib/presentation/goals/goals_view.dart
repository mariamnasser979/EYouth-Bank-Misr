import 'dart:io';

import 'package:bank_misr/Data/web_services/goal_services/goalChecked_services.dart';
import 'package:bank_misr/app/app_prefs.dart';
import 'package:bank_misr/presentation/addTasksGoals/addGoal/add_goal.dart';
import 'package:bank_misr/presentation/addTasksGoals/edit_goal/edit_goal.dart';
import 'package:http/http.dart' as http;
import 'package:bank_misr/Data/models/goal.dart';
import 'package:bank_misr/Data/repo/goal_repo.dart';

import 'package:bank_misr/presentation/resources/assets_manager.dart';
import 'package:bank_misr/presentation/resources/font_manager.dart';
import 'package:bank_misr/presentation/resources/routes_manager.dart';
import 'package:bank_misr/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bank_misr/presentation/resources/styles_manager.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../Data/web_services/goal_services/goalConfirmDelete_services.dart';
import '../../Data/web_services/goal_services/goalConfirmEdit_services.dart';
import '../../Data/web_services/goal_services/goal_services.dart';
import '../bottomBar/bottomBar.dart';
import '../home/home_view.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';



class Goalsview extends StatefulWidget {
  @override
  State<Goalsview> createState() => _GoalViewState();
}


class _GoalViewState extends State<Goalsview> {
  goalConfirmChecked checked=goalConfirmChecked();
  AppPreferences appPreferences = AppPreferences();
  confirmDeleteServices delete= confirmDeleteServices();
  confirmEditServices edit= confirmEditServices();
  var token;
 late List<Goal> goals=[];
@override
   void initState() {
    // TODO: implement initState
    super.initState();
     Load();

   }
   Load()async
   {
    goals = await GoalRepo(GoalServices()).GetAllGoals(await appPreferences.getLocalToken());
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    token=sharedPreferences.getString("token");
    setState(() {

    });
   }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.Goals.tr()),  actions: [
        Padding(
          padding: const EdgeInsets.only(right:10.0),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                ImageAssets.profilePhoto,
                fit: BoxFit.fitWidth,
                width: 45,
              ),
              maxRadius: 34),
        )
      ],),
      // appBar: AppBar(
      //   title: Text(
      //     "Goals",
      //     style: getBoldtStyle(fontSize:FontSize.s20,color: ColorManager.white)
      //     ,)
      //   ,
      //   ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.primary,
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, Routes.addGoalViewRoute);
        },),
      body: Column(
        children: [
          Container(
            child: ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              children: [
                Image.asset(
                  'assets/images/goals.png',
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/images/multitask.gif',
                  fit: BoxFit.cover,
                ),
              ],
              onPageChanged: (value) {
                print('Page changed: $value');
              },
              isLoop: true,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(height: 160 ,
                      width:  230,
                      child:Lottie.asset(ImageAssets.GoalPhoto)),
                ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  goals.length == 0? Center(child: Text(AppStrings.thereIsNoGoals.tr())): 
                    ListView.separated(

                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildgoal(goals[index],index),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 12.0,
                    ),
                    itemCount:goals.length,
                  ),
                ],
              ),
            ),
          )
        ],
      ),


    );


  }
  Widget buildgoal(Goal goal, int index) =>

      Padding(

        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
              border:Border.all(color:ColorManager.grey,width: 1.5),
              borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20), )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: Text((index+1).toString(),
                        style: getBoldtStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
              Container(
                      width: 190,
                      child: Text(
                        goal.title,
                        style: getBoldtStyle(
                          fontSize:FontSize.s16,
                          color:ColorManager.black,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                      ),
                    ),
              IconButton(icon: (Icon(Icons.check_circle_outline,)),iconSize: FontSize.s20,color:ColorManager.green, onPressed: () {
                          setState(() {

                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                scrollable: true,
                                backgroundColor: ColorManager.primary,
                                title:  Center(
                                  child: Text("congratulation",
                                    style: getBoldtStyle(fontSize:18,color: ColorManager.white),),
                                ),
                                content: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Lottie.asset("assets/images/7455-loading1.json",height: 145,width:250, ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: 190,
                                            child: Text("Did you achieve it ",
                                              style: getSemiBoldStyle(fontSize:14,color: ColorManager.white),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Center(
                                    child: Container(
                                      height:30 ,
                                      width:100 ,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ColorManager.darkPrimary,
                                      ),
                                      child: TextButton(
                                        child: Text('Ok',style:getRegularStyle(color: ColorManager.white) ,),
                                        onPressed: ()
                                         {checked.Checked(token, goal.id);
                                           print(goal.id);
                                          Navigator.pushReplacementNamed(context, Routes.goals);

                                        },
                                        // async {
                                        //   var response=await  http.delete(Uri.parse('http://ec2-54-198-82-67.compute-1.amazonaws.com:5000/goal/delete/${goal.id}'),
                                        //       headers: <String,String>{"Content-Type": "application/json",
                                        //         HttpHeaders.authorizationHeader:"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MmE1YjMzMDQ2ZGNiZjBkZWVjYzQzNmUiLCJpYXQiOjE2NTUwMjcwODJ9.XdHxFQGF4NGEQik_2V-Qbw5nZaERO8J7KIALYBBwJj8"});
                                        //   print(response.statusCode);
                                        //
                                        //
                                        //   Navigator.of(context).pop();
                                        //   currentindex=2;
                                        //   Navigator.pushReplacementNamed(context, Routes.homeLayout);
                                        // },
                                      ),
                                    ),
                                  )

                                ],
                              );

                            });

                          });
                        },
                        ),
              IconButton(icon: (Icon(Icons.edit_rounded)),color:ColorManager.black, onPressed: () {
                          edit.confirmEdit(goal.id,goal.title,goal.description,context);
                        },

                        ),
              IconButton(icon: (Icon(Icons.delete_rounded)),color:ColorManager.error, onPressed: () async {
                          // confirmDelete(goal.id);
                          delete.confirmDelete(goal.id, context);

                        },

                        ),

            ],

          ),

        ),
      );

 // void confirmDelete(String id) {
 //   showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
 //     title: Text("Delete"),
 //     content: Text(" Are you sure !?"),
 //     actions: [
 //       FlatButton(child: Text("yes"),
 //         onPressed: () async {
 //           var response=await  http.delete(Uri.parse('http://ec2-54-198-82-67.compute-1.amazonaws.com:5000/goal/delete/$id'),
 //               headers: <String,String>{"Content-Type": "application/json",
 //                 HttpHeaders.authorizationHeader:"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MmE1YjMzMDQ2ZGNiZjBkZWVjYzQzNmUiLCJpYXQiOjE2NTUwMjcwODJ9.XdHxFQGF4NGEQik_2V-Qbw5nZaERO8J7KIALYBBwJj8"});
 //           print(response.statusCode);
 //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Goalsview()));
 //
 //
 //         }, ),
 //       FlatButton(onPressed: (){
 //         Navigator.pop(context);
 //
 //       }, child: Text("no")),
 //     ],
 //
 //   )
 //   );
 //
 // }
 // void confirmEdit(String Id,String Title, String Description) {
 //   Navigator.push(context, MaterialPageRoute(builder: (context)=> EditGoal(Id,Title,Description)));
 // }

 }


// Widget buildtask(GoalsList goals) =>
//     Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//
//           border:Border.all(color:ColorManager.grey,width: 1.5),
//           borderRadius: BorderRadius.only(topLeft:Radius.circular(15),bottomRight:Radius.circular(15), )
//         ),
//         child: Row(
//           children: [
//
//             Expanded(
//
//               child: Row(
//
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(
//                       '${goals.number}'+"-",
//                       style: getBoldtStyle(
//                         fontSize: FontSize.s16,
//                         color:ColorManager.black,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Container(
//                     width: 170,
//                     child: Text(
//
//                       '${goals.name}',
//                       style: getBoldtStyle(
//                         fontSize:FontSize.s16,
//                         color: Colors.black,
//
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//
//                   Row(
//
//
//                     children: [
//
//                       IconButton(icon: (Icon(Icons.check_circle_outline,)),color:ColorManager.green, onPressed: () {
//
//                       },
//
//                       ),
//                       IconButton(icon: (Icon(Icons.edit_rounded)),color:ColorManager.black, onPressed: () {  },
//
//                       ),
//                       IconButton(icon: (Icon(Icons.delete_rounded)),color:ColorManager.error, onPressed: () {  },
//
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

