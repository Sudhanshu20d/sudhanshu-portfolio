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
    _autoScrollTimer = Timer.periodic(Duration(milliseconds: 40), (timer) {
      if (!_scrollController.hasClients ||
          !mounted ||
          MediaQuery.disableAnimationsOf(context))
        return;
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
        color: AppColors.surface,
        border: Border.all(color: Color(0xFF2A2A34), width: 6),
        boxShadow: [
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
                        color: Color(0xFF09090C),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF1E1E24),
                          width: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Color(0xFF1A1A22),
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
        color: AppColors.surface,
        child: Center(
          child: Icon(Icons.phone_android, color: AppColors.textDim, size: 48),
        ),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      child: Column(
        children: widget.screenshots.map((screenshot) {
          return Image.asset(
            screenshot,
            semanticLabel: '${widget.title} app screenshot',
            fit: BoxFit.cover,
            width: widget.width,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 400,
                color: AppColors.surface,
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColors.textDim,
                    size: 36,
                  ),
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
      decoration: BoxDecoration(color: AppColors.surface),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
            decoration: BoxDecoration(
              color: AppColors.accentSubtle,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.accentSubtle, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_outline, size: 10, color: AppColors.accent),
                SizedBox(width: 4),
                Text(
                  'CONFIDENTIAL WORK',
                  style: AppTypography.monoLabel(
                    fontSize: 9,
                    color: AppColors.accent,
                  ).copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.8),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          Text(widget.title, style: AppTypography.cardTitle(fontSize: 19)),
          SizedBox(height: 6),
          Text(
            'Internal Enterprise System',
            style: AppTypography.monoLabel(
              fontSize: 10.5,
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: 20),
          Container(height: 1, color: AppColors.hairline),
          SizedBox(height: 16),
          Text(
            'VERIFIED MODULES:',
            style: AppTypography.monoLabel(
              fontSize: 10,
              color: AppColors.accent,
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.privateFeatures.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, i) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.privateFeatures[i],
                        style: AppTypography.bodySmall(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0x0CFFFFFF),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.hairline, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 14,
                  color: AppColors.textMuted,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Proprietary operational distribution workflow',
                    style: AppTypography.monoLabel(
                      fontSize: 8.5,
                      color: AppColors.textMuted,
                    ),
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
