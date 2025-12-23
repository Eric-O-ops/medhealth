import 'package:flutter/material.dart';

Widget BranchesFilterCard(String branchName, List<String> specializations) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    elevation: 3.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // ⭐️ Название филиала
          Text(
            branchName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),

          // 🏷️ Теги специальностей с использованием Wrap для переноса
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: specializations.map((specialty) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.lightBlue.shade700,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
