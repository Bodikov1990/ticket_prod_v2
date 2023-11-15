import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_prod_v2/src/tabbar/presentation/bloc/tabbar_bloc.dart';

@RoutePage()
class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TabbarBloc tabBloc = TabbarBloc();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar with Bloc'),
          bottom: TabBar(
            onTap: (index) {
              tabBloc.add(TabUpdated(index));
            },
            tabs: const [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: BlocBuilder<TabbarBloc, TabbarState>(
          bloc: tabBloc,
          builder: (context, state) {
            if (state is TabSelected) {
              switch (state.selectedTabIndex) {
                case 0:
                  return const Center(child: Text('Content of Tab 1'));
                case 1:
                  return const Center(child: Text('Content of Tab 2'));
                case 2:
                  return const Center(child: Text('Content of Tab 3'));
                default:
                  return const Center(child: Text('Unknown Tab'));
              }
            }
            return const Center(child: Text('No Tab Selected'));
          },
        ),
      ),
    );
  }
}
