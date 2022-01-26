import 'package:flutter/material.dart';

class RubyDialogState extends State <RubyDialog> {
  String title;
  Widget content;
  List<Widget>? actions;

  RubyDialogState(this.title, this.content, this.actions);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 280.0, maxWidth: 600),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            content,
            (actions != null) ?
              Padding(
              padding: EdgeInsets.zero,
              child: ButtonBar(
                children: actions!,
              ),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class RubyDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;

  const RubyDialog({required this.title, required this.content, this.actions});

  @override
  RubyDialogState createState() => RubyDialogState(title, content, actions);
}
