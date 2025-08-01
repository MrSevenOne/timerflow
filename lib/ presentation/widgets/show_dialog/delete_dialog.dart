import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String description;

  const DeleteDialog({
    super.key,
    required this.onConfirm,
    this.title = "Oʻchirish",
    this.description = "Haqiqatan ham ushbu mahsulotni oʻchirmoqchimisiz?",
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onConfirm,
    String title = "Oʻchirish",
    String description = "Haqiqatan ham ushbu mahsulotni oʻchirmoqchimisiz?",
  }) async {
    await showDialog(
      context: context,
      builder: (_) => DeleteDialog(
        onConfirm: onConfirm,
        title: title,
        description: description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          Image.asset('assets/icons/information.png', width: 30),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 18.0)),
        ],
      ),
      content: Text(
        description,
        style: const TextStyle(fontSize: 14.0, color: Color(0xFF667085)),
      ),
      actions: [
        Row(
          children: [
            // ❌ Cancel Button
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.grey.withOpacity(0.2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFCFD4DC)),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0C101828),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Bekor qilish',
                        style: TextStyle(
                          color: Color(0xFF344053),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 🗑️ Delete Button
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  borderRadius: BorderRadius.circular(8),
                  splashColor: theme.colorScheme.error,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      border: Border.all(color: theme.colorScheme.error),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0C101828),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Oʻchirish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
