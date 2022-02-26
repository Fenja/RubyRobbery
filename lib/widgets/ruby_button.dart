import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RubyButton extends StatelessWidget {
  const RubyButton({
    Key? key,
    required this.child,
    required this.onPressed
  }) : super(key: key);

  final Widget child;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      child: child,
      /*style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
        /*textStyle: const TextStyle(

        )*/
      ),*/
    );
  }
}
