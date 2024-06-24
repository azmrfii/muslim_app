// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  final int selectedIndex;
  final void Function(int) onItemTapped;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final double iconSize = 30.0;
  final double unselectedIconColorOpacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            currentIndex: widget.selectedIndex,
            onTap: widget.onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: widget.selectedIndex == 0
                      ? Color.fromARGB(255, 92, 131, 116)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/bedug.svg',
                  color: widget.selectedIndex == 1
                      ? Color.fromARGB(255, 92, 131, 116)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/kabah.svg',
                  color: widget.selectedIndex == 2
                      ? Color.fromARGB(255, 92, 131, 116)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  color: widget.selectedIndex == 3
                      ? Color.fromARGB(255, 92, 131, 116)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
