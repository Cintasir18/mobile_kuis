import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'widgets.dart';

class TrianglePage extends StatefulWidget {
  const TrianglePage({super.key});

  @override
  State<TrianglePage> createState() => _TrianglePageState();
}

class _TrianglePageState extends State<TrianglePage> {
  String _selectedType = 'Segitiga Sama Kaki';

  final TextEditingController _sideAController = TextEditingController();
  final TextEditingController _sideBController = TextEditingController();

  String? _area;
  String? _perimeter;

  final List<String> _types = [
    'Segitiga Sama Kaki',
    'Segitiga Sama Sisi',
    'Segitiga Siku-siku',
  ];

  void _calculate() {
    final a = double.tryParse(_sideAController.text);
    final b = double.tryParse(_sideBController.text);

    if (a == null || a <= 0) {
      _showError('Masukkan nilai sisi dengan benar.');
      return;
    }

    double area = 0;
    double perimeter = 0;

    if (_selectedType == 'Segitiga Sama Kaki') {
      if (b == null || b <= 0) {
        _showError('Masukkan panjang alas segitiga.');
        return;
      }

      if (b >= 2 * a) {
        _showError(
          'Nilai alas harus lebih kecil dari dua kali sisi sama kaki.',
        );
        return;
      }

      final height = math.sqrt(
        (a * a) - ((b * b) / 4),
      );

      area = (b * height) / 2;
      perimeter = (2 * a) + b;
    } else if (_selectedType == 'Segitiga Sama Sisi') {
      area = (math.sqrt(3) / 4) * a * a;
      perimeter = 3 * a;
    } else {
      if (b == null || b <= 0) {
        _showError('Masukkan kedua sisi siku-siku.');
        return;
      }

      final hypotenuse = math.sqrt(
        (a * a) + (b * b),
      );

      area = (a * b) / 2;
      perimeter = a + b + hypotenuse;
    }

    setState(() {
      _area = '${area.toStringAsFixed(2)} cm²';
      _perimeter = '${perimeter.toStringAsFixed(2)} cm';
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _changeType(String? value) {
    if (value == null) return;

    setState(() {
      _selectedType = value;
      _area = null;
      _perimeter = null;
      _sideAController.clear();
      _sideBController.clear();
    });
  }

  String get _firstLabel {
    switch (_selectedType) {
      case 'Segitiga Sama Kaki':
        return 'Sisi sama kaki';
      case 'Segitiga Sama Sisi':
        return 'Panjang sisi';
      default:
        return 'Sisi tegak';
    }
  }

  String get _secondLabel {
    switch (_selectedType) {
      case 'Segitiga Sama Kaki':
        return 'Alas';
      case 'Segitiga Sama Sisi':
        return 'Tidak diperlukan';
      default:
        return 'Sisi alas';
    }
  }

  @override
  void dispose() {
    _sideAController.dispose();
    _sideBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEquilateral = _selectedType == 'Segitiga Sama Sisi';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Segitiga',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Luas & Keliling',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Pilih jenis segitiga kemudian masukkan ukurannya.',
              style: TextStyle(
                color: AppColors.mutedText,
              ),
            ),
            const SizedBox(height: 22),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Jenis segitiga',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: _types.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: _changeType,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _sideAController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: _firstLabel,
                suffixText: 'cm',
                prefixIcon: const Icon(Icons.straighten_rounded),
              ),
            ),
            const SizedBox(height: 14),
            if (!isEquilateral)
              TextField(
                controller: _sideBController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: _secondLabel,
                  suffixText: 'cm',
                  prefixIcon: const Icon(Icons.straighten_rounded),
                ),
              ),
            const SizedBox(height: 20),
            CalculateButton(
              onPressed: _calculate,
            ),
            if (_area != null && _perimeter != null) ...[
              const SizedBox(height: 25),
              const Text(
                'Hasil Perhitungan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ResultBox(
                title: 'Luas',
                value: _area!,
              ),
              const SizedBox(height: 10),
              ResultBox(
                title: 'Keliling',
                value: _perimeter!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}