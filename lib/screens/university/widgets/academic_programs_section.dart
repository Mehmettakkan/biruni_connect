import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/screens/university/models/faculty.dart';
import 'package:biruni_connect/screens/university/models/academic_program.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';

/// Akademik programları fakülte bazlı gösteren bölüm widget'ı.
/// Fakülte seçimine göre ilgili programları listeler.
class AcademicProgramsSection extends StatefulWidget {
  /// Gösterilecek fakülte listesi
  final List<Faculty> faculties;

  /// Gösterilecek program listesi
  final List<AcademicProgram> programs;

  const AcademicProgramsSection({
    super.key,
    required this.faculties,
    required this.programs,
  });

  @override
  State<AcademicProgramsSection> createState() =>
      _AcademicProgramsSectionState();
}

class _AcademicProgramsSectionState extends State<AcademicProgramsSection> {
  /// Seçili fakültenin ID'si
  String? selectedFacultyId;

  /// Detayları gösterilen programın ID'si
  String? expandedProgramId;

  /// Seçili fakülteye ait programları filtreleme
  List<AcademicProgram> _getSelectedFacultyPrograms() {
    if (selectedFacultyId == null) return [];
    return widget.programs
        .where((program) => program.facultyId == selectedFacultyId)
        .toList();
  }

  /// Başlık bölümünü oluşturan widget
  Widget _buildHeader(bool isDark) {
    return Row(
      children: [
        Icon(
          Icons.school,
          size: UIConstants.iconL,
          color: isDark ? AppColors.primaryDark : AppColors.primary,
        ),
        context.horizontalSpaceM,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Akademik Programlar',
                style: AppTextStyles.h2(isDark: isDark),
              ),
              context.spaceXS,
              Text(
                'Fakülte seçerek programları görüntüleyebilirsiniz',
                style: AppTextStyles.bodyMedium(
                  isDark: isDark,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Fakülte kartını oluşturan widget
  /// Ekran genişliğine göre responsive tasarım sunar
  Widget _buildFacultyCard(Faculty faculty, bool isSelected, bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 200;

        return CustomCard(
          type: CustomCardType.info,
          onTap: () => setState(() {
            selectedFacultyId = isSelected ? null : faculty.id;
            expandedProgramId = null;
          }),
          padding: EdgeInsets.all(
              isSmallScreen ? UIConstants.paddingS : UIConstants.paddingM),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark ? AppColors.primaryDark : AppColors.primary)
                      .withOpacity(UIConstants.opacityHover)
                  : Colors.transparent,
              borderRadius: context.radiusL,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Fakülte ikonu
                Icon(
                  Icons.account_balance,
                  size: isSmallScreen ? UIConstants.iconM : UIConstants.iconL,
                  color: isSelected
                      ? (isDark ? AppColors.primaryDark : AppColors.primary)
                      : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary),
                ),
                context.spaceS,
                // Fakülte adı
                Text(
                  faculty.name,
                  style: (isSmallScreen
                      ? AppTextStyles.bodyMedium
                      : AppTextStyles.bodyLarge)(
                    isDark: isDark,
                    color: isSelected
                        ? (isDark ? AppColors.primaryDark : AppColors.primary)
                        : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                context.spaceXS,
                // Program sayısı rozeti
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen
                        ? UIConstants.paddingXS
                        : UIConstants.paddingS,
                    vertical: UIConstants.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.primaryDark : AppColors.primary)
                        .withOpacity(UIConstants.opacityHover),
                    borderRadius: context.radiusS,
                  ),
                  child: Text(
                    '${faculty.programIds.length} Program',
                    style: AppTextStyles.caption(
                      isDark: isDark,
                      color: isDark ? AppColors.primaryDark : AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Seçili fakültenin programlarını listeleyen widget
  Widget _buildProgramsList(bool isDark) {
    final programs = _getSelectedFacultyPrograms();
    final selectedFaculty =
        widget.faculties.firstWhere((f) => f.id == selectedFacultyId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${selectedFaculty.name} Programları',
          style: AppTextStyles.h3(isDark: isDark),
        ),
        context.spaceM,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: programs.length,
          separatorBuilder: (_, __) => context.spaceM,
          itemBuilder: (context, index) {
            final program = programs[index];
            return _buildProgramCard(program, isDark);
          },
        ),
      ],
    );
  }

  /// Program kartını oluşturan widget
  /// Genişletilebilir yapıda detaylı bilgi gösterir
  Widget _buildProgramCard(AcademicProgram program, bool isDark) {
    final isExpanded = expandedProgramId == program.id;

    return CustomCard(
      type: CustomCardType.program,
      onTap: () => setState(() {
        expandedProgramId = isExpanded ? null : program.id;
      }),
      padding: context.paddingM,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.name,
                      style: AppTextStyles.h4(isDark: isDark),
                    ),
                    context.spaceXS,
                    Text(
                      program.degree,
                      style: AppTextStyles.bodyMedium(
                        isDark: isDark,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDurationBadge(program.duration, isDark),
            ],
          ),
          // Genişletilebilir içerik bölümü
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.spaceM,
                const Divider(),
                context.spaceM,
                Text(
                  program.description,
                  style: AppTextStyles.bodyMedium(isDark: isDark),
                ),
                context.spaceM,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildInfoChip(Icons.language, program.language, isDark),
                      context.horizontalSpaceM,
                      _buildInfoChip(Icons.school, program.degree, isDark),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  /// Program süresini gösteren rozet widget'ı
  Widget _buildDurationBadge(String duration, bool isDark) {
    return Container(
      padding: context.paddingS,
      decoration: BoxDecoration(
        color: (isDark ? AppColors.primaryDark : AppColors.primary)
            .withOpacity(UIConstants.opacityHover),
        borderRadius: context.radiusM,
      ),
      child: Text(
        duration,
        style: AppTextStyles.caption(
          isDark: isDark,
          color: isDark ? AppColors.primaryDark : AppColors.primary,
        ),
      ),
    );
  }

  /// Bilgi çipi oluşturan yardımcı widget (dil ve derece için)
  Widget _buildInfoChip(IconData icon, String label, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: UIConstants.paddingM,
        vertical: UIConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.primaryDark : AppColors.primary)
            .withOpacity(0.08),
        borderRadius: context.radiusM,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: UIConstants.iconS,
            color: isDark ? AppColors.primaryDark : AppColors.primary,
          ),
          context.horizontalSpaceXS,
          Text(
            label,
            style: AppTextStyles.caption(
              isDark: isDark,
              color: isDark ? AppColors.primaryDark : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return CustomCard(
      type: CustomCardType.elevated,
      padding: context.paddingL,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(isDark),
          context.spaceL,
          // Responsive fakülte grid görünümü
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900
                  ? 4
                  : constraints.maxWidth > 600
                      ? 3
                      : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: UIConstants.spacingM,
                  mainAxisSpacing: UIConstants.spacingM,
                  childAspectRatio: constraints.maxWidth > 600 ? 1.5 : 1.2,
                ),
                itemCount: widget.faculties.length,
                itemBuilder: (context, index) {
                  final faculty = widget.faculties[index];
                  final isSelected = selectedFacultyId == faculty.id;
                  return _buildFacultyCard(faculty, isSelected, isDark);
                },
              );
            },
          ),
          // Seçili fakültenin programlarını göster
          if (selectedFacultyId != null) ...[
            context.spaceL,
            _buildProgramsList(isDark),
          ],
        ],
      ),
    );
  }
}
