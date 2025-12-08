import 'package:flutter/material.dart';
import 'package:timerflow/models/tariff_model.dart';
import 'package:timerflow/utils/extension/responsive_extension.dart';
import 'package:timerflow/utils/extension/theme_extension.dart';

class TariffCard extends StatelessWidget {
  final TariffModel tariff;
  final bool isSelected;

  const TariffCard({
    required this.tariff,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.all(
              context.responsiveValue(mobile: 16, tablet: 24, desktop: 32)),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(
                context.responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius:
                    context.responsiveValue(mobile: 4, tablet: 6, desktop: 8),
                offset: Offset(0,
                    context.responsiveValue(mobile: 2, tablet: 4, desktop: 6)),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/icons/coin.png',
                    height: context.responsiveValue(
                        mobile: 32, tablet: 48, desktop: 64),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: '${tariff.price}\$',
                          style: context.theme.textTheme.displayLarge?.copyWith(
                            fontSize: context.responsiveValue(
                                mobile: 16, tablet: 22, desktop: 28),
                          ),
                        ),
                        TextSpan(
                          text: '/month',
                          style:
                              context.theme.textTheme.displayMedium?.copyWith(
                            fontSize: context.responsiveValue(
                                mobile: 12, tablet: 16, desktop: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: context.responsiveValue(
                      mobile: 12, tablet: 16, desktop: 24)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tariff.description ?? '',
                    style: TextStyle(
                      color: const Color(0xFFC8C8C8),
                      fontSize: context.responsiveValue(
                          mobile: 12, tablet: 14, desktop: 16),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    tariff.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: context.responsiveValue(
                          mobile: 22, tablet: 24, desktop: 28),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FeatureItem(text: "Table count: ${tariff.tableCount}"),
                  FeatureItem(text: "Deadline: 1 month"),
                  FeatureItem(text: "Get report: ${tariff.getReport}"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;
  const FeatureItem({required this.text, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.blue, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
