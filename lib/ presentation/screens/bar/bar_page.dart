import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/exports.dart';
import 'package:timerflow/utils/responsive_wrap.dart';

class BarPage extends StatefulWidget {
  const BarPage({super.key});

  @override
  State<BarPage> createState() => _BarPageState();
}

class _BarPageState extends State<BarPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
   final breakpoints = ResponsiveBreakpoints.of(context);
        final isDesktop = breakpoints.isDesktop;
        final isTablet = breakpoints.isTablet;    
        return Scaffold(
      appBar: AppBar(
        title: Text('Bar'),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(child: Text("Xatolik: ${viewModel.error}"));
          }
          if (viewModel.products.isEmpty) {
            return Center(
              child: Image.asset('assets/icons/empty-box.png',height: isDesktop ? 400 : isTablet ? 300 :200),
            );
          }

          return ResponsiveWrap(
            children: viewModel.products.map((products) {
              return SizedBox(
                  child: ProductItem(product: products, onTap: () {}));
            }).toList(),
          );
        },
      ),
      floatingActionButton: floatingActionButton(
        ontap: () => BarAddDialog.show(context),
      ),
    );
  }
}
// ListView.builder(
//             itemCount: viewModel.products.length,
//             itemBuilder: (context, index) {
//               final product = viewModel.products[index];
//               debugPrint(viewModel.products.length.toString());
//               return ProductItem(
//                 product: product,
//                 onTap: () {},
//               );
//             },
//           );
