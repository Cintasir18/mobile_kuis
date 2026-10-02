import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  final TextEditingController indonesiaController = TextEditingController(
    text: '21:00',
  );

  final TextEditingController malaysiaController = TextEditingController(
    text: '22:00',
  );

  final TextEditingController torontoController = TextEditingController(
    text: '10:00',
  );

  String? indonesiaError;
  String? malaysiaError;
  String? torontoError;

  bool _isUpdating = false;

  @override
  void dispose() {
    indonesiaController.dispose();
    malaysiaController.dispose();
    torontoController.dispose();
    super.dispose();
  }

  // Mengubah waktu HH:mm menjadi menit
  int _timeToMinutes(String time) {
    final parts = time.split(':');

    if (parts.length != 2) {
      return 0;
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) {
      return 0;
    }

    return (hour * 60) + minute;
  }

  // Mengubah menit menjadi format HH:mm
  String _minutesToTime(int minutes) {
    minutes = minutes % (24 * 60);

    if (minutes < 0) {
      minutes += 24 * 60;
    }

    final hour = minutes ~/ 60;
    final minute = minutes % 60;

    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }

  // Validasi input waktu
  String? _validateTime(String value) {
    if (value.isEmpty) {
      return 'Waktu belum diisi';
    }

    final parts = value.split(':');

    if (parts.length != 2) {
      return 'Format waktu harus HH:mm';
    }

    if (parts[0].length != 2 || parts[1].length != 2) {
      return 'Format waktu harus HH:mm';
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) {
      return 'Waktu harus berupa angka';
    }

    if (hour < 0 || hour > 23) {
      return 'Jam harus antara 00-23';
    }

    if (minute < 0 || minute > 59) {
      return 'Menit harus antara 00-59';
    }

    return null;
  }

  // Indonesia → Malaysia + Toronto
  void _updateFromIndonesia(String value) {
    if (_isUpdating) return;

    final error = _validateTime(value);

    setState(() {
      indonesiaError = error;
    });

    if (error != null) return;

    final minutes = _timeToMinutes(value);

    _isUpdating = true;

    malaysiaController.text = _minutesToTime(minutes + 60);
    torontoController.text = _minutesToTime(minutes - 11 * 60);

    malaysiaError = null;
    torontoError = null;

    _isUpdating = false;

    setState(() {});
  }

  // Malaysia → Indonesia + Toronto
  void _updateFromMalaysia(String value) {
    if (_isUpdating) return;

    final error = _validateTime(value);

    setState(() {
      malaysiaError = error;
    });

    if (error != null) return;

    final minutes = _timeToMinutes(value);

    _isUpdating = true;

    indonesiaController.text = _minutesToTime(minutes - 60);
    torontoController.text = _minutesToTime(minutes - 12 * 60);

    indonesiaError = null;
    torontoError = null;

    _isUpdating = false;

    setState(() {});
  }

  // Toronto → Indonesia + Malaysia
  void _updateFromToronto(String value) {
    if (_isUpdating) return;

    final error = _validateTime(value);

    setState(() {
      torontoError = error;
    });

    if (error != null) return;

    final minutes = _timeToMinutes(value);

    _isUpdating = true;

    indonesiaController.text = _minutesToTime(minutes + 11 * 60);
    malaysiaController.text = _minutesToTime(minutes + 12 * 60);

    indonesiaError = null;
    malaysiaError = null;

    _isUpdating = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 25, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Konversi Waktu',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Masukkan waktu pada salah satu kota untuk melihat '
                'waktu di kota lainnya.',
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 25),

              // Indonesia
              _TimeCard(
                flag: '🇮🇩',
                country: 'Indonesia',
                city: 'WIB (UTC+7)',
                controller: indonesiaController,
                errorText: indonesiaError,
                onChanged: _updateFromIndonesia,
              ),

              const SizedBox(height: 14),

              // Malaysia
              _TimeCard(
                flag: '🇲🇾',
                country: 'Malaysia',
                city: 'Kuala Lumpur (UTC+8)',
                controller: malaysiaController,
                errorText: malaysiaError,
                onChanged: _updateFromMalaysia,
              ),

              const SizedBox(height: 14),

              // Toronto
              _TimeCard(
                flag: '🇨🇦',
                country: 'Canada',
                city: 'Toronto (UTC-4)',
                controller: torontoController,
                errorText: torontoError,
                onChanged: _updateFromToronto,
              ),

              const SizedBox(height: 20),

              // Informasi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primary),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Ketik waktu pada salah satu kolom. '
                        'Waktu di dua lokasi lainnya akan berubah '
                        'secara otomatis.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.text,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  final String flag;
  final String country;
  final String city;
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String> onChanged;

  const _TimeCard({
    required this.flag,
    required this.country,
    required this.city,
    required this.controller,
    required this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: errorText == null ? AppColors.border : Colors.redAccent,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Bendera
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(flag, style: const TextStyle(fontSize: 25)),
              ),

              const SizedBox(width: 14),

              // Nama negara
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      city,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),

              // Input waktu
              SizedBox(
                width: 95,
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                  decoration: InputDecoration(
                    hintText: 'HH:mm',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: errorText == null
                            ? AppColors.border
                            : Colors.redAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: errorText == null
                            ? AppColors.primary
                            : Colors.redAccent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Pesan error
          if (errorText != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 64),
                const Icon(
                  Icons.error_outline,
                  size: 16,
                  color: Colors.redAccent,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    errorText!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
