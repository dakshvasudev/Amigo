import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_amigo_app/assistantMethods/cart_Item_counter.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/get_started_screen.dart';
import 'package:user_amigo_app/mainScreens/cart_screen.dart';
import 'package:user_amigo_app/mainScreens/my_orders_screen.dart';
import 'package:user_amigo_app/model/order_status.dart';
import 'package:user_amigo_app/models/sellers.dart';
import 'package:user_amigo_app/widgets/amigo_ui.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';
import 'package:user_amigo_app/widgets/sellers_design.dart';

/// Signed-in shell: Home, Orders and Cart tabs with a bottom bar.
class HomeScreen extends StatefulWidget {
  final int initialTab;
  const HomeScreen({Key? key, this.initialTab = 0}) : super(key: key);

  /// Replaces the whole stack with the shell, opened on [tab].
  static void open(BuildContext context, {int tab = 0}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => HomeScreen(initialTab: tab)),
      (route) => false,
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _tab = widget.initialTab;

  void _goTo(int tab) => setState(() => _tab = tab);

  @override
  Widget build(BuildContext context) {
    final Widget body;
    if (_tab == 1) {
      body = const MyOrdersScreen();
    } else if (_tab == 2) {
      body = CartScreen(onBrowse: () => _goTo(0), onOrderPlaced: () => _goTo(1));
    } else {
      body = const _HomeTab();
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: _BottomBar(current: _tab, onTap: _goTo),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;
  const _BottomBar({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final uid = sharedPreferences!.getString('uid') ?? firebaseAuth.currentUser?.uid;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kColorBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                label: 'Home',
                selected: current == 0,
                onTap: () => onTap(0),
              ),
              // Badge counts orders that are still in progress
              StreamBuilder<QuerySnapshot>(
                stream: uid == null
                    ? null
                    : FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('orders')
                        .snapshots(),
                builder: (context, snapshot) {
                  final active = snapshot.hasData
                      ? snapshot.data!.docs
                          .where((d) => isActive(stageFromStatus(
                              (d.data() as Map<String, dynamic>)['status']
                                  as String?)))
                          .length
                      : 0;
                  return _NavItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'Orders',
                    badge: active,
                    selected: current == 1,
                    onTap: () => onTap(1),
                  );
                },
              ),
              Consumer<CartItemCounter>(
                builder: (context, counter, _) => _NavItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Cart',
                  badge: counter.count,
                  selected: current == 2,
                  onTap: () => onTap(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final int badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? kColorRed : const Color(0xffa1a1aa);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24),
                if (badge > 0)
                  Positioned(
                    right: -10,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      constraints: const BoxConstraints(minWidth: 16),
                      decoration: BoxDecoration(
                        color: kColorYellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$badge',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: kColorInk),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  String _query = '';

  void _signOut() {
    firebaseAuth.signOut().then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const GetStartedScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = sharedPreferences!.getString('name');
    return Column(
      children: [
        AmigoHeader(
          subtitle: name == null || name.isEmpty
              ? 'Order ahead, pick up at the counter'
              : 'Hi ${name.split(' ').first}, order ahead and skip the queue',
          title: 'Hungry? Pick a stall.',
          actions: [
            IconButton(
              tooltip: 'Sign out',
              onPressed: _signOut,
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ],
          bottom: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 18, color: Color(0xffa1a1aa)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Search stalls',
                      hintStyle: TextStyle(color: Color(0xffa1a1aa), fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('sellers').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return circularProgress();
              final sellers = snapshot.data!.docs
                  .map((d) => Sellers.fromJson(d.data()! as Map<String, dynamic>))
                  .where((s) =>
                      _query.isEmpty ||
                      (s.sellerName ?? '').toLowerCase().contains(_query))
                  .toList();
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kColorYellow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('SKIP THE QUEUE',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: kColorRedDark)),
                        SizedBox(height: 2),
                        Text("Order now, we'll tell you when it's ready",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kColorInk)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SectionLabel('On campus now'),
                  const SizedBox(height: 8),
                  if (sellers.isEmpty)
                    EmptyState(
                      icon: Icons.storefront_outlined,
                      message: _query.isEmpty
                          ? 'No stalls are open yet.'
                          : 'Nothing matches "$_query".',
                    ),
                  ...sellers.map((s) => SellerDesignWidget(model: s, context: context)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
