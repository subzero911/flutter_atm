import 'package:flutter/material.dart';

import 'core/app_colors.dart';
import 'features/atm/presentation/pages/atm_page.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Env.prod);

  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardColor: AppColors.white,
        cursorColor: AppColors.white,
        accentColor: AppColors.accent,
        buttonColor: AppColors.accent,
        hintColor: AppColors.white,
      ),
      home: AtmPage(),
    );
  }
}
