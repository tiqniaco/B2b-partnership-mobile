// import 'package:flutter/material.dart';

// class CartItem {
//   final String id;
//   final String name;
//   final String title;
//   final double price;
//   final IconData icon;
//   final List<Color> colors;
//   int quantity;

//   CartItem({
//     required this.id,
//     required this.name,
//     required this.title,
//     required this.price,
//     required this.icon,
//     required this.colors,
//     this.quantity = 1,
//   });
// }

// class CartProvider extends ChangeNotifier {
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

//   double get totalPrice =>
//       _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

//   void addItem(CartItem item) {
//     final existingIndex = _items.indexWhere((i) => i.id == item.id);
//     if (existingIndex >= 0) {
//       _items[existingIndex].quantity++;
//     } else {
//       _items.add(item);
//     }
//     notifyListeners();
//   }

//   void removeItem(String id) {
//     _items.removeWhere((item) => item.id == id);
//     notifyListeners();
//   }

//   void updateQuantity(String id, int quantity) {
//     final index = _items.indexWhere((item) => item.id == id);
//     if (index >= 0) {
//       if (quantity <= 0) {
//         _items.removeAt(index);
//       } else {
//         _items[index].quantity = quantity;
//       }
//       notifyListeners();
//     }
//   }

//   void clearCart() {
//     _items.clear();
//     notifyListeners();
//   }
// }

// // class ChangeNotifierProvider extends InheritedWidget {
// //   final CartProvider cartProvider;
// //   const ChangeNotifierProvider({
// //     Key? key,
// //     required this.cartProvider,
// //     required Widget child,
// //   }) : super(key: key, child: child);

// //   static CartProvider of(BuildContext context) {
// //     return context
// //         .dependOnInheritedWidgetOfExactType<ChangeNotifierProvider>()!
// //         .cartProvider;
// //   }

// //   @override
// //   bool updateShouldNotify(ChangeNotifierProvider oldWidget) => true;
// // }

// class ISOCertificationHome extends StatefulWidget {
//   const ISOCertificationHome({Key? key}) : super(key: key);

//   @override
//   State<ISOCertificationHome> createState() => _ISOCertificationHomeState();
// }

// class _ISOCertificationHomeState extends State<ISOCertificationHome> {
//   @override
//   Widget build(BuildContext context) {
//    // final cartProvider = ChangeNotifierProvider.of(context);

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
//           ),
//         ),
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildStatsSection(),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Our Certifications',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF0F172A),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     _buildCertificationsGrid(),
//                     const SizedBox(height: 24),
//                     _buildInfoBanner(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x0A000000),
//             blurRadius: 4,
//             offset: Offset(0, 1),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF2563EB), Color(0xFF9333EA)],
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.card_membership,
//                 color: Colors.white, size: 24),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ISO Certifications',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF0F172A),
//                   ),
//                 ),
//                 Text(
//                   'Quality & Compliance Dashboard',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF64748B),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.shopping_cart_outlined, size: 28),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const CartScreen()),
//                   );
//                 },
//               ),
//              // if (cartProvider.itemCount > 0)
//                 Positioned(
//                   right: 8,
//                   top: 8,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '4',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatsSection() {
//     final stats = [
//       {
//         'label': 'Active Certifications',
//         'value': '4',
//         'icon': Icons.fact_check
//       },
//       {'label': 'Years Certified', 'value': '8+', 'icon': Icons.trending_up},
//       {'label': 'Compliance Rate', 'value': '100%', 'icon': Icons.check_circle},
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: 1.2,
//       ),
//       itemCount: stats.length,
//       itemBuilder: (context, index) {
//         final stat = stats[index];
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: const Color(0xFFE2E8F0)),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0x0A000000),
//                 blurRadius: 4,
//                 offset: Offset(0, 1),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           stat['label'] as String,
//                           style: const TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF64748B),
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           stat['value'] as String,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF0F172A),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFDCEEFB),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       stat['icon'] as IconData,
//                       color: const Color(0xFF2563EB),
//                       size: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCertificationsGrid() {
//     final certifications = [
//       {
//         'id': '1',
//         'name': 'ISO 9001:2015',
//         'title': 'Quality Management',
//         'icon': Icons.card_membership,
//         'colors': [Color(0xFF3B82F6), Color(0xFF2563EB)],
//         'description': 'International standard for quality management systems',
//         'price': 1299.99,
//       },
//       {
//         'id': '2',
//         'name': 'ISO 27001:2013',
//         'title': 'Information Security',
//         'icon': Icons.security,
//         'colors': [Color(0xFFA855F7), Color(0xFF9333EA)],
//         'description': 'Security management for information systems',
//         'price': 1499.99,
//       },
//       {
//         'id': '3',
//         'name': 'ISO 14001:2015',
//         'title': 'Environmental Management',
//         'icon': Icons.eco,
//         'colors': [Color(0xFF22C55E), Color(0xFF16A34A)],
//         'description': 'Environmental management systems standards',
//         'price': 1399.99,
//       },
//       {
//         'id': '4',
//         'name': 'ISO 45001:2018',
//         'title': 'Health & Safety',
//         'icon': Icons.health_and_safety,
//         'colors': [Color(0xFFEF4444), Color(0xFFDC2626)],
//         'description': 'Occupational health and safety management',
//         'price': 1349.99,
//       },
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         childAspectRatio: 0.85,
//       ),
//       itemCount: certifications.length,
//       itemBuilder: (context, index) {
//         final cert = certifications[index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     CertificationDetailsScreen(certification: cert),
//               ),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: const Color(0xFFE2E8F0)),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color(0x0A000000),
//                   blurRadius: 4,
//                   offset: Offset(0, 1),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 2,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: cert['colors'] as List<Color>,
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 48,
//                             height: 48,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: cert['colors'] as List<Color>,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               cert['icon'] as IconData,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF0FDF4),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Text(
//                               'Active',
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF15803D),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         cert['name'] as String,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF0F172A),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         cert['title'] as String,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF334155),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         cert['description'] as String,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Color(0xFF64748B),
//                           height: 1.4,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildInfoBanner() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF2563EB), Color(0xFF9333EA)],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x26000000),
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(24),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child:
//                 const Icon(Icons.verified_user, color: Colors.white, size: 24),
//           ),
//           const SizedBox(width: 16),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Committed to Excellence',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Our ISO certifications demonstrate our dedication to maintaining the highest standards in quality, security, environmental responsibility, and workplace safety.',
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Color(0xFFDCEEFB),
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CertificationDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> certification;

