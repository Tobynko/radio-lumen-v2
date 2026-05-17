import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';
import 'package:radio_lumen_v2/features/schedule/models/show.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedDayIndex = 0;
  late final List<DateTime> _days;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final today = DateTime.now();
    // Generate 7 days starting from today
    _days = List.generate(7, (index) => today.add(Duration(days: index)));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getSlovakWeekday(int weekday) {
    switch (weekday) {
      case 1: return 'PO';
      case 2: return 'UT';
      case 3: return 'ST';
      case 4: return 'ŠT';
      case 5: return 'PI';
      case 6: return 'SO';
      case 7: return 'NE';
      default: return '';
    }
  }

  // --- DUMMY DATA FOR UI PREVIEW ---
  List<ScheduleItem> _getDummySchedule() {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    return [
      ScheduleItem(
        id: '1',
        title: 'Ranné spojenie',
        description: 'Ranný prúd hudby a slova s ranným zamyslením.',
        startTime: DateTime(today.year, today.month, today.day, 6, 0),
        endTime: DateTime(today.year, today.month, today.day, 9, 0),
        show: const Show(id: 's1', title: 'Ranné spojenie', description: '', host: 'Ján Krupa'),
        tags: const ['Naživo', 'Ráno'],
      ),
      ScheduleItem(
        id: '2',
        title: 'Lumenáda',
        description: 'Dopoludňajšie vysielanie plné zaujímavých hostí a tém.',
        startTime: DateTime(today.year, today.month, today.day, 9, 0),
        endTime: DateTime(today.year, today.month, today.day, 12, 0),
        show: const Show(id: 's2', title: 'Lumenáda', description: '', host: 'Mária Škovierová'),
        tags: const ['Zábava'],
      ),
      ScheduleItem(
        id: '3',
        title: 'Modlitba Anjel Pána',
        description: 'Spoločná modlitba napoludnie pre celú komunitu.',
        startTime: DateTime(today.year, today.month, today.day, 12, 0),
        endTime: DateTime(today.year, today.month, today.day, 12, 15),
        tags: const ['Modlitba', 'Duchovné slovo'],
      ),
      ScheduleItem(
        id: '4',
        title: 'Zaostrené',
        description: 'Analýza aktuálnych spoločenských a náboženských tém.',
        startTime: DateTime(today.year, today.month, today.day, 13, 0),
        endTime: DateTime(today.year, today.month, today.day, 14, 0),
        show: const Show(id: 's3', title: 'Zaostrené', description: '', host: 'Pavol Jurčo'),
        tags: const ['Publicistika'],
      ),
      ScheduleItem(
        id: '5',
        title: 'Ranné spojenie (zajtra)',
        description: 'Zajtrajšie ranné spojenie s novými témami.',
        startTime: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 6, 0),
        endTime: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 9, 0),
        show: const Show(id: 's1', title: 'Ranné spojenie', description: '', host: 'Ján Krupa'),
        tags: const ['Naživo', 'Ráno'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: LumenBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildModernTabBar(),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: Program
                    Column(
                      children: [
                        _buildDaysFilter(),
                        const SizedBox(height: 16),
                        Expanded(child: _buildScheduleList(_getDummySchedule())),
                      ],
                    ),
                    // Tab 2: Playlisty
                    _buildPlaylistsPreview(),
                    // Tab 3: Relácie (Shows)
                    _buildShowsPreview(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Center(
        child: Image.asset(
          'assets/logos/logo.png',
          height: 128, // Made twice as large as requested
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildModernTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.accentGold,
          boxShadow: [
            BoxShadow(
              color: AppColors.accentGold.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: AppColors.primary,
        labelStyle: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
        unselectedLabelStyle: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
        tabs: const [
          Tab(text: 'Program'),
          Tab(text: 'Playlisty'),
          Tab(text: 'Relácie'),
        ],
      ),
    );
  }

  Widget _buildDaysFilter() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final date = _days[index];
          final isSelected = index == _selectedDayIndex;
          
          final dayStr = _getSlovakWeekday(date.weekday);
          final dateStr = DateFormat('d.M.').format(date);
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accentGold : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? AppColors.accentGold : Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.accentGold.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  '$dayStr $dateStr',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.85),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleList(List<ScheduleItem> allItems) {
    final selectedDate = _days[_selectedDayIndex];
    final items = allItems.where((item) {
      return item.startTime.year == selectedDate.year &&
             item.startTime.month == selectedDate.month &&
             item.startTime.day == selectedDate.day;
    }).toList();

    items.sort((a, b) => a.startTime.compareTo(b.startTime));

    if (items.isEmpty) {
      return Center(
        child: Text(
          'Na tento deň nie je dostupný program.',
          style: AppTextStyles.bodyLarge.copyWith(color: Colors.white.withValues(alpha: 0.7)),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 8),
      itemCount: items.length,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Divider(color: Colors.white.withValues(alpha: 0.15), height: 1),
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final startTimeStr = DateFormat('HH:mm').format(item.startTime);
        
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Column
            SizedBox(
              width: 65,
              child: Text(
                startTimeStr,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Show Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.show?.host != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.mic, size: 16, color: AppColors.accentTeal.withValues(alpha: 0.9)),
                        const SizedBox(width: 6),
                        Text(
                          item.show!.host!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.accentTeal.withValues(alpha: 0.9),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  // Mocked content tag / category
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildTag('Duchovné slovo'),
                      if (index % 2 == 0) _buildTag('Naživo'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlaylistsPreview() {
    final dummyPlaylists = [
      {'title': 'Ranná káva', 'tracks': '12 skladieb', 'icon': Icons.coffee},
      {'title': 'Pokojný večer', 'tracks': '25 skladieb', 'icon': Icons.nightlight_round},
      {'title': 'Chvály a uctievanie', 'tracks': '40 skladieb', 'icon': Icons.music_note},
      {'title': 'Víkendový relax', 'tracks': '18 skladieb', 'icon': Icons.weekend},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: dummyPlaylists.length,
      itemBuilder: (context, index) {
        final playlist = dummyPlaylists[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.accentGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(playlist['icon'] as IconData, color: AppColors.accentGold, size: 28),
            ),
            title: Text(
              playlist['title'] as String,
              style: AppTextStyles.titleLarge.copyWith(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(
              playlist['tracks'] as String,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.6)),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.white54),
          ),
        );
      },
    );
  }

  Widget _buildShowsPreview() {
    final dummyShows = [
      'Lumenáda', 'Ranné spojenie', 'Zaostrené', 'Svetielko', 'Karmel', 'Svetlo nádeje'
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: dummyShows.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.5),
                  border: Border.all(color: AppColors.accentGold, width: 2),
                ),
                child: const Icon(Icons.headset_mic, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  dummyShows[index],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 11,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
