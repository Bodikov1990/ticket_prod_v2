import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';

@RoutePage()
class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const MainRoute(),
        const RezervationNumberRoute(),
        RepertoireRoute()
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.qr_code), label: S.current.qr),
            BottomNavigationBarItem(
                icon: const Icon(Icons.dialpad),
                label: S.current.rezervation_number),
            BottomNavigationBarItem(
                icon: const Icon(Icons.list), label: S.current.repertoire),
          ],
        );
      },
    );
  }
}
