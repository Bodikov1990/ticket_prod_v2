import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';

@RoutePage()
class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [MainRoute(), RezervationNumberRoute(), RepertoireRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Ticket Prod'),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dialpad), label: 'Номер брони'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Репертуар'),
            ],
          ),
        );
      },
    );
  }
}
