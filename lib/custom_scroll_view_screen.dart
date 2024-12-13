import 'package:flutter/material.dart';

class _SliverFixedHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  _SliverFixedHeader({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverFixedHeader oldDelegate) {
    // TODO: implement shouldRebuild
    return oldDelegate.maxHeight != maxHeight || oldDelegate.minHeight != minHeight || oldDelegate.child != child;
  }
  
}

class CustomScrollViewScreen extends StatefulWidget {
  const CustomScrollViewScreen({super.key});

  @override
  State<CustomScrollViewScreen> createState() => _CustomScrollViewScreenState();
}

class _CustomScrollViewScreenState extends State<CustomScrollViewScreen> {
  getColor(index) {
    final color = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    return color[index % color.length];
  }

  renderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: getColor(
              index,
            ),
            height: 100.0,
          );
        },
        childCount: 8,
      ),
    );
  }

  renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: getColor(index),
          );
        },
        childCount: 32,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
    );
  }

  renderSliverAppBaer(){
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200.0,
      flexibleSpace: Image.asset('assets/seoul-night-view.png', fit: BoxFit.cover,),
      pinned: true,
      title: const Text(
        'Seoul',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }

  renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
        delegate: _SliverFixedHeader(
          maxHeight: 200.0,
          minHeight:  75.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black
                ),
              )
            ),
            child: const Center(child: Text('신기방기 동방신기')),
          ),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        renderSliverAppBaer(),
        renderHeader(),
        renderSliverGrid(),
        renderHeader(),
        renderSliverList(),
        renderHeader(),
        renderSliverGrid(),
        renderHeader(),
        renderSliverList(),
      ],
    ));
  }
}