//   const CertificationDetailsScreen({Key? key, required this.certification})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final cartProvider = ChangeNotifierProvider.of(context);

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
//           ),
//         ),
//         child: Column(
//           children: [
//             _buildHeader(context),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildHeroSection(),
//                     _buildDetailsSection(),
//                     _buildFeaturesSection(),
//                     _buildBenefitsSection(),
//                     const SizedBox(height: 100),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomBar(context),
//     );
//   }

//   Widget _buildHeader(BuildContext context, ) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
//         ),
//       ),
//       padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//           ),
//           const Expanded(
//             child: Text(
//               'Certification Details',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF0F172A),
//               ),
//             ),
//           ),
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.shopping_cart_outlined, size: 28),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const CartScreen()),
//                   );
//                 },
//               ),
//              // if (cartProvider.itemCount > 0)
//                 Positioned(
//                   right: 8,
//                   top: 8,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '4',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeroSection() {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: certification['colors'] as List<Color>,
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.all(32),
//       child: Column(
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Icon(
//               certification['icon'] as IconData,
//               color: Colors.white,
//               size: 50,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             certification['name'] as String,
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             certification['title'] as String,
//             style: const TextStyle(
//               fontSize: 18,
//               color: Color(0xFFDCEEFB),
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.check_circle, color: Colors.white, size: 16),
//                 SizedBox(width: 8),
//                 Text(
//                   'Certified & Active',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailsSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x0A000000),
//             blurRadius: 4,
//             offset: Offset(0, 1),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'About This Certification',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0F172A),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             certification['description'] as String,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Color(0xFF64748B),
//               height: 1.6,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Certification Price:',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF334155),
//                 ),
//               ),
//               Text(
//                 '\$${certification['price']}',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: (certification['colors'] as List<Color>)[0],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeaturesSection() {
//     final features = [
//       {
//         'icon': Icons.verified,
//         'title': 'Internationally Recognized',
//         'desc': 'Accepted worldwide by organizations'
//       },
//       {
//         'icon': Icons.schedule,
//         'title': 'Valid for 3 Years',
//         'desc': 'Full certification period included'
//       },
//       {
//         'icon': Icons.support_agent,
//         'title': '24/7 Support',
//         'desc': 'Expert assistance available anytime'
//       },
//       {
//         'icon': Icons.description,
//         'title': 'Full Documentation',
//         'desc': 'Complete certification materials'
//       },
//     ];

//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x0A000000),
//             blurRadius: 4,
//             offset: Offset(0, 1),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'What\'s Included',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0F172A),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ...features.map((feature) => Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFDCEEFB),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         feature['icon'] as IconData,
//                         color: const Color(0xFF2563EB),
//                         size: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             feature['title'] as String,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF0F172A),
//                             ),
//                           ),
//                           Text(
//                             feature['desc'] as String,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF64748B),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildBenefitsSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             (certification['colors'] as List<Color>)[0].withOpacity(0.1),
//             (certification['colors'] as List<Color>)[1].withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: (certification['colors'] as List<Color>)[0].withOpacity(0.3),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.star,
//                 color: (certification['colors'] as List<Color>)[0],
//                 size: 24,
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 'Key Benefits',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF0F172A),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildBenefitItem('Enhance organizational credibility'),
//           _buildBenefitItem('Improve operational efficiency'),
//           _buildBenefitItem('Meet regulatory requirements'),
//           _buildBenefitItem('Gain competitive advantage'),
//           _buildBenefitItem('Build customer trust'),
//         ],
//       ),
//     );
//   }

