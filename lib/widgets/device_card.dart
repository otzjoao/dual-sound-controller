import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String name;
  final bool connected;

  const DeviceCard({
    super.key,
    required this.name,
    required this.connected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.bluetooth,
                color: Colors.green,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    connected ? 'Conectado' : 'Desconectado',
                    style: TextStyle(
                      color: connected
                          ? Colors.green
                          : Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              connected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: connected
                  ? Colors.green
                  : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}