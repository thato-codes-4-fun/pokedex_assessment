import 'package:flutter/material.dart';
import 'package:pokedex_assessment/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.onPressed, required this.label});
  final Future<void> Function() onPressed;
  final String label;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: context.watch<AuthViewModel>().loading
          ? const SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(),
            )
          : Text(widget.label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
