import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
            BottomNavigationBarItem(
                icon: Icon(Icons.dialpad), label: 'Номер бронювання'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Репертуар'),
          ],
        );
      },
    );
  }
}
