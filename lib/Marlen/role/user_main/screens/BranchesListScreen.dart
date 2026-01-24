// Файл: lib/clinic_list/ui/BranchesListScreen.dart
import 'package:flutter/material.dart';
import 'package:medhealth/styles/app_colors.dart';

import '../../owner_main_screen/dto/BranchDto.dart';
import '../../owner_main_screen/rep/OwnerRep.dart';
import 'DoctorsProfileListScreen.dart';

class BranchesListScreen extends StatefulWidget {
  final int ownerId;
  final String clinicName;
  const BranchesListScreen({super.key, required this.ownerId, required this.clinicName});

  @override
  State<BranchesListScreen> createState() => _BranchesListScreenState();
}

class _BranchesListScreenState extends State<BranchesListScreen> {
  final OwnerRep _rep = OwnerRep();
  List<BranchDto> _branches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBranches();
  }

  void _loadBranches() async {
    _rep.setOwnerId(widget.ownerId);
    final response = await _rep.fetchBranches();
    if (response.code == 200 && response.body is List) {
      setState(() {
        _branches = (response.body as List).map((e) => BranchDto.fromJson(e)).toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(title: Text(widget.clinicName), backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _branches.length,
        itemBuilder: (context, index) {
          final branch = _branches[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PatientDoctorsListScreen(branchId: branch.id, address: branch.address),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.blue.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.blue),
                  const SizedBox(width: 12),
                  Expanded(child: Text(branch.address, style: const TextStyle(fontWeight: FontWeight.w500))),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}