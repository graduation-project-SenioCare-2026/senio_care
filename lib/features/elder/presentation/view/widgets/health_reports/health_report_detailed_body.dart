import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class HealthReportDetailsBody extends StatelessWidget {
  const HealthReportDetailsBody({super.key});

  static const String _fakeWeeklyReport = '''
# Weekly Health Report
**Period:** 2025-05-23 — 2025-05-29

---

## 📊 Overall Status: 🟡 Needs Attention

Ahmed's general health this week was **moderately stable** but showed some areas of concern. Medication adherence dropped slightly, physical activity was below the recommended level on most days, and dietary patterns had a measurable impact on blood sugar control. No emergency situations were recorded. Continued monitoring and minor lifestyle adjustments are advised for the coming week.

---

## 💊 Medication Report

### ✅ Medications Taken

- **Metformin 500mg** — Taken every morning after breakfast, all 7 days.
- **Amlodipine 5mg** — Taken every evening, all 7 days. Blood pressure remained stable throughout the week.
- **Atorvastatin 20mg** — Taken at bedtime, 6 out of 7 days.

### ❌ Missed Doses

- **Aspirin 81mg** — Missed on Tuesday and Thursday mornings. This increases the short-term risk of platelet aggregation. Caregiver should ensure it is taken consistently with breakfast.
- **Vitamin D3 1000 IU** — Missed 4 out of 7 days. Continued gaps may worsen bone density over time, especially given the patient's history of osteoporosis risk.

> ⚠️ **Important:** Two or more missed doses of Aspirin in a week is considered a moderate concern for patients with cardiovascular history. Please consult the physician if this pattern continues.

---

## 🏃 Exercise & Physical Activity

### What Was Done

- **Monday:** 15-minute morning walk around the garden. Slow pace, no discomfort reported.
- **Wednesday:** Light stretching session for 10 minutes with the caregiver's assistance.
- **Friday:** 20-minute walk at the nearby park. Patient reported feeling slightly fatigued afterward but recovered within 30 minutes.
- **Sunday:** No activity. Patient preferred to rest.

### Days With No Activity

Tuesday, Thursday, and Saturday had no recorded physical movement beyond routine daily tasks.

### Impact on Health Conditions

Ahmed has **Type 2 Diabetes** and **mild hypertension**. Regular walking helps improve insulin sensitivity and lowers resting blood pressure. This week's activity level is below the recommended 30 minutes per day. Blood sugar readings on inactive days (Tuesday, Thursday) were slightly higher than on active days, which is consistent with reduced glucose metabolism during rest.

> 💡 **Recommendation:** Aim for at least a 15-minute walk every day, even if light. Consistency matters more than intensity for Ahmed's condition.

---

## 🍽️ Nutrition & Meals

### Meals This Week

- **Breakfast** was consistent most days — typically included eggs, bread, and tea. Skipped on Thursday morning.
- **Lunch** was the main meal each day. Included rice, cooked vegetables, and either chicken or lentils on most days.
- **Dinner** was lighter — mostly soup or yogurt with bread. Skipped twice this week (Monday and Saturday evenings).

### Concerning Patterns

- **High carbohydrate intake:** Rice was consumed at lunch every single day. For a diabetic patient, this contributes to post-meal blood sugar spikes. Consider replacing white rice with smaller portions or adding more fiber-rich vegetables alongside it.
- **Low protein on some days:** Wednesday and Thursday lunches were mainly bread and cheese, lacking sufficient protein for muscle maintenance at his age.
- **Sweets:** Ahmed had a small piece of baklava on Friday. While occasional, this directly impacts blood sugar control.

### Impact on Existing Conditions

**Diabetes:** The combination of missed Metformin doses on two mornings and high-carb meals pushed fasting glucose slightly above target on Thursday (recorded at 138 mg/dL). This is a mild but notable deviation.

**Hypertension:** Salt intake appeared moderate this week with no alarming spikes in blood pressure. The Amlodipine adherence helped maintain stable readings.

**General energy levels:** Skipping dinner twice likely contributed to the mild fatigue reported during Friday's walk.

> 💡 **Recommendation:** Reduce rice portion at lunch to half a cup and add a side of cucumber or leafy greens. Avoid sweets during the week and keep them to a maximum of once per week.

---

## 📋 Summary & Action Points for Next Week

- Ensure **Aspirin** is placed visibly next to the breakfast items as a reminder.
- Restock **Vitamin D3** — current supply appears to have run low.
- Add a **short walk** to Tuesday and Thursday routines, even 10 minutes is beneficial.
- Adjust lunch to include **less white rice** and more vegetables or legumes.
- Schedule a **physician follow-up** if missed Aspirin doses continue.

---

*Report generated by SenioCare AI • 29 May 2026*
''';

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: _fakeWeeklyReport,
      styleSheet: MarkdownStyleSheet(
        p: getRegularStyle(
          color:    AppColors.black,
          fontSize: context.setSp(FontSize.s14),
        ),
        h1: getBoldStyle(
          color:    AppColors.black,
          fontSize: context.setSp(FontSize.s22),
        ),
        h2: getBoldStyle(
          color:    AppColors.black,
          fontSize: context.setSp(FontSize.s20),
        ),
        h3: getBoldStyle(
          color:    AppColors.black,
          fontSize: context.setSp(FontSize.s18),
        ),
        strong: getBoldStyle(
          color:    AppColors.black,
          fontSize: context.setSp(FontSize.s14),
        ),
        listBullet: getRegularStyle(
          color:    AppColors.black,
          fontSize: context.setSp(FontSize.s14),
        ),
        blockquoteDecoration: BoxDecoration(
          color:        AppColors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(color: AppColors.blue, width: 4),
          ),
        ),
      ),
      padding: EdgeInsets.all(context.setWidth(20)),
    );
  }
}