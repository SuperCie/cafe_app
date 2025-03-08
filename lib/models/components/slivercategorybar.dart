import 'package:coffee_app/models/components/categorybar.dart';
import 'package:flutter/material.dart';

class Slivercategorybar extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 90;
  @override
  double get minExtent => 80;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Categorybar();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
