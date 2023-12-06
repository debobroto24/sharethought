import 'package:sharethought/core/controllers/auth/model/usermodel.dart';

import '../../../core/base_state/base_state.dart';

class LoginErrorState extends ErrorState{
  final String error; 
    LoginErrorState(this.error); 
}
class LoginSuccessState extends SuccessState{
    final UserModel? usermodel; 
   LoginSuccessState(this.usermodel); 
}