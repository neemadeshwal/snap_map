import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/core/services/app_lifecycle_manager.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_event.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_state.dart';
import 'package:snapmap/features/home/presentation/screens/feeds_screen.dart';
import 'package:snapmap/features/home/presentation/screens/map_screen.dart';
import 'package:snapmap/generated/app_localizations.dart';
import 'package:snapmap/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late AppLifecycleManager _appLifecycleManager;
  late ScrollController _scrollController;
  DateTime? _lastPressed;

  static const double COLLAPSE_THRESHOLD = 0.8;
  double _scrollProgress = 0.0;
  bool _pillLocked = false;
  static const double MAP_MAX_HEIGHT = 300;
  static const double LOCATION_PILL_HEIGHT = 64;

  @override
  void initState() {
    super.initState();
    _appLifecycleManager = sl<AppLifecycleManager>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _handleSignout() {
    context.read<AuthBloc>().add(SignoutRequested());
  }

  void _recordUserActivity() {
    _appLifecycleManager.recordUserActivity();
  }

  void _onScroll() {
    final scrollY = _scrollController.offset;
    final progress = (scrollY / 300).clamp(0.0, 1.0);

    setState(() {
      _scrollProgress = progress;
      if (progress > COLLAPSE_THRESHOLD && !_pillLocked) {
        _pillLocked = true;
      }
      if (scrollY == 0) {
        _pillLocked = false;
      }
    });
  }

  void _expandMap() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SessionExpired) {
          context.read<AuthBloc>().add(ReauthenticateWithBiometricRequested());
        } else if (state is AuthSessionRefreshed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizations.sessionRefreshed),
            ), // <-- Localized
          );
        } else if (state is Unauthenticated) {
          context.go(RouteConstants.signin);
        }
      },
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MAP_MAX_HEIGHT,
                collapsedHeight: LOCATION_PILL_HEIGHT,
                flexibleSpace: const FlexibleSpaceBar(
                  background: MapScreen(),
                  collapseMode: CollapseMode.parallax,
                ),
              ),
              FeedsScreen(localizations: localizations),
            ],
          ),
          Positioned(
            top: 20,
            right: 0,
            child: CustomButton.primary(
              text: localizations.logout, // <-- Localized
              onPressed: _handleSignout,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _scrollProgress > COLLAPSE_THRESHOLD ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _scrollProgress > COLLAPSE_THRESHOLD
                    ? LOCATION_PILL_HEIGHT
                    : 0,
                child: _LocationPill(
                  onTap: _expandMap,
                  localizations:
                      localizations, // <-- Passed down to the stateless widget
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationPill extends StatelessWidget {
  final VoidCallback onTap;
  final AppLocalizations localizations; // <-- Added localizations parameter

  const _LocationPill({required this.onTap, required this.localizations});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFe0f4f7),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF006175),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF006175).withOpacity(0.2),
                          blurRadius: 4,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations
                        .yourLocation, // <-- Localized (e.g., 'YOUR LOCATION')
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.06,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 10,
                        color: Color(0xFF006175),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          localizations
                              .currentCity, // <-- Localized (e.g., 'Indiranagar, Bengaluru')
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0c2528),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFe0f4f7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.expand_less,
                size: 14,
                color: Color(0xFF006175),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
