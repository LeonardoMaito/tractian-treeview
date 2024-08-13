import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30,),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text('Assets', style: TextStyle(color: Colors.white)),
        centerTitle: true);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);}
