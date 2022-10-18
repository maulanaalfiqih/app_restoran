import 'package:app_restoran/widget/multi_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SettingResto extends StatelessWidget {
  static const String settingTitle = 'Settings';

  const SettingResto({Key? key}) : super(key: key);

  Widget _androidStyle(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _iosStyle(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Mode Gelap'),
            trailing: Switch.adaptive(
              value: false,
              onChanged: (value) {
                defaultTargetPlatform == TargetPlatform.iOS
                    ? showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Coming Soon!!'),
                            content: const Text(
                                'Fitur lagi dibuat oleh Programmernya, hehe..'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('Oke deh'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Coming Soon!!'),
                            content: const Text(
                                'Fitur lagi dibuat oleh Programmernya, hehe..'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Oke deh'),
                              ),
                            ],
                          );
                        },
                      );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiPlatform(
      androidStyle: _androidStyle,
      iosStyle: _iosStyle,
    );
  }
}
