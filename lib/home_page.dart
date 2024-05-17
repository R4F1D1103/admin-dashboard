import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SideBarItem {
  dashboard(
      value: 'Dashboard', iconData: Icons.dashboard, body: DashboardScreen()),
  kelolaakun(
      value: 'Kelola Akun', iconData: Icons.business, body: Kelolaakun()),
  kelolabarang(
    value: 'Kelola Barang',
    iconData: Icons.group,
    body: Kelolabarang(),
    subItems: [
      AdminMenuItem(
          title: 'Daftar Kategori',
          icon: Icons.category,
          route: 'daftarkategori'),

      AdminMenuItem(
          title: 'Daftar Barang', icon: Icons.list, route: 'daftarbarang'),
      AdminMenuItem(
          title: 'Pasok Barang',
          icon: Icons.local_shipping,
          route: 'pasokbarang'),
    ],
  ),
  transaksi(value: 'Transaksi', iconData: Icons.campaign, body: Transaksi()),
  kelolalaporan(
    value: 'Kelola Laporan',
    iconData: Icons.settings,
    body: Kelolalaporan(),
    subItems: [
      AdminMenuItem(title: 'Laporan Transaksi', route: 'laporantransaksi'),
      AdminMenuItem(title: 'Laporan Pegawai', route: 'laporanpegwai'),
    ],
  );

  const SideBarItem({
    required this.value,
    required this.iconData,
    required this.body,
    this.subItems = const [],
  });

  final String value;
  final IconData iconData;
  final Widget body;
  final List<AdminMenuItem> subItems;
}

final sideBarItemProvider =
    StateProvider<SideBarItem>((ref) => SideBarItem.dashboard);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  SideBarItem getSideBarItem(AdminMenuItem item) {
    for (var value in SideBarItem.values) {
      if (item.route == value.name) {
        return value;
      }
      for (var subItem in value.subItems) {
        if (item.route == subItem.route) {
          return value;
        }
      }
    }
    return SideBarItem.dashboard;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideBarItem = ref.watch(sideBarItemProvider);
    final sideBarkey = ValueKey(Random().nextInt(1000000));
    const String stringParam = 'String parameter';
    const int intParam = 1000000;

    List<AdminMenuItem> getSideBarItems() {
      List<AdminMenuItem> items = [];
      for (var item in SideBarItem.values) {
        items.add(AdminMenuItem(
          title: item.value,
          icon: item.iconData,
          route: item.name,
          children: item.subItems.isNotEmpty ? item.subItems : [],
        ));
      }
      return items;
    }

    return AdminScaffold(
        appBar: AppBar(title: const Text('Bakery')),
        sideBar: SideBar(
            key: sideBarkey,
            activeBackgroundColor: Colors.white,
            onSelected: (item) => ref
                .read(sideBarItemProvider.notifier)
                .update((state) => getSideBarItem(item)),
            items: getSideBarItems(),
            selectedRoute: sideBarItem.name),
        body: ProviderScope(overrides: [
          paramProvider.overrideWithValue((stringParam, intParam))
        ], child: sideBarItem.body));
  }
}

final paramProvider = Provider<(String, int)>((ref) {
  throw UnimplementedError();
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = ref.watch(paramProvider);
    return Center(
        child: Text(
      param.$1,
      style: const TextStyle(fontSize: 24),
    ));
  }
}

class Kelolaakun extends ConsumerWidget {
  const Kelolaakun({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = ref.watch(paramProvider);
    return Center(
        child: Text(
      param.$2.toString(),
      style: const TextStyle(fontSize: 24),
    ));
  }
}

class Kelolabarang extends StatelessWidget {
  const Kelolabarang({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Kelola Barang Screen',
      style: TextStyle(fontSize: 24),
    ));
  }
}

class Transaksi extends StatelessWidget {
  const Transaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Transaksi Screen',
      style: TextStyle(fontSize: 24),
    ));
  }
}

class Kelolalaporan extends StatelessWidget {
  const Kelolalaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Kelola Laporan Screen',
      style: TextStyle(fontSize: 24),
    ));
  }
}

class daftarkategori extends StatelessWidget {
  const daftarkategori({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Daftar Kategori Screen',
      style: TextStyle(fontSize: 24),
    ));
  }
}

class Daftarbarang extends StatelessWidget {
  const Daftarbarang({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Daftar Barang Screen',
      style: TextStyle(fontSize: 24),
    ));
  }
}

class Pasokbarang extends StatelessWidget {
  const Pasokbarang({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Pasok Barang Screen',
      style: TextStyle(fontSize: 24),
    ));
  }
}

class Laporantransaksi extends StatelessWidget {
  const Laporantransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'Laporan Transaksi Screen',
          style: TextStyle(fontSize: 24),
        ));
  }
}

class Laporanpegawai extends StatelessWidget {
  const Laporanpegawai({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'Laporan Pegawai Screen',
          style: TextStyle(fontSize: 24),
        ));
  }
}