import 'package:sharethought/core/base_state/base_state.dart';

class SignUpSuccessState extends SuccessState{}

class SignUpErrorState extends ErrorState{
  final String? errorText; 
  SignUpErrorState(this.errorText);
}