import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'widgets.dart';

class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final TextEditingController _sideController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String? _volume;
  String? _perimeter;

  void _calculate() {
    final side = double.tryParse(_sideController.text);
    final height = double.tryParse(_heightController.text);

    if (side == null || height == null || side <= 0 || height <= 0) {
      _showError('Masukkan sisi dan tinggi dengan nilai yang valid.');
      return;
    }

    final volume = (side * side * height) / 3;
    final perimeter = 4 * side;

    setState(() {
      _volume = '${volume.toStringAsFixed(2)} cm³';
      _perimeter = '${perimeter.toStringAsFixed(2)} cm';
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _sideController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Piramida',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Volume & Keliling',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Masukkan ukuran alas dan tinggi piramida.',
              style: TextStyle(
                color: AppColors.mutedText,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _sideController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Sisi alas',
                suffixText: 'cm',
                prefixIcon: Icon(Icons.straighten_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Tinggi piramida',
                suffixText: 'cm',
                prefixIcon: Icon(Icons.height_rounded),
              ),
            ),
            const SizedBox(height: 20),
            CalculateButton(
              onPressed: _calculate,
            ),
            if (_volume != null && _perimeter != null) ...[
              const SizedBox(height: 25),
              const Text(
                'Hasil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ResultBox(
                title: 'Volume',
                value: _volume!,
              ),
              const SizedBox(height: 10),
              ResultBox(
                title: 'Keliling alas',
                value: _perimeter!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}