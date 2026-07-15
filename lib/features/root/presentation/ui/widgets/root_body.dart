import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

import 'home/active_trip_gate.dart';
import 'nav/root_bottom_nav_bar.dart';
import 'profile/root_profile_tab_section.dart';
import 'trip/root_trip_tab_section.dart';

import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';

import 'package:customertaxi/features/root/presentation/ui/widgets/root_drawer_content.dart';

enum RootTab { account, home, trips }

class RootBody extends StatefulWidget {
  const RootBody({super.key, this.initialTab});

  final RootTab? initialTab;

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody> {
  late final PageController _pageController;
  late int _currentIndex;
  late final Set<int> _visitedIndices;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab?.index ?? RootTab.home.index;
    _visitedIndices = {_currentIndex};
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void didUpdateWidget(covariant RootBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTab != null &&
        widget.initialTab != oldWidget.initialTab) {
      setState(() {
        _currentIndex = widget.initialTab!.index;
        _visitedIndices.add(_currentIndex);
      });
      _pageController.jumpToPage(_currentIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    printM('[RootBody] _onTabSelected index=$index');
    FocusManager.instance.primaryFocus?.unfocus();
    // Re-resolve the active trip whenever the Home tab is opened so its realtime
    // channel is (re)joined and the live trip view appears if one exists.
    if (index == RootTab.home.index) {
      getIt<ActiveTripCubit>().refresh();
    }
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
      _visitedIndices.add(index);
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    printM('[RootBody] _onPageChanged index=$index');
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
      _visitedIndices.add(index);
    });
  }

  List<RootBottomNavItemConfig> _buildNavItems() {
    return <RootBottomNavItemConfig>[
      RootBottomNavItemConfig(
        label: AppStrings.tabAccount,
        icon: FontAwesomeIcons.user,
      ),
      RootBottomNavItemConfig(
        label: AppStrings.tabHome,
        icon: FontAwesomeIcons.house,
      ),
      RootBottomNavItemConfig(
        label: AppStrings.drawerTrips,
        icon: FontAwesomeIcons.clock,
      ),
    ];
  }

  List<Widget> _buildPages() {
    final pages = <Widget>[
      const RootProfileTabSection(),
      const ActiveTripGate(),
      const RootTripTabSection(),
    ];
    return List<Widget>.generate(
      pages.length,
      (i) => _visitedIndices.contains(i) ? pages[i] : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    printM('[RootBody] build currentIndex=$_currentIndex');
    final pages = _buildPages();
    final navItems = _buildNavItems();

    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) => previous.sheet.mode != current.sheet.mode,
      builder: (context, state) {
        final hideNav =
            _currentIndex == RootTab.home.index &&
            state.sheet.mode != OrderSheetMode.collapsed;

        return AppScaffold.body(
          scaffoldConfig: const AppScaffoldConfig(
            safeArea: [],
            resizeToAvoidBottomInset: false,
          ),
          enableLeadingDrawer: true,
          drawer: const RootDrawerContent(),
          bottomNavigationBar: hideNav
              ? null
              : RootBottomNavBar(
                  items: navItems,
                  currentIndex: _currentIndex,
                  onItemSelected: _onTabSelected,
                ),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            children: pages,
          ),
        );
      },
    );
  }
}
