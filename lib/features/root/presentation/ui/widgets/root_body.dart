import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';

import 'home/root_home_tab_section.dart';
import 'nav/root_bottom_nav_bar.dart';
import 'profile/root_profile_tab_section.dart';
import 'trip/root_trip_tab_section.dart';

enum RootTab { account, home, trips }

class RootBody extends StatefulWidget {
  const RootBody({super.key});

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody> {
  late final PageController _pageController;
  int _currentIndex = RootTab.home.index;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    printM('[RootBody] _onTabSelected index=$index');
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
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
    return <Widget>[
      const RootProfileTabSection(),
      const RootHomeTabSection(),
      const RootTripTabSection(),
    ];
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

        return Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: _onPageChanged,
              children: pages,
            ),
            if (!hideNav)
              Positioned(
                left: AppSpacing.md.w,
                right: AppSpacing.md.w,
                bottom: context.bottomPadding + AppSpacing.md.h,
                child: RootBottomNavBar(
                  items: navItems,
                  currentIndex: _currentIndex,
                  onItemSelected: _onTabSelected,
                ),
              ),
          ],
        );
      },
    );
  }
}
