import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

class MedicationCardSkeleton extends StatelessWidget {
  const MedicationCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(16),
        vertical: context.setHeight(3),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setMinSize(16)),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Container(
          padding: EdgeInsets.all(context.setWidth(16)),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(context.setMinSize(16)),
          ),
          child: Row(
            children: [
              // circle icon
              Container(
                width: context.setWidth(40),
                height: context.setWidth(40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(width: context.setWidth(12)),

              // text section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: context.setHeight(15),
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    SizedBox(height: context.setHeight(6)),
                    Container(
                      height: context.setHeight(15),
                      width: context.setWidth(120),
                      color: Colors.white,
                    ),
                    SizedBox(height: context.setHeight(6)),
                    Container(
                      height: context.setHeight(10),
                      width: context.setWidth(80),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              SizedBox(width: context.setWidth(15)),

              // status icon
              Container(
                width: context.setWidth(20),
                height: context.setWidth(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}