import 'package:bank_misr/presentation/home/home_view.dart';
import 'package:bank_misr/presentation/resources/assets_manager.dart';
import 'package:bank_misr/presentation/resources/color_manager.dart';
import 'package:bank_misr/presentation/resources/font_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bank_misr/presentation/resources/styles_manager.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lottie/lottie.dart';
class TasksList {
  var number;
   var name;
  TasksList({
    this.number,
     this.name,
  });
}

class TasksView extends StatefulWidget {
  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  List<TasksList> tasks =[
    TasksList(
      number:1,
      name:"Pray",
    ),
    TasksList(
      number:2,
      name:"Study",
    ),
    TasksList(
      number:3,
      name:"Pass the Exam",
    ),
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Tasks",
          style: getBoldtStyle(fontSize:FontSize.s20,color: ColorManager.white)
          ,)
        ,),
    body: Column(
    children: [
    Container(
      child: ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        children: [
          Image.asset(
            'assets/images/courses.gif',
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
                  child: SizedBox(height: 190 ,
                      width:  210,
                      child:Lottie.asset(ImageAssets.TaskPhoto)),
                ),
          ],
      ),
      Expanded(
      child: SingleChildScrollView(
         scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => buildtask(tasks[index]),
            separatorBuilder: (context, index) => SizedBox(
              height: 10.0,
            ),
            itemCount: tasks.length,
          ),
        ],
      ),
      ),
      )
    ],
    ),


    );


  }
  Widget buildtask(TasksList taskss) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
              border:Border.all(color:ColorManager.grey,width: 1.5),
              borderRadius: BorderRadius.only(topLeft:Radius.circular(15),bottomRight:Radius.circular(15), )
          ),
          child: Row(
            children: [

              Expanded(

                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(

                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${taskss.number}',
                        style: getBoldtStyle(
                          fontSize: FontSize.s16,
                          color:ColorManager.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 175,
                      child: Text(

                        '${taskss.name}',
                        style: getBoldtStyle(
                          fontSize:FontSize.s16,
                          color: Colors.black,

                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Row(

                      children: [
                        IconButton(icon: (Icon(Icons.check_circle_outline,)),iconSize: FontSize.s25,color:ColorManager.green, onPressed: () {
                        setState(() {
                          tasks.remove(taskss);
                          balance+=15;
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text("Achievement"),
                                content: Text("15 EGP  Has Been Added To Your Wallet!"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ]
                            );
                          });
                        });
                        },

                        ),
                        IconButton(icon: (Icon(Icons.edit_rounded)),color:ColorManager.yellow, onPressed: () {  },

                        ),
                        IconButton(icon: (Icon(Icons.delete_rounded)),color:ColorManager.error, onPressed: () {  },

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}



