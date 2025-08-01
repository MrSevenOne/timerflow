import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timerflow/%20presentation/screens/bar/widget/bar_edit.dart';
import 'package:timerflow/%20presentation/widgets/show_dialog/delete_dialog.dart';
import 'package:timerflow/exports.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Slidable(
      key: ValueKey(product.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(
            onPressed: () {
              DeleteDialog.show(
              context: context,
              onConfirm: () {
              context.read<ProductViewModel>().deleteProduct(product.id!);
              },
          );

            },
            // DeleteProductDialog.show(context: context, product: product),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
          IconButton(
            onPressed: () {
            EditProductDialog.show(context: context, product: product);

            },
            // EditProductDialog.show(context: context, product: product),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      child: Card(
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${'price'.tr}: ${product.price} so‘m',
              style: theme.textTheme.labelMedium,
            ),
            Text(
              '${'amount'.tr}: ${product.amount}',
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ],
    ),
  ),
),


    );
    
  }
  
}


