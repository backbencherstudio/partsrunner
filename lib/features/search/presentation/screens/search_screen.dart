import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/features/search/presentation/providers/search_provider.dart';
import 'package:partsrunner/features/search/presentation/widgets/search_result_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, required this.query, required this.isContractor});

  final String query;
  final bool isContractor;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchQueryProvider.notifier).state = widget.query;
      ref.read(isContractorProvider.notifier).state = widget.isContractor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final searchResult = ref.watch(searchProvider(query));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
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
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
                initialValue: widget.query,
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: searchResult.when(
                data: (results) {
                  if (results.isEmpty) {
                    return const Center(
                      child: Text('No results found'),
                    );
                  }
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 32),
                    itemCount: results.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final delivery = results[index];
                      return SearchResultCard(
                        title: delivery.packageName ?? 'No Title',
                        id: delivery.id ?? 'N/A',
                        status: delivery.status ?? 'Unknown',
                        receiver: delivery.technicianName ?? 'N/A',
                        address: delivery.deliveryAddress ?? 'N/A',
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFF7A50),
                  ),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
