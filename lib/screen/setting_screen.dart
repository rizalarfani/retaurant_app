import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/scheduling_provider.dart';
import 'package:restaurant_app/providers/theme_config_provider.dart';
import 'package:restaurant_app/widget/custom_switch.dart';

import '../utils/colors_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 32,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/img/profile.png',
                    ),
                  ),
                ],
              ),
            ),
            Consumer<ThemeConfigProvider>(
              builder: (context, state, _) {
                return ListTile(
                  leading: Icon(
                    state.isDark ? Icons.dark_mode : Icons.light_mode,
                  ),
                  title: Text(
                    'Theme App',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: CustomSwith(
                    value: state.isDark,
                    thumChild: state.isDark
                        ? Icon(
                            Icons.light_mode,
                            size: 20,
                            color: ColorsTheme.primaryColor,
                          )
                        : const Icon(
                            Icons.dark_mode,
                            size: 20,
                          ),
                    onChanged: (bool value) => state.isDark
                        ? state.isDark = value
                        : state.isDark = value,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Divider(
                thickness: 1,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.schedule_rounded,
              ),
              title: Text(
                'Schedule restaurant',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return CustomSwith(
                    value: scheduled.isScheduling,
                    onChanged: (value) => scheduled.schedulingActived(value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