//   Widget _buildBenefitItem(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           Icon(
//             Icons.check_circle,
//             color: (certification['colors'] as List<Color>)[0],
//             size: 18,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF334155),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomBar(BuildContext context, ) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x1A000000),
//             blurRadius: 8,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(16),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Total Price',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF64748B),
//                     ),
//                   ),
//                   Text(
//                     '\$${certification['price']}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF0F172A),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   final cartItem = CartItem(
//                     id: certification['id'] as String,
//                     name: certification['name'] as String,
//                     title: certification['title'] as String,
//                     price: certification['price'] as double,
//                     icon: certification['icon'] as IconData,
//                     colors: certification['colors'] as List<Color>,
//                   );
//                  // cartProvider.addItem(cartItem);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text('Added to cart!'),
//                       duration: const Duration(seconds: 2),
//                       backgroundColor:
//                           (certification['colors'] as List<Color>)[0],
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: (certification['colors'] as List<Color>)[0],
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.shopping_cart),
//                     SizedBox(width: 8),
//                     Text(
//                       'Add to Cart',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     //final cartProvider = ChangeNotifierProvider.of(context);

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
//           ),
//         ),
//         child: Column(
//           children: [
//             _buildHeader(context),
//             Expanded(
//               child: 
//               // cartProvider.items.isEmpty
//               //     ? _buildEmptyCart()
//               //     :
//                    _buildCartList(),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar:  _buildBottomBar(context),
//     );
//   }

//   Widget _buildHeader(BuildContext context, //CartProvider cartProvider
//   ) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
//         ),
//       ),
//       padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//           ),
//           const Expanded(
//             child: Text(
//               'Shopping Cart',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF0F172A),
//               ),
//             ),
//           ),
//           //if (cartProvider.items.isNotEmpty)
//             TextButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text('Clear Cart'),
//                     content: const Text(
//                         'Are you sure you want to remove all items?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // cartProvider.clearCart();
//                           Navigator.pop(context);
//                           setState(() {});
//                         },
//                         child: const Text('Clear',
//                             style: TextStyle(color: Colors.red)),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: const Text('Clear All'),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyCart() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               color: const Color(0xFFDCEEFB),
//               borderRadius: BorderRadius.circular(60),
//             ),
//             child: const Icon(
//               Icons.shopping_cart_outlined,
//               size: 60,
//               color: Color(0xFF2563EB),
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Your cart is empty',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0F172A),
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Add certifications to get started',
//             style: TextStyle(
//               fontSize: 14,
//               color: Color(0xFF64748B),
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2563EB),
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text('Browse Certifications'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCartList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 3,
//       itemBuilder: (context, index) {
//        // final item = cartProvider.items[index];
//         return Container(
//           margin: const EdgeInsets.only(bottom: 16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: const Color(0xFFE2E8F0)),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0x0A000000),
//                 blurRadius: 4,
//                 offset: Offset(0, 1),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 3,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: item.colors),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: item.colors),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         item.icon,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item.name,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF0F172A),
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             item.title,
//                             style: const TextStyle(
//                               fontSize: 13,
//                               color: Color(0xFF64748B),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             '\${item.price.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: item.colors[0],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFF1F5F9),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.remove, size: 18),
//                                 onPressed: () {
//                                   setState(() {
//                                     // cartProvider.updateQuantity(
//                                     //     item.id, item.quantity - 1);
//                                   });
//                                 },
//                                 constraints: const BoxConstraints(
//                                   minWidth: 32,
//                                   minHeight: 32,
//                                 ),
//                                 padding: EdgeInsets.zero,
//                               ),
//                               Container(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 12),
//                                 child: Text(
//                                   '${item.quantity}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.add, size: 18),
//                                 onPressed: () {
//                                   setState(() {
//                                     // cartProvider.updateQuantity(
//                                     //     item.id, item.quantity + 1);
//                                   });
//                                 },
//                                 constraints: const BoxConstraints(
//                                   minWidth: 32,
//                                   minHeight: 32,
//                                 ),
//                                 padding: EdgeInsets.zero,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         IconButton(
//                           icon: const Icon(Icons.delete_outline,
//                               color: Colors.red),
//                           onPressed: () {
//                             setState(() {
//                               //cartProvider.removeItem(item.id);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBottomBar(BuildContext context, ) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x1A000000),
//             blurRadius: 8,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(16),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Subtotal',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF64748B),
//                   ),
//                 ),
//                 Text(
//                   '\${cartProvider.totalPrice.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF0F172A),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Tax (10%)',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF64748B),
//                   ),
//                 ),
//                 Text(
//                   '\$0.00',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF0F172A),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Total',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF0F172A),
//                   ),
//                 ),
//                 Text(
//                   '\${cartProvider.totalPrice.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF0F172A),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Checkout'),
//                       content: Text(
//                         'Proceeding to checkout with ${4} item(s)\nTotal: \${cartProvider.totalPrice.toStringAsFixed(2)}',
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text('Cancel'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           //  cartProvider.clearCart();
//                             Navigator.pop(context);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Order placed successfully!'),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );
//                           },
//                           child: const Text('Confirm'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2563EB),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.payment),
//                     SizedBox(width: 8),
//                     Text(
//                       'Proceed to Checkout',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
