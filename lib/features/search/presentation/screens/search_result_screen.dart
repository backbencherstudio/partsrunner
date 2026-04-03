import 'package:flutter/material.dart';
import 'package:partsrunner/features/search/presentation/widgets/search_result_card.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: TextFormField(
                initialValue: 'Sandy Permata',
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black87),
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Search Result',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  SearchResultCard(
                    title: 'Apple Watch Series 8',
                    id: 'VTY7162E',
                    status: 'Available',
                    receiver: 'Sandy Permata',
                    address: 'Jl.kenanga no 2 batang',
                  ),
                  SizedBox(height: 16),
                  SearchResultCard(
                    title: 'Apple Watch Series 8',
                    id: 'VTY7162E',
                    status: 'In Progress',
                    receiver: 'Sandy Permata',
                    address: 'Jl.kenanga no 2 batang',
                  ),
                  SizedBox(height: 16),
                  SearchResultCard(
                    title: 'Apple Watch Series 8',
                    id: 'VTY7162E',
                    status: 'Completed',
                    receiver: 'Sandy Permata',
                    address: 'Jl.kenanga no 2 batang',
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
