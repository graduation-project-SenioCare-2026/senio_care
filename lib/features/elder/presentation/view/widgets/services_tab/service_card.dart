import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/user_manager.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserManager().user;
    return CustomCard(
      enableElevation: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                 CircleAvatar(
                   radius: 30,
                   child: ClipRRect(
                     borderRadius: BorderRadiusGeometry.circular(30),
                     child: Image.network(
                       user!.avatar!,
                       height: context.setHeight(80),
                       width: context.setWidth(80),
                     ),
                   ),
                 ),
                                SizedBox(width: context.setWidth(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name!,
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(14),
                      ),
                    ),
                    Text("Medical Massage Therapy",
                      style: getRegularStyle(
                        color: AppColors.gray[700]!,
                        fontSize: context.setSp(14),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,size: context.setMinSize(20),color: Colors.amber,),
                        Icon(Icons.star,size: context.setMinSize(20),color: Colors.amber,),
                        Icon(Icons.star,size: context.setMinSize(20),color: Colors.amber,),
                        Icon(Icons.star,size: context.setMinSize(20),color: Colors.grey.shade300,),

                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: context.setHeight(10),),
            Text(
              "Specialized in therapeutic massage for seniors with arthritis and mobility issues.\n20+ years experience.",
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(14),
              ),
            ),
            SizedBox(height: context.setHeight(10)),
            Row(
              children: [
                Image.asset(
                  AppIcons.phone,
                  height: context.setHeight(15),
                  width: context.setWidth(15),
                ),
                SizedBox(width: context.setWidth(15)),
                Text(
                  "01142104052",
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(14),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  AppIcons.location,
                  height: context.setHeight(15),
                  width: context.setWidth(15),
                ),
                SizedBox(width: context.setWidth(15)),
                Text(
                  "Downtown Medical Center",
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(14),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: context.setHeight(10)),
              child: CustomElevatedButton(
                onPressed: (){},
                buttonLabel: "contactProvider".tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
