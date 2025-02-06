import 'package:flutter/material.dart';
import 'package:movie_sphere/module/buttons/elevated_button.dart';

class OnBoardingButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  const OnBoardingButton({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  State<OnBoardingButton> createState() => _OnBoardingButtonState();
}

class _OnBoardingButtonState extends State<OnBoardingButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 150);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: globalElevatedButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
          isLoading: false,
          function: () {
            _controller.forward().then((_) {
              _controller.reverse();
            });
            widget.onTap();
          },
          context: context,
          label: widget.text,
        ),
      ),
    );
  }
}
