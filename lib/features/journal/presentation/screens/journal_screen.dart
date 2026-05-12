import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/test_keys.dart';
import '../../../scan/domain/entities/scan_result_entity.dart';
import '../../domain/entities/journal_entry_entity.dart';
import '../providers/journal_provider.dart';

enum _JournalFilter { all, thisWeek, severe, rice }

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  _JournalFilter _selected = _JournalFilter.all;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(journalNotifierProvider.notifier).loadEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(journalNotifierProvider);
    final entries = switch (state) {
      JournalLoaded(:final entries) => entries,
      _ => const <JournalEntryEntity>[],
    };

    final filteredEntries = _applyFilter(entries);

    return Scaffold(
      key: const Key(TestKeys.journalScreen),
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          const _JournalHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.cardRadius),
                  topRight: Radius.circular(AppSpacing.cardRadius),
                ),
              ),
              child: Column(
                children: [
                  _FilterTabs(
                    selected: _selected,
                    onSelected: (f) => setState(() => _selected = f),
                  ),
                  Expanded(
                    child: switch (state) {
                      JournalLoading() || JournalInitial() => Center(
                          child: Text(
                            'Chargement du journal...',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      JournalError(:final message) => _JournalErrorState(
                          message: message,
                          onRetry: () => ref
                              .read(journalNotifierProvider.notifier)
                              .loadEntries(),
                        ),
                      _ => _JournalList(entries: filteredEntries),
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Semantics(
        button: true,
        label: 'Nouveau scan',
        child: FloatingActionButton(
          key: const Key(TestKeys.journalNewScanFab),
          onPressed: () => context.go(AppRoutes.scanning),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: AppColors.textOnPrimary),
        ),
      ),
    );
  }

  List<JournalEntryEntity> _applyFilter(List<JournalEntryEntity> entries) {
    final now = DateTime.now();

    return entries.where((entry) {
      return switch (_selected) {
        _JournalFilter.all => true,
        _JournalFilter.thisWeek => now.difference(entry.createdAt).inDays <= 7,
        _JournalFilter.severe => entry.severity == ScanSeverity.high ||
            entry.severity == ScanSeverity.medium,
        _JournalFilter.rice => entry.diseaseName.toLowerCase().contains('riz'),
      };
    }).toList();
  }
}

class _JournalHeader extends StatelessWidget {
  const _JournalHeader();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        topPadding + AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'Retour',
            child: GestureDetector(
              onTap: () => context.go(AppRoutes.home),
              child: const Icon(Icons.arrow_back_ios, size: 22),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Journal agricole', style: AppTypography.headlineMedium),
              Text('Historique des analyses', style: AppTypography.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  const _FilterTabs({
    required this.selected,
    required this.onSelected,
  });

  final _JournalFilter selected;
  final ValueChanged<_JournalFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: 'Tous',
            isSelected: selected == _JournalFilter.all,
            onTap: () => onSelected(_JournalFilter.all),
          ),
          const SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'Cette semaine',
            isSelected: selected == _JournalFilter.thisWeek,
            onTap: () => onSelected(_JournalFilter.thisWeek),
          ),
          const SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'Grave',
            isSelected: selected == _JournalFilter.severe,
            onTap: () => onSelected(_JournalFilter.severe),
          ),
          const SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'Riz',
            isSelected: selected == _JournalFilter.rice,
            onTap: () => onSelected(_JournalFilter.rice),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: isSelected ? AppColors.textOnPrimary : AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _JournalList extends StatelessWidget {
  const _JournalList({required this.entries});

  final List<JournalEntryEntity> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return ListView(
        key: const Key(TestKeys.journalList),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const SizedBox(height: AppSpacing.xl),
          const Icon(
            Icons.bookmark_border,
            size: 56,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Aucun diagnostic enregistré pour ce filtre.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      key: const Key(TestKeys.journalList),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) => _JournalEntry(entry: entries[index]),
    );
  }
}

class _JournalErrorState extends StatelessWidget {
  const _JournalErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}

class _JournalEntry extends StatelessWidget {
  const _JournalEntry({required this.entry});

  final JournalEntryEntity entry;

  @override
  Widget build(BuildContext context) {
    final icon = switch (entry.severity) {
      ScanSeverity.low => Icons.trending_down,
      ScanSeverity.medium => Icons.trending_flat,
      ScanSeverity.high => Icons.trending_up,
    };

    final color = switch (entry.severity) {
      ScanSeverity.low => AppColors.severityLow,
      ScanSeverity.medium => AppColors.severityMedium,
      ScanSeverity.high => AppColors.severityHigh,
    };

    final label = switch (entry.severity) {
      ScanSeverity.low => 'Gravité faible',
      ScanSeverity.medium => 'Évolution stable',
      ScanSeverity.high => 'Évolution aggravée',
    };

    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.cardRadius),
              bottomLeft: Radius.circular(AppSpacing.cardRadius),
            ),
            child: Container(
              width: 116,
              height: 115,
              color: AppColors.primaryLight,
              child:
                  const Icon(Icons.grass, color: AppColors.primary, size: 40),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    entry.diseaseName,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.scientificName,
                    style: AppTypography.bodySmall.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(AppSpacing.xs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: color, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '$label • ${(entry.confidence * 100).toStringAsFixed(0)}%',
                          style: AppTypography.bodySmall.copyWith(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
