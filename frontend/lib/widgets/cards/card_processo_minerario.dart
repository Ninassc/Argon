import 'package:flutter/material.dart';
import 'package:frontend/models/processo_minerario.dart';

class CardProcessoMinerario extends StatelessWidget {
  final ProcessoMinerario processo;
  const CardProcessoMinerario({super.key, required this.processo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
        side: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Processo",
                      style: TextStyle(color: Color(0xFF848484)),
                    ),
                    Text(processo.processo),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Substância",
                      style: TextStyle(color: Color(0xFF848484)),
                    ),
                    Text(processo.subs),
                  ],
                ),
              ],
            ),

            IconButton(
              onPressed: () {},
              icon: Icon(Icons.open_in_new, color: Color(0xFF5A81FA), size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
