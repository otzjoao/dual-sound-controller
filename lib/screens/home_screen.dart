import 'package:flutter/material.dart';

import '../widgets/device_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dual Sound',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seus dispositivos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Conecte e controle seus dispositivos de áudio.',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            const DeviceCard(
              name: 'Nenhum dispositivo conectado',
              connected: false,
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.bluetooth_searching),
                label: const Text('Buscar dispositivos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}