import 'package:sharethought/core/base_state/base_state.dart';
import 'package:sharethought/core/controllers/auth/model/usermodel.dart';

class ProfileSuccessState extends SuccessState{
  ProfileSuccessState();
}
class ProfileErrorState extends ErrorState{
  final String error; 
  ProfileErrorState(this.error);
}