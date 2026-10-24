import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/shop_viewmodel.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(catalogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda Oficial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Carrito disponible en la Etapa 2')),
              );
            },
          ),
        ],
      ),
      body: catalogAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue)),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (products) => Column(
          children: [
            // Banner de "Etapa 2"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.accentGold.withValues(alpha: 0.2),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Catálogo de demostración (Etapa 2)',
                    style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _ProductCard(product: products[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final dynamic product; // ProductEntity
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    // Mapeo simple de nombres de iconos (en una app real usaríamos imágenes)
    IconData getIcon(String name) {
      switch (name) {
        case 'sports_soccer': return Icons.sports_soccer;
        case 'checkroom': return Icons.checkroom;
        case 'fitness_center': return Icons.fitness_center;
        case 'winter_sports': return Icons.ac_unit;
        default: return Icons.shopping_bag;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Icon(getIcon(product.iconName), size: 48, color: AppColors.primaryBlue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}