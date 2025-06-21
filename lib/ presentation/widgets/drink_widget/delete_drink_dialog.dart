import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_viewmodel.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class DeleteDrinkDialog extends StatelessWidget {
  final DrinkModel drinkModel;
  const DeleteDrinkDialog({super.key, required this.drinkModel});

  static Future<void> show(BuildContext context, {required DrinkModel drinkModel}) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  Text("delete_drink".tr),
        content: Text('${drinkModel.name} ${'drink_delete_want'.tr}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text("cencal".tr),
          ),
          TextButton(
            onPressed: () async {
              final provider = Provider.of<DrinkViewModel>(context, listen: false);
              await provider.deleteDrink(drinkModel.id!);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child:  Text('confirmation'.tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
