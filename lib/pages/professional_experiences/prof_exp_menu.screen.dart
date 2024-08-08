import 'package:flutter/material.dart';

import '../../common/strings.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/prof_exp_menu.dart';

/// A screen that displays a collection of professional experiences.
class ProfessionalExpMenuScreen extends StatefulWidget {
  const ProfessionalExpMenuScreen({super.key});

  @override
  State<ProfessionalExpMenuScreen> createState() =>
      _ProfessionalExpMenuScreenState();
}

class _ProfessionalExpMenuScreenState extends State<ProfessionalExpMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar.build(
        context: context,
        title: Strings.professionalExperiences,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const ProfessionalExpMenu(),
        ),
      ),
    );
  }
}
