import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  child: ListTile(
                    title: const Text('Notification'),
                    trailing: ChangeNotifierProvider(
                      create: (_) => SchedulingProvider(),
                      child: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: scheduled.isScheduled,
                            activeColor: secondaryColor,
                            onChanged: (value) async {
                              if (Platform.isIOS) {
                                comingSoon("Coming Soon");
                              } else {
                                scheduled.scheduledRandom(value);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> comingSoon(String text) async {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}
