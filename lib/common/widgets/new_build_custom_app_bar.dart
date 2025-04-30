import 'package:flutter/material.dart';

import '../../utils/images.dart';

class NewBuildCustomAppBar extends StatelessWidget {
  const NewBuildCustomAppBar({super.key,required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 116,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover,image: AssetImage(Images.bgAppBar))
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:Column(
          children: [
            const SizedBox(height: 58,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              //spacing: 18,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),

                Text(txt,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xffF5F7F7)),),
                const Text(""),
              ],
            ),
          ],
        ),

      ),

    );
  }
}
