import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'day_page.dart';
import 'pyramid_page.dart';
import 'time_page.dart';
import 'triangle_page.dart';
import 'widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Halo, Selamat Datang!',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.mutedText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ShapeTime',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hitung, konversi, dan cek informasi dengan mudah.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.mutedText,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kalkulator sederhana',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Semua dalam satu aplikasi.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.calculate_rounded,
                          color: AppColors.secondary,
                          size: 44,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Menu Utama',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 13),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  FeatureCard(
                    title: 'Piramida',
                    description: 'Hitung volume dan keliling alas piramida.',
                    icon: Icons.change_history_rounded,
                    onTap: () {
                      _openPage(context, const PyramidPage());
                    },
                  ),
                  const SizedBox(height: 12),
                  FeatureCard(
                    title: 'Segitiga',
                    description: 'Hitung luas dan keliling berbagai jenis segitiga.',
                    icon: Icons.category_outlined,
                    onTap: () {
                      _openPage(context, const TrianglePage());
                    },
                  ),
                  const SizedBox(height: 12),
                  FeatureCard(
                    title: 'Konversi Waktu',
                    description: 'Konversi WIB ke Malaysia dan Kanada.',
                    icon: Icons.access_time_rounded,
                    onTap: () {
                      _openPage(context, const TimePage());
                    },
                  ),
                  const SizedBox(height: 12),
                  FeatureCard(
                    title: 'Cek Hari',
                    description: 'Masukkan angka 1 sampai 7 untuk mengetahui hari.',
                    icon: Icons.calendar_month_rounded,
                    onTap: () {
                      _openPage(context, const DayPage());
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}