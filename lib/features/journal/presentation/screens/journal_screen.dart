import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

enum _JournalFilter { all, thisWeek, severe, rice }

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  _JournalFilter _selected = _JournalFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.md,
                      ),
                      itemCount: _mockEntries.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) =>
                          _JournalEntry(entry: _mockEntries[index]),
                    ),
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
          onPressed: () => context.go(AppRoutes.scanning),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: AppColors.textOnPrimary),
        ),
      ),
    );
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
              Text("Historique des analyses", style: AppTypography.bodySmall),
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

class _JournalEntryData {
  const _JournalEntryData({
    required this.diseaseName,
    required this.scientificName,
    required this.evolutionLabel,
    required this.evolutionColor,
    required this.evolutionIcon,
  });

  final String diseaseName;
  final String scientificName;
  final String evolutionLabel;
  final Color evolutionColor;
  final IconData evolutionIcon;
}

final _mockEntries = [
  const _JournalEntryData(
    diseaseName: 'Helminthosporiose',
    scientificName: 'Cochliobolus miyabeanus',
    evolutionLabel: 'Évolution : stable',
    evolutionColor: AppColors.severityMedium,
    evolutionIcon: Icons.trending_flat,
  ),
  const _JournalEntryData(
    diseaseName: 'Le faux charbon',
    scientificName: 'Ustilaginoidea virens',
    evolutionLabel: 'Gravité faible',
    evolutionColor: AppColors.severityLow,
    evolutionIcon: Icons.trending_down,
  ),
  const _JournalEntryData(
    diseaseName: 'Flétrissement bactérien',
    scientificName: 'Xanthomonas oryzae',
    evolutionLabel: 'Évolution : stable',
    evolutionColor: AppColors.severityMedium,
    evolutionIcon: Icons.trending_flat,
  ),
  const _JournalEntryData(
    diseaseName: 'Riz Pyriculariose',
    scientificName: 'Magnaporthe oryzae',
    evolutionLabel: 'Évolution : aggravation',
    evolutionColor: AppColors.severityHigh,
    evolutionIcon: Icons.trending_up,
  ),
];

class _JournalEntry extends StatelessWidget {
  const _JournalEntry({required this.entry});

  final _JournalEntryData entry;

  @override
  Widget build(BuildContext context) {
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
                      color: entry.evolutionColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(AppSpacing.xs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          entry.evolutionIcon,
                          color: entry.evolutionColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          entry.evolutionLabel,
                          style: AppTypography.bodySmall.copyWith(
                            color: entry.evolutionColor,
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
