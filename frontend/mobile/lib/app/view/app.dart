import 'package:flutter/material.dart';
import 'package:mobile/core/core.dart';
import 'package:mobile/images/images.dart';
import 'package:mobile/l10n/l10n.dart';
import 'package:mobile/videos/videos.dart';

final pages = {
  Icons.music_note: const VideosPage(),
  Icons.image: const ImagesPage(),
};

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: DefaultTabController(
        length: pages.length,
        child: RootLayout(
          tabs: pages.keys.toList(),
          children: pages.values.toList(),
        ),
      ),
    );
  }
}
