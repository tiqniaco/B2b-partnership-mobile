import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class IsoCertificationsView extends StatelessWidget {
  const IsoCertificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                // height: context.isTablet ? 250 : 190.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Image.asset(
                          Get.locale?.languageCode == "en"
                              ? "assets/images/4 en.jpg"
                              : "assets/images/4 ar.jpg",
                          fit: BoxFit.fitWidth,
                          //   height: context.isTablet ? 250 : 200.h,
                          width: double.infinity,
                        )),
                  ],
                ),
              ),
              Gap(8),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildHeader(),
                      Gap(12),
                      _buildStatsSection(),
                      const SizedBox(height: 24),
                      const Text(
                        'Our Certifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCertificationsGrid(),
                      const SizedBox(height: 24),
                      _buildInfoBanner(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildStatsSection() {
    final stats = [
      {
        'label': 'Active Certifications',
        'value': '4',
        'icon': Icons.fact_check
      },
      {'label': 'Years Certified', 'value': '8+', 'icon': Icons.trending_up},
      {'label': 'Compliance Rate', 'value': '100%', 'icon': Icons.check_circle},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat['label'] as String,
                style: TextStyle(
                  fontSize: 14.r,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stat['value'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                          primaryColor.withAlpha(18), //const Color(0xFFDCEEFB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCertificationsGrid() {
    final certifications = [
      {
        'name': 'ISO 9001:2015',
        'title': 'Quality Management',
        'icon': Icons.card_membership,
        'colors': [Color(0xFF3B82F6), Color(0xFF2563EB)],
        'description': 'International standard for quality management systems',
      },
      {
        'name': 'ISO 27001:2013',
        'title': 'Information Security',
        'icon': Icons.security,
        'colors': [Color(0xFFA855F7), Color(0xFF9333EA)],
        'description': 'Security management for information systems',
      },
      {
        'name': 'ISO 14001:2015',
        'title': 'Environmental Management',
        'icon': Icons.eco,
        'colors': [Color(0xFF22C55E), Color(0xFF16A34A)],
        'description': 'Environmental management systems standards',
      },
      {
        'name': 'ISO 45001:2018',
        'title': 'Health & Safety',
        'icon': Icons.health_and_safety,
        'colors': [Color(0xFFEF4444), Color(0xFFDC2626)],
        'description': 'Occupational health and safety management',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: certifications.length,
      itemBuilder: (context, index) {
        final cert = certifications[index];
        return InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.isoCertificationDetails, arguments: cert);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: cert['colors'] as List<Color>,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: cert['colors'] as List<Color>,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              cert['icon'] as IconData,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: borderColor, //const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Active',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor //Color(0xFF15803D),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        cert['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cert['title'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cert['description'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoBanner() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.brown.withAlpha(26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.verified_user, color: Colors.brown, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Committed to Excellence',
                style: TextStyle(
                  fontSize: 18.r,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our ISO certifications demonstrate our dedication to maintaining the highest standards in quality, security, environmental responsibility, and workplace safety. We continuously improve our processes to deliver exceptional value to our stakeholders.',
                style: TextStyle(
                  fontSize: 13.r,
                  color: Colors.black, //Color(0xFFDCEEFB),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
