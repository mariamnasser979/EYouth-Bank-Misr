import 'dart:convert';

import '../models/goal.dart';
import '../web_services/goal_services.dart';

class GoalRepo
{
  final GoalServices _goalServices;

  GoalRepo(this._goalServices);

  Future<List<Goal>> GetAllGoals(Url)async
  {
    var body = await _goalServices.GetAllGoals(Url);
    var jsonresponse =json.decode(body) ;
    var list=jsonresponse["data"] as List<dynamic>;
    return list.map((e) => Goal.fromJson(e)).toList();
  }
}