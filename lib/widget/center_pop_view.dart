import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CenterPopView extends StatelessWidget {
  final Widget child;
  final bool barrierDismissible;
  final void Function(BuildContext)? onClose;
  const CenterPopView(this.child, {this.barrierDismissible = false, this.onClose, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (barrierDismissible) {
                if (onClose != null) {
                  onClose!(context);
                } else {
                  Navigator.pop(context);
                }
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              child,
              CupertinoButton(
                onPressed: () {
                  if (onClose != null) {
                    onClose!(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(25)),
                  child: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
