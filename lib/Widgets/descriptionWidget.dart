import 'package:flutter/cupertino.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(240, 246, 240, 240),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 21, fontFamily: 'Montserrat-Bold'),
      ),
    );
  }
}
