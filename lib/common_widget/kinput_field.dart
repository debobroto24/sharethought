import 'package:flutter/material.dart';

import '../styles/kcolor.dart';

class KInputField extends StatelessWidget {
  final bool isObscure; 
  final TextEditingController controller; 
  final String hintText; 
  final Icon icon; 
  const KInputField({
    super.key, required this.hintText, required this.icon, required this.controller,  this.isObscure  = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon, 
            const SizedBox(width: 10,), 
            SizedBox( 
              width: MediaQuery.of(context).size.width * .8,
              child: TextFormField(
                obscureText: isObscure,
                controller: controller,
                validator: (value){
                  if(value == null || value.isEmpty){
                    if(isObscure){
                      return "Please you password";
                    }else{
                       return "please enter username";
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Kcolor.baseGrey)
                        ),
                    fillColor: Kcolor.white,
                    hintText: hintText,
                    // contentPadding: const EdgeInsets.only(top: 15),
                    ),
              ),
            ),
          ],
        ));
  }
}

