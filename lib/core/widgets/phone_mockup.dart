import 'dart:async';
import 'package:flutter/material.dart';
import '../animations/tilt_3d_card.dart';
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
    return Tilt3DCard(
      maxTiltAngle: 0.07,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: const Color(0xFF141419),
          border: Border.all(
            color: const Color(0xFF2E2E38),
            width: 8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 36,
              offset: const Offset(0, 20),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.08),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              // Screen content
              Positioned.fill(
                child: widget.isPrivate
                    ? _buildPrivateScreen()
                    : _buildLiveScreenshots(),
              ),

              // Glass specular reflection highlight across top right
              Positioned(
                top: 0,
                right: 0,
                width: widget.width * 0.7,
                height: widget.height * 0.45,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white.withValues(alpha: 0.07),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Android Speaker Ear-piece & Punch-hole Camera
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFF09090C),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF1E1E24), width: 1.5),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 36,
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

              // Bottom gesture navigation bar pill
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 72,
                    height: 3.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

    return ListView.builder(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.screenshots.length,
      itemBuilder: (context, index) {
        return Image.asset(
          widget.screenshots[index],
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
      },
    );
  }

  Widget _buildPrivateScreen() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF161622),
            Color(0xFF0D0D14),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x20F59E0B),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0x50F59E0B), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 11, color: Color(0xFFF59E0B)),
                const SizedBox(width: 5),
                Text(
                  'PRIVATE WORK',
                  style: AppTypography.monoLabel(fontSize: 10, color: const Color(0xFFF59E0B))
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            widget.title,
            style: AppTypography.cardTitle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Internal Production App',
            style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: AppColors.border,
          ),
          const SizedBox(height: 16),
          Text(
            'Confirmed Features:',
            style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
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
                      margin: const EdgeInsets.only(top: 4),
                      width: 5,
                      height: 5,
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0x15FFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Production application for operational deployment',
                    style: AppTypography.monoLabel(fontSize: 9, color: AppColors.textMuted),
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
