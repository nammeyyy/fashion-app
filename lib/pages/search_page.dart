import 'package:flutter/material.dart';
import 'package:fashion_app/main.dart';

class SearchPage extends StatefulWidget {
  final String? initialQuery;

  const SearchPage({required this.initialQuery, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _performSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isLoading = true;
    });

    // Mock search results - in a real app, this would fetch from Firebase or an API
    Future.delayed(const Duration(milliseconds: 800), () {
      final mockResults = _getMockSearchResults(query);

      setState(() {
        _searchResults = mockResults;
        _isLoading = false;
      });
    });
  }

  List<Map<String, dynamic>> _getMockSearchResults(String query) {
    // In a real app, this would be replaced with actual data fetching logic
    query = query.toLowerCase();

    final allResults = [
      {
        'id': '1',
        'imageUrl': 'assets/images/koreanOutfit1.jpg',
        'title': 'Korean White Shirt Collared',
        'tags': ['white shirt', 'korean', 'collared', 'outfit']
      },
      {
        'id': '2',
        'imageUrl': 'assets/images/koreanOutfit2.jpg',
        'title': 'Summer Blue Blouse',
        'tags': ['blue shirt', 'korean', 'summer', 'blouse']
      },
      {
        'id': '3',
        'imageUrl': 'assets/images/koreanOutfit3.jpg',
        'title': 'Casual Korean Style For Men',
        'tags': ['white shirt', 'korean', 'casual', 'outfit', 'men']
      },
      {
        'id': '4',
        'imageUrl': 'assets/images/koreanOutfit4.jpg',
        'title': 'Korean Minimalist Look',
        'tags': ['black shirt', 'korean', 'minimalist', 'outfit']
      },
      {
        'id': '5',
        'imageUrl': 'assets/images/koreanOutfit5.jpg',
        'title': 'Street Style Korean Fashion',
        'tags': ['korean', 'street style', 'black outfit', 'jacket']
      },
      {
        'id': '6',
        'imageUrl': 'assets/images/koreanOutfit6.jpg',
        'title': 'Pink Satin Dress',
        'tags': ['pink dress', 'satin', 'party', 'outfit']
      },
    ];

    // Filter results based on query
    if (query.isEmpty) {
      return allResults;
    }

    return allResults.where((result) {
      final titleMatches =
          result['title'].toString().toLowerCase().contains(query);
      final tagsMatch = (result['tags'] as List<dynamic>?)
              ?.any((tag) => tag.toString().toLowerCase().contains(query)) ??
          false;
      return titleMatches || tagsMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Search'),
        backgroundColor: const Color(0xFFAAB8FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = [];
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _performSearch(value);
                }
              },
              onChanged: (value) {
                // Optional: Implement real-time search as user types
                if (value.length > 2) {
                  _performSearch(value);
                }
              },
            ),
          ),

          // Popular search chips
          if (_searchResults.isEmpty && !_isLoading)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildSearchChip('white shirt outfit korean'),
                  _buildSearchChip('minimal korean fashion'),
                  _buildSearchChip('summer korean style'),
                  _buildSearchChip('korean casual outfit'),
                ],
              ),
            ),

          // Loading indicator
          if (_isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Search results grid
          if (!_isLoading)
            Expanded(
              child: _searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : _buildSearchResultsGrid(),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          _searchController.text = label;
          _performSearch(label);
        },
        child: Chip(
          backgroundColor: Colors.grey.shade200,
          label: Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return _buildSearchResultItem(result);
      },
    );
  }

  Widget _buildSearchResultItem(Map<String, dynamic> result) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to detail page with this item
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: ${result['title']}')),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            // Image (using Image.asset since we're using mock data)
            Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Image.asset(
                  result['imageUrl'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback for missing images
                    return Container(
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Title overlay at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  result['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
