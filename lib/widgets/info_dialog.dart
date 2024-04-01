import 'package:flutter/material.dart';

class InfoDialog extends StatefulWidget
{
  String? title, description;

  InfoDialog({super.key, this.title, this.description,});

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      backgroundColor: Colors.grey,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
          ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 12,),
                
                Text(
                  widget.title.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 27,),

                Text(
                  widget.description.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),

                const SizedBox(height: 32,),

                SizedBox(
                  width: 202,
                  child: ElevatedButton(
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "OK"
                    ),
                  ),
                ),

                const SizedBox(height: 12,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
