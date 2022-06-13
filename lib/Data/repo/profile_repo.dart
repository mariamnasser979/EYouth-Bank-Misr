import 'dart:convert';

import '../models/Profile.dart';
import '../web_services/profile_services.dart';

class ProfileRepo {
  final ProfileServices _ProfileServices;

  ProfileRepo(this._ProfileServices);

  Future<Profile> GetProfile(token) async {
    var body = await _ProfileServices.GetProfile(token);
    var jsonresponse = json.decode(body);
    var list = jsonresponse["data"];
    return Profile.fromJson(list);
  }
}