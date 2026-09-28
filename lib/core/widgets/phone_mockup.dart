import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class PhoneMockup extends StatefulWidget {
  final List<String> screenshots;
  final bool isPrivate;
  final String title;
  final List<String> privateFeatures;
  final double width;
  final double height;

  const PhoneMockup({
    super.key,
    required this.screenshots,
    this.isPrivate = false,
    this.title = '',
    this.privateFeatures = const [],
    this.width = 280,
    this.height = 560,
  });

  @override
  State<PhoneMockup> createState() => _PhoneMockupState();
}

class _PhoneMockupState extends State<PhoneMockup> {
  late final ScrollController _scrollController;
  Timer? _autoScrollTimer;
  bool _isReversing = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (!widget.isPrivate && widget.screenshots.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (!_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      if (max <= 0) return;

      final current = _scrollController.offset;
      if (current >= max - 2) {
        _isReversing = true;
      } else if (current <= 2) {
        _isReversing = false;
      }

      final nextOffset = _isReversing ? current - 1.2 : current + 1.2;
      _scrollController.jumpTo(nextOffset.clamp(0.0, max));
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xFF141419),
        border: Border.all(
          color: const Color(0xFF2A2A34),
          width: 6,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            // Screen content
            Positioned.fill(
              child: widget.isPrivate
                  ? _buildPrivateScreen()
                  : _buildLiveScreenshots(),
            ),

            // Top Status Bar Speaker & Camera Punch-hole
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: const Color(0xFF09090C),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF1E1E24), width: 1.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A22),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Pill
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 68,
                  height: 3.5,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveScreenshots() {
    if (widget.screenshots.isEmpty) {
      return Container(
        color: const Color(0xFF0F0F14),
        child: const Center(
          child: Icon(Icons.phone_android, color: AppColors.textDim, size: 48),
        ),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      child: Column(
        children: widget.screenshots.map((screenshot) {
          return Image.asset(
            screenshot,
            fit: BoxFit.cover,
            width: widget.width,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 400,
                color: const Color(0xFF16161D),
                child: const Center(
                  child: Icon(Icons.image_outlined, color: AppColors.textDim, size: 36),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPrivateScreen() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF101016),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
            decoration: BoxDecoration(
              color: const Color(0x1DF59E0B),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0x40F59E0B), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 10, color: Color(0xFFF59E0B)),
                const SizedBox(width: 4),
                Text(
                  'CONFIDENTIAL WORK',
                  style: AppTypography.monoLabel(fontSize: 9, color: const Color(0xFFF59E0B))
                      .copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            widget.title,
            style: AppTypography.cardTitle(fontSize: 19),
          ),
          const SizedBox(height: 6),
          Text(
            'Internal Enterprise System',
            style: AppTypography.monoLabel(fontSize: 10.5, color: AppColors.textMuted),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: AppColors.hairline,
          ),
          const SizedBox(height: 16),
          Text(
            'VERIFIED MODULES:',
            style: AppTypography.monoLabel(fontSize: 10, color: AppColors.accent),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.privateFeatures.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.privateFeatures[i],
                        style: AppTypography.bodySmall(color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0x0CFFFFFF),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.hairline, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, size: 14, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Proprietary operational distribution workflow',
                    style: AppTypography.monoLabel(fontSize: 8.5, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
