import 'package:flutter/material.dart';

import '../../styles/kcolor.dart';



class UserNameInputField extends StatelessWidget {

  final TextEditingController controller; 
  final String hintText; 
  final Icon icon; 
  final ValueChanged<String>? onChange; 
  final String?Function(String?)? validator;
  const UserNameInputField({
    super.key, required this.hintText, required this.icon, required this.controller,   this.onChange, required this.validator,
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
                onChanged:onChange,
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                    border:  UnderlineInputBorder(
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

