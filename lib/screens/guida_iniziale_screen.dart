import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../l10n/app_localizations.dart';
import '../widgets/guida_sezioni.dart';

/// Introductory guide shown at the first launch of the app.
///
/// A few swipeable pages: a welcome page followed by the sections of the
/// guide ([SezioneGuida]). When the user completes or skips it, the guide is
/// marked as seen and the app opens the fridge.
class GuidaInizialeScreen extends StatefulWidget {
  const GuidaInizialeScreen({super.key});

  @override
  State<GuidaInizialeScreen> createState() => _GuidaInizialeScreenState();
}

class _GuidaInizialeScreenState extends State<GuidaInizialeScreen> {
  final _pageController = PageController();
  int _pagina = 0;

  /// Set once the guide is being closed, so a double tap closes it once.
  bool _completata = false;

  /// Welcome page plus one page for each section of the guide
  static final _numeroPagine = 1 + SezioneGuida.values.length;

  bool get _ultimaPagina => _pagina == _numeroPagine - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _avanti() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _completa() async {
    if (_completata) return;
    _completata = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(guidaVistaKey, true);
    if (!mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Visibility(
                  visible: !_ultimaPagina,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: TextButton(
                    onPressed: _completa,
                    child: Text(appLoc.guideSkip),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (pagina) => setState(() => _pagina = pagina),
                children: [
                  _PaginaGuida(
                    illustrazione: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.asset(
                        'assets/App_Icons/appicon.png',
                        width: 180.w,
                        height: 180.w,
                      ),
                    ),
                    titolo: appLoc.guideWelcomeTitle,
                    testo: appLoc.guideWelcomeText,
                  ),
                  for (final sezione in SezioneGuida.values)
                    _PaginaGuida(
                      illustrazione: sezione.esempio,
                      titolo: sezione.titolo(appLoc),
                      testo: sezione.testo(appLoc),
                    ),
                ],
              ),
            ),
            _IndicatorePagine(numero: _numeroPagine, corrente: _pagina),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: _ultimaPagina ? _completa : _avanti,
                  child: Text(
                    _ultimaPagina ? appLoc.guideStart : appLoc.guideNext,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A page of the guide: an illustration, a title and a short text,
/// vertically centered and scrollable on small screens.
class _PaginaGuida extends StatelessWidget {
  const _PaginaGuida({
    required this.illustrazione,
    required this.titolo,
    required this.testo,
  });

  final Widget illustrazione;
  final String titolo;
  final String testo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              illustrazione,
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  children: [
                    Text(
                      titolo,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      testo,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dots showing the current page of the guide.
class _IndicatorePagine extends StatelessWidget {
  const _IndicatorePagine({required this.numero, required this.corrente});

  final int numero;
  final int corrente;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < numero; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: i == corrente ? 24.w : 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: i == corrente
                  ? colorScheme.primary
                  : colorScheme.outline.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
