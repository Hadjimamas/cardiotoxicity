import 'package:flutter/material.dart';

class EducationalMaterial extends StatefulWidget {
  const EducationalMaterial({super.key});

  @override
  EducationalMaterialState createState() => EducationalMaterialState();
}

class EducationalMaterialState extends State<EducationalMaterial> {
  @override
  Widget build(BuildContext context) {
    List<String> breastParts = [
      'Lobules: are glands that produce milk',
      'Ducts: are tubes that carry milk to the nipple',
      'Connective tissue: consists of fibrous and fatty tissue, and supports the structure of the breast'
    ];
    List<String> cardiotoxicity = [
      ' acute, which occurs during or soon after anticancer treatment and is not permanent',
      'chronic, which can be divided into:',
      ' type I (early onset): irreversible heart cell injury and most of the times caused by anthracyclines and other chemo-drugs',
      'type II (late onset): typically caused by biological-targeted antibodies like trastuzumab',
      'myocardial dysfunction and heart failure'
    ];
    List<String> cardiovascular = [
      'coronary artery disease (i.e., heart attack)',
      'valvular disease',
      'heart rhythm problems-arrhythmias',
      'hypertension',
      'thromboembolic events (i.e., blood clots)',
      'peripheral vascular disease and stroke',
      'pulmonary hypertension',
      'pericardial disease',
    ];
    return Scaffold(
        appBar: AppBar(title: const Text('Educational Material')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is breast cancer?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Breast cancer is a disease, in which cells in the breast divide uncontrollably. Based on which part is affected, Breast cancer can be categorized into different types.\n There are three parts of the breast:',
              maxLines: 5,
              style: TextStyle(fontSize: 15),
            ),
            Column(
              children: breastParts.map((strone) {
                return Row(children: [
                  const Text(
                    "\u2022",
                    style: TextStyle(fontSize: 10),
                  ),
                  //bullet text
                  const SizedBox(
                    width: 10,
                  ),
                  //space between bullet and text
                  Expanded(
                    child: Text(
                      strone,
                      style: const TextStyle(fontSize: 10),
                    ), //text
                  )
                ]);
              }).toList(),
            ),
            const Text(
              'The majority of BCs derive from the ducts or lobules',
              style: TextStyle(fontSize: 15),
            ),
            const Text(
              'Main side effect of anti-cancer drugs - cardiotoxicity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Although new emerging treatments for breast cancer in the last decade have increased the overall survival of breast cancer patients, the main unresolved matter remains the lifelong side effects. Among those adverse effects, cardiovascular complications have a high prevalence. Over recent years, it has been proven that patients who undergo cardiotoxic therapies have a greater risk of heart disease, especially if they have multiple comorbidities or a history of cardiovascular disease. According to the National Cancer Institute of United States, cardiotoxicity is defined as ‘’toxicity that affects the heart’’ and may be:',
              maxLines: 15,
              style: TextStyle(fontSize: 15),
            ),
            Column(
              children: cardiotoxicity.map((strone) {
                return Row(children: [
                  const Text(
                    "\u2022",
                    style: TextStyle(fontSize: 10),
                  ),
                  //bullet text
                  const SizedBox(
                    width: 10,
                  ),
                  //space between bullet and text
                  Expanded(
                    child: Text(
                      strone,
                      style: const TextStyle(fontSize: 10),
                    ), //text
                  )
                ]);
              }).toList(),
            ),
            const Text(
              'In general, the cardiovascular side effects of cancer treatment can be categorized into:',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Column(
              children: cardiovascular.map((strone) {
                return Row(children: [
                  const Text(
                    "\u2022",
                    style: TextStyle(fontSize: 10),
                  ),
                  //bullet text
                  const SizedBox(
                    width: 10,
                  ),
                  //space between bullet and text
                  Expanded(
                    child: Text(
                      strone,
                      style: const TextStyle(fontSize: 10),
                    ), //text
                  )
                ]);
              }).toList(),
            ),
          ],
        ));
  }
}
