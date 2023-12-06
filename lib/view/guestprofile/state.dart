import 'package:sharethought/core/base_state/base_state.dart';
import 'package:sharethought/core/controllers/auth/model/usermodel.dart';

class GuestSuccessState extends SuccessState{
  final UserModel GuestUserModel; 
  GuestSuccessState(this.GuestUserModel);
}
class GuestErrorState extends ErrorState{
  final String error; 
  GuestErrorState(this.error);
}