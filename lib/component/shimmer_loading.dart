import 'package:digital_business/component/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // Collect ancestor shimmer information.
    final shimmer = Shimmer.of(context);
    if (shimmer?.isSized == false) {
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer?.size;
    final gradient = shimmer?.gradient;
    final offsetWithinShimmer = shimmer?.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient!.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer!.dx,
            -offsetWithinShimmer.dy,
            shimmerSize!.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}
