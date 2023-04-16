import 'package:commons_deps/commons_deps.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Abstrativa'),
            accountEmail: Text('contato@abstrativa.com.br'),
          ),
          ListTile(
            leading: const Icon(Icons.price_change_outlined),
            title: const Text(
              'Ativos',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => Get.toNamed("/ativos"),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Posição',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.percent_rounded),
            title: const Text(
              'Percentuais de investimento',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => Get.toNamed("/percentual"),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              'Sair',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => Get.offAllNamed("splash"),
          )
        ],
      ),
    );
  }
}
