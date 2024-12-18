import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Gradient gradient;
  final String text;
  final double heightRatio;
  final double widthRatio;
  final IconData icon;
  final Function() ontap;
  const CustomCard({super.key, required this.gradient, required this.heightRatio, required this.text, required this.ontap, required this.widthRatio, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: ontap,
              child: Container(
                width: MediaQuery.sizeOf(context).width * widthRatio-(16+5),
                height: MediaQuery.sizeOf(context).height * heightRatio-16,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      icon,
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      text,
                      style:const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}