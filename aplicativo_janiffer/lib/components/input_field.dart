import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  
  const InputField({
    super.key,
    required this.hint,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [    
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          height: 30,
          alignment: Alignment.center,
          child: TextField(
            controller: controller,
            onChanged: (value) {
              debugPrint(value);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.only(top: 0),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
              )),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.red
              ),
              prefixIcon: Icon(
                icon,
                color: Colors.red
              )
            ),
          )
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}