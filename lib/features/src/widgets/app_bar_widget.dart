import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.leading,
    this.action,
    required this.text,
  });

  final String text;
  final Widget? leading;
  final List<Widget>? action;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: widget.leading,
      pinned: true,
      title: Text(widget.text),
      titleTextStyle: Theme.of(context).textTheme.displaySmall,
      actions: widget.action,
    );
  }
}
