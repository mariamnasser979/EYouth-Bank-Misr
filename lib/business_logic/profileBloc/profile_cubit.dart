import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/models/Profile.dart';
import '../../Data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  late Profile profile;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  Future<Profile>GetProfile(Url)
  async {
    profile=await profileRepo.GetProfile(Url);
    emit(ProfilesLoaded(profile));
    return profile;
  }
}
