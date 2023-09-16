import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final String? hint;
  final IconData? icon;

  final TextInputType? keyBordNumberType;

  final Function(String?)? onClick;
  String? _errorMessage(String str){
    switch(hint) {
      case 'Enter your Name ': return 'Name is Empty';
      case 'Enter your Email ': return 'Email is Empty';
      case 'Enter your password': return 'password is Empty';

    }
    return '';


  }

  const CustomTextField({

    this.hint,   this.icon, this.onClick,this.keyBordNumberType});


  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator:(value){
        if(value!.isEmpty){
          return _errorMessage(hint!);
        }
        return null;
      },

      onSaved: onClick,
      obscureText: hint=='Enter your password'?true:false,
      cursorColor: Colors.grey,
      keyboardType: keyBordNumberType,


      decoration: InputDecoration(

        hintText: hint,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        icon: Icon(
          icon,
          color: Colors.black,),
        filled: true,
        fillColor: Colors.white,

        enabledBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black12)
        ),
        focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white10)
        ),
        border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey)
        ),

      ),

    );
  }

}