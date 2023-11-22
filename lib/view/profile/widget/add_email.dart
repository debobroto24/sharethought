import 'package:flutter/Material.dart';
import 'package:sharethought/common_widget/full_width_button.dart';
import 'package:sharethought/common_widget/kinput_field.dart';
import 'package:sharethought/route/route_generator.dart';

import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/full_width_button.dart';

class AddEmail extends StatefulWidget {
  const AddEmail({super.key});

  @override
  State<AddEmail> createState() => _AddEmailState();
}

class _AddEmailState extends State<AddEmail> {
  final TextEditingController _controller  = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar:const CommonAppBar(title: "Add Email"),
      body: Form(
        key: _formKey, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KInputField(hintText: "Email", icon:const Icon(Icons.email_outlined), controller: _controller)
            , const SizedBox(height: 30),
            FullWidthButton(text:"Get Code",onTap: (){
              
            } ),  
          ],
        ),
      ),
    );
  }
}