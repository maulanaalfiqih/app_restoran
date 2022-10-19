import 'dart:io';

import 'package:app_restoran/widget/multi_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../provider/provider_scheduling_resto.dart';
import '../widget/custom_dialog.dart';

class SettingsResto extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsResto({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Dark Theme'),
            trailing: Switch.adaptive(
              value: false, //provider.isDarkTheme,
              onChanged: (value) {
                customDialog(context); //provider.enableDarkTheme(value);
              },
            ),
          ),
        ),
        Material(
          child: ListTile(
            title: const Text('Scheduling Resto'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled, //provider.isDailyNewsActive,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledNews(value);
                      //provider.enableDailyNews(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiPlatform(
      androidStyle: _buildAndroid,
      iosStyle: _buildIos,
    );
  }
}
