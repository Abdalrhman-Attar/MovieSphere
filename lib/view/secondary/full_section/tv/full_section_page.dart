import 'package:flutter/material.dart';
import 'package:movie_sphere/common/my_icons.dart';
import 'package:movie_sphere/module/dynamic_icon_viewer.dart';
import 'package:movie_sphere/widgets/lists/tv/grid_item_list.dart';

class FullSectionPageT extends StatelessWidget {
  const FullSectionPageT({
    super.key,
    required this.title,
    required this.description,
    required this.tvShows,
  });

  final String title;
  final String? description;
  final List<dynamic> tvShows;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: DynamicIconViewer(
            filePath: MyIcons.back,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (description != null) ...[
                Text(
                  description ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
              ],
              GridItemListT(tvShows: tvShows),
            ],
          ),
        ),
      ),
    );
  }
}
