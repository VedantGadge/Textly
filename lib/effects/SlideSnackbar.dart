import 'package:flutter/material.dart';

class SlideSnackbar extends StatefulWidget {
  final String message;
  const SlideSnackbar({Key? key, required this.message}) : super(key: key);

  @override
  _SlideSnackbarState createState() => _SlideSnackbarState();
}

class _SlideSnackbarState extends State<SlideSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5), // Starts offscreen at the bottom
      end: const Offset(0, -0.5), // Slides into the view
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the slide in animation
    _controller.forward().then((_) {
      // Delay before sliding down
      Future.delayed(const Duration(seconds: 4), () {
        // Slide down animation
        _controller.reverse().then((_) {
          // Remove the overlay after the slide down
        });
      });
    }); // Start the sliding animation
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff1e1e1e).withOpacity(.9),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Text(
            widget.message,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the animation controller
    super.dispose();
  }
}
