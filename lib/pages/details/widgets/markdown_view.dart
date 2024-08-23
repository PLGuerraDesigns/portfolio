import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../widgets/spinner.dart';

/// A widget that displays markdown data.
class MarkdownView extends StatefulWidget {
  const MarkdownView({
    super.key,
    required this.markdownData,
  });

  /// The markdown data to display.
  final String markdownData;

  @override
  State<MarkdownView> createState() => _MarkdownViewState();
}

class _MarkdownViewState extends State<MarkdownView> {
  @override
  Widget build(BuildContext context) {
    if (widget.markdownData.isEmpty) {
      return const Spinner();
    }
    return MarkdownBlock(
      data: widget.markdownData,
      config: MarkdownConfig(
        configs: <WidgetConfig>[
          CustomH2Config(
            context: context,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
          PConfig(
            textStyle: Theme.of(context).textTheme.bodyMedium!,
          ),
        ],
      ),
    );
  }
}

/// A custom configuration for the H2 heading.
class CustomH2Config extends H2Config {
  const CustomH2Config({
    super.style = const TextStyle(),
    required this.context,
  });

  final BuildContext context;

  @override
  HeadingDivider? get divider => HeadingDivider(
        color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
        height: 0.01,
      );
}
