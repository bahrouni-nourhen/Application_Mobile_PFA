import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SeniorCareApp());
}

class AppColors {
  static const Color primary = Color(0xFF0891b2);
  static const Color primaryDark = Color(0xFF155e75);
  static const Color primaryLight = Color(0xFFe0f7fa);
  static const Color primaryGradientStart = Color(0xFF06b6d4);
  static const Color primaryGradientEnd = Color(0xFF0e7490);
  static const Color success = Color(0xFF10b981);
  static const Color successLight = Color(0xFFd1fae5);
  static const Color warning = Color(0xFFf59e0b);
  static const Color warningLight = Color(0xFFfef3c7);
  static const Color danger = Color(0xFFef4444);
  static const Color dangerLight = Color(0xFFfee2e2);
  static const Color bgBody = Color(0xFFf8fafc);
  static const Color bgCard = Color(0xFFffffff);
  static const Color textMain = Color(0xFF0f172a);
  static const Color textSecondary = Color(0xFF334155);
  static const Color textMuted = Color(0xFF94a3b8);
  static const Color border = Color(0xFFe2e8f0);
  static const Color shadow = Color(0x0a1e293b);
}

class AppShadows {
  static final BoxShadow sm = BoxShadow(color: AppColors.shadow.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2));
  static final BoxShadow md = BoxShadow(color: AppColors.shadow.withOpacity(0.07), blurRadius: 16, offset: const Offset(0, 4));
  static final BoxShadow lg = BoxShadow(color: AppColors.shadow.withOpacity(0.10), blurRadius: 24, offset: const Offset(0, 8));
  static final BoxShadow dangerShadow = BoxShadow(color: AppColors.danger.withOpacity(0.35), blurRadius: 24, offset: const Offset(0, 8));
  static final BoxShadow primaryShadow = BoxShadow(color: AppColors.primary.withOpacity(0.30), blurRadius: 16, offset: const Offset(0, 6));
}

class AppGradients {
  static LinearGradient get primary => const LinearGradient(colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static LinearGradient get subtle => const LinearGradient(colors: [Colors.white, AppColors.bgBody], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static LinearGradient get dangerGrad => const LinearGradient(colors: [Color(0xFFf87171), Color(0xFFdc2626)], begin: Alignment.topLeft, end: Alignment.bottomRight);
}

class AppUser {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  AppUser({required this.uid, required this.fullName, required this.email, required this.phone, required this.role});
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(uid: map['uid'] ?? '', fullName: map['fullName'] ?? '', email: map['email'] ?? '', phone: map['phone'] ?? '', role: map['role'] ?? '');
  }
}

class Patient {
  final String name;
  final int age;
  final String gender;
  final String id;
  final String status;
  final String timeAgo;
  final String? alertMsg;
  Patient({required this.name, required this.age, required this.gender, required this.id, required this.status, required this.timeAgo, this.alertMsg});
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(name: map['name'] ?? '', age: map['age']?.toInt() ?? 0, gender: map['gender'] ?? '', id: map['id'] ?? '', status: map['status'] ?? 'stable', timeAgo: map['timeAgo'] ?? '', alertMsg: map['alertMsg']);
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'age': age, 'gender': gender, 'id': id, 'status': status, 'timeAgo': timeAgo, 'alertMsg': alertMsg};
  }
}

class SectionLabel extends StatelessWidget {
  final String text;
  final IconData? icon;
  const SectionLabel(this.text, {this.icon, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, size: 14, color: AppColors.primaryDark),
            ),
            const SizedBox(width: 8),
          ],
          Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 1.2)),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({required this.status, super.key});
  @override
  Widget build(BuildContext context) {
    Color bg, fg, dotColor;
    String text;
    switch (status) {
      case 'critical': bg = AppColors.dangerLight; fg = const Color(0xFF991b1b); dotColor = AppColors.danger; text = "Critical"; break;
      case 'warning': bg = AppColors.warningLight; fg = const Color(0xFF92400e); dotColor = AppColors.warning; text = "Review"; break;
      default: bg = AppColors.successLight; fg = const Color(0xFF166534); dotColor = AppColors.success; text = "Stable";
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;
  const StatCard({required this.value, required this.label, required this.color, required this.icon, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(16), boxShadow: [AppShadows.md]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textMain, height: 1.2)),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}

class SeniorCareApp extends StatelessWidget {
  const SeniorCareApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeniorCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        scaffoldBackgroundColor: AppColors.bgBody,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: AppColors.textMain)),
        cardTheme: CardThemeData(color: AppColors.bgCard, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.bgBody,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
          labelStyle: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w500),
          hintStyle: const TextStyle(color: AppColors.textMuted),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.subtle),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(24), boxShadow: [AppShadows.primaryShadow]),
                  child: const Icon(FontAwesomeIcons.heartPulse, size: 44, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text("SeniorCare", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800, color: AppColors.textMain, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                Text("Surveillance de santé\nintelligente et préventive", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted, height: 1.5)),
                const Spacer(flex: 3),
                _buildRoleCard(context, icon: FontAwesomeIcons.user, title: "Patient", subtitle: "Surveiller ma santé en temps réel", color: AppColors.primary, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Patient')))),
                const SizedBox(height: 14),
                _buildRoleCard(context, icon: FontAwesomeIcons.houseUser, title: "Famille", subtitle: "Veiller sur mes proches à distance", color: AppColors.success, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Family')))),
                const SizedBox(height: 14),
                _buildRoleCard(context, icon: FontAwesomeIcons.userDoctor, title: "Médecin", subtitle: "Analyser les données patients", color: AppColors.warning, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Doctor')))),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color color, required VoidCallback onTap}) {
    return Material(
      color: AppColors.bgCard,
      borderRadius: BorderRadius.circular(20),
      shadowColor: AppColors.shadow.withOpacity(0.08),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.6))),
          child: Row(
            children: [
              Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: Icon(icon, size: 22, color: color)),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textMain)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.4))])),
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.bgBody, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({super.key, required this.role});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true;
  bool _obscurePassword = true;

  Future<void> _submit() async {
    if (_emailCtrl.text.trim().isEmpty || _passwordCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez remplir tous les champs'), behavior: SnackBarBehavior.floating));
      return;
    }
    if (!_isLogin && (_nameCtrl.text.trim().isEmpty || _phoneCtrl.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez remplir tous les champs'), behavior: SnackBarBehavior.floating));
      return;
    }
    setState(() => _isLoading = true);
    try {
      UserCredential cred;
      if (_isLogin) {
        cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailCtrl.text.trim(), password: _passwordCtrl.text.trim());
      } else {
        cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailCtrl.text.trim(), password: _passwordCtrl.text.trim());
        await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid, 'fullName': _nameCtrl.text.trim(), 'email': _emailCtrl.text.trim(),
          'phone': _phoneCtrl.text.trim(), 'role': widget.role, 'createdAt': FieldValue.serverTimestamp(),
        });
      }
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainLayout(currentIndex: 0, role: widget.role)));
    } catch (e) {
      String msg = "Erreur";
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') msg = 'Aucun compte trouvé.';
        else if (e.code == 'wrong-password') msg = 'Mot de passe incorrect.';
        else if (e.code == 'email-already-in-use') msg = 'Email déjà utilisé.';
        else if (e.code == 'weak-password') msg = 'Mot de passe trop court.';
        else msg = e.message ?? msg;
      }
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: AppColors.danger, behavior: SnackBarBehavior.floating));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() { _emailCtrl.dispose(); _passwordCtrl.dispose(); _nameCtrl.dispose(); _phoneCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final roleIcon = widget.role == 'Doctor' ? FontAwesomeIcons.userDoctor : widget.role == 'Family' ? FontAwesomeIcons.houseUser : FontAwesomeIcons.user;
    final roleColor = widget.role == 'Doctor' ? AppColors.warning : widget.role == 'Family' ? AppColors.success : AppColors.primary;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.subtle),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context)),
                const SizedBox(height: 8),
                Text(_isLogin ? "Connexion" : "Créer un compte", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800, color: AppColors.textMain)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: roleColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(roleIcon, size: 14, color: roleColor), const SizedBox(width: 8), Text("Compte ${widget.role}", style: TextStyle(color: roleColor, fontWeight: FontWeight.w700, fontSize: 13))]),
                ),
                const SizedBox(height: 36),
                AnimatedSize(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut, child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(24), boxShadow: [AppShadows.lg]),
                  child: Column(children: [
                    if (!_isLogin) ...[
                      TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: "Nom complet", hintText: "Dr. Martin Dupont", prefixIcon: Icon(Icons.person_outline_rounded))),
                      const SizedBox(height: 14),
                    ],
                    TextField(controller: _emailCtrl, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: "Email", hintText: "exemple@email.com", prefixIcon: Icon(Icons.mail_outline_rounded))),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _passwordCtrl, obscureText: _obscurePassword,
                      decoration: InputDecoration(labelText: "Mot de passe", hintText: "••••••••", prefixIcon: const Icon(Icons.lock_outline_rounded), suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textMuted), onPressed: () => setState(() => _obscurePassword = !_obscurePassword))),
                    ),
                    if (!_isLogin) ...[
                      const SizedBox(height: 14),
                      TextField(controller: _phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "Téléphone", hintText: "+33 6 12 34 56 78", prefixIcon: Icon(Icons.phone_outlined))),
                    ],
                    const SizedBox(height: 28),
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _isLoading ? null : _submit, child: _isLoading ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)) : Text(_isLogin ? "Se connecter" : "Créer mon compte"))),
                    const SizedBox(height: 16),
                    TextButton(onPressed: () => setState(() => _isLogin = !_isLogin), child: RichText(text: TextSpan(style: const TextStyle(fontSize: 13), children: [TextSpan(text: _isLogin ? "Pas encore de compte ? " : "Déjà un compte ? ", style: const TextStyle(color: AppColors.textMuted)), TextSpan(text: _isLogin ? "S'inscrire" : "Se connecter", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700))])))
                  ]),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainLayout extends StatefulWidget {
  final int currentIndex;
  final String role;
  const MainLayout({super.key, required this.currentIndex, required this.role});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;
  @override void initState() { super.initState(); _currentIndex = widget.currentIndex; }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(duration: const Duration(milliseconds: 250), child: _getBody()),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(24), boxShadow: [AppShadows.lg]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildNavItem(Icons.sensors_rounded, "Accueil", 0), _buildNavItem(Icons.settings_rounded, "Paramètres", 1)]),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(duration: const Duration(milliseconds: 250), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: active ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(16), boxShadow: active ? [AppShadows.primaryShadow] : []),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 20, color: active ? Colors.white : AppColors.textMuted), if (active) ...[const SizedBox(width: 8), Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white))]]),
      ),
    );
  }

  Widget _getBody() {
    if (_currentIndex == 1) return const SettingsScreen(key: ValueKey('settings'));
    if (widget.role == 'Patient') return const PatientDashboard(key: ValueKey('patient'));
    if (widget.role == 'Family') return const FamilyDashboard(key: ValueKey('family'));
    return const DoctorDashboard(key: ValueKey('doctor'));
  }
}

class _PulseAnimation extends StatefulWidget {
  final Widget child;
  const _PulseAnimation({required this.child});
  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  @override
  void initState() { super.initState(); _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true); _scale = Tween<double>(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)); }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ScaleTransition(scale: _scale, child: widget.child);
}

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(24), boxShadow: [AppShadows.primaryShadow]),
              child: Row(
                children: [
                  const CircleAvatar(radius: 26, backgroundColor: Color(0x33ffffff), child: Icon(FontAwesomeIcons.user, color: Colors.white, size: 22)),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bonjour, Mr. Dupont", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text("Chambre 204 • Étage 2", style: TextStyle(color: Color(0xB3ffffff), fontSize: 13)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: const Color(0x33ffffff), borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_rounded, size: 14, color: Colors.white),
                        SizedBox(width: 5),
                        Text("Actif", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: _PulseAnimation(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(gradient: AppGradients.dangerGrad, shape: BoxShape.circle, boxShadow: [AppShadows.dangerShadow]),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.bell, size: 36, color: Colors.white),
                        SizedBox(height: 10),
                        Text("SOS", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 2)),
                        Text("Appuyer en cas d'urgence", style: TextStyle(color: Color(0xB3ffffff), fontSize: 10, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const SectionLabel("Signaux vitaux", icon: FontAwesomeIcons.heartPulse),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(20), boxShadow: [AppShadows.md]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(FontAwesomeIcons.heart, color: AppColors.danger, size: 18),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.success.withOpacity(0.3))),
                              child: const Text("Normal", style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text("Cardiaque", style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 2),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("72", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textMain, height: 1)),
                            SizedBox(width: 4),
                            Padding(padding: EdgeInsets.only(bottom: 4), child: Text("bpm", style: TextStyle(fontSize: 13, color: AppColors.textMuted, fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(20), boxShadow: [AppShadows.md]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(FontAwesomeIcons.personWalking, color: AppColors.primary, size: 18),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.success.withOpacity(0.3))),
                              child: const Text("Normal", style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text("Mouvement", style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 2),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("85", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textMain, height: 1)),
                            SizedBox(width: 4),
                            Padding(padding: EdgeInsets.only(bottom: 4), child: Text("%", style: TextStyle(fontSize: 13, color: AppColors.textMuted, fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(20), boxShadow: [AppShadows.md]),
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.lungs, color: AppColors.warning, size: 20),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SpO2", style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
                        Text("98%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: AppColors.border),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Température", style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
                        Text("36.8°C", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class FamilyDashboard extends StatelessWidget {
  const FamilyDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.success, const Color(0xFF059669)]), borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: AppColors.success.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 6))]),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Famille", style: TextStyle(color: Color(0xB3ffffff), fontSize: 13, fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Text("Tableau de bord", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0x33ffffff), borderRadius: BorderRadius.circular(16)),
                    child: const Icon(FontAwesomeIcons.houseUser, color: Colors.white, size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.success.withOpacity(0.3))),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(FontAwesomeIcons.shieldHeart, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tout va bien", style: TextStyle(color: Color(0xFF166534), fontSize: 16, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text("Aucune anomalie détectée aujourd'hui", style: TextStyle(color: Color(0xFF4ade80), fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 32),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionLabel("Flux en direct", icon: FontAwesomeIcons.video),
            Container(
              decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(20), boxShadow: [AppShadows.md]),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFF1e293b), borderRadius: BorderRadius.circular(14)),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FontAwesomeIcons.video, size: 36, color: Color(0x89ffffff)),
                          SizedBox(height: 8),
                          Text("Connexion caméra...", style: TextStyle(color: Color(0x61ffffff), fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 16),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: AppColors.danger),
                        SizedBox(width: 8),
                        Text("Salon • Caméra 1", style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                        Spacer(),
                        Text("LIVE", style: TextStyle(fontSize: 11, color: AppColors.danger, fontWeight: FontWeight.w800, letterSpacing: 1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionLabel("Proches surveillés", icon: FontAwesomeIcons.users),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(20), boxShadow: [AppShadows.md]),
              child: Row(
                children: [
                  Container(width: 50, height: 50, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(14)), child: const Icon(FontAwesomeIcons.user, color: AppColors.primaryDark, size: 20)),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("M. Dupont", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                        SizedBox(height: 2),
                        Text("Chambre 204 • Dernière activité il y a 5 min", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                  const StatusBadge(status: 'stable'),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});
  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  String selectedFilter = "Tous";
  AppUser? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      FirebaseFirestore.instance.collection('users').doc(uid).snapshots().listen((doc) {
        if (doc.exists && mounted) setState(() => _currentUser = AppUser.fromMap(doc.data()!));
      });
    }
  }

  void _showAddDialog() {
    final nameCtrl = TextEditingController();
    final ageCtrl = TextEditingController();
    String status = 'stable';
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialog) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text("Nouveau patient", style: TextStyle(fontWeight: FontWeight.w700)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nom complet")),
              const SizedBox(height: 12),
              TextField(controller: ageCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Âge")),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: status,
                items: const [
                  DropdownMenuItem(value: "stable", child: Text("Stable")),
                  DropdownMenuItem(value: "warning", child: Text("À surveiller")),
                  DropdownMenuItem(value: "critical", child: Text("Critique")),
                ],
                onChanged: (v) => setDialog(() => status = v!),
                decoration: const InputDecoration(labelText: "Statut initial"),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annuler")),
            ElevatedButton(
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty || ageCtrl.text.trim().isEmpty) return;
                await FirebaseFirestore.instance.collection('patients').add({
                  'name': nameCtrl.text.trim(),
                  'age': int.tryParse(ageCtrl.text.trim()) ?? 0,
                  'gender': 'Homme',
                  'id': '#${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                  'status': status,
                  'timeAgo': 'Maintenant',
                  'alertMsg': status == 'critical' ? 'Nécessite une attention immédiate' : null,
                });
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28))),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0x33ffffff),
                        child: Text(
                          _currentUser?.fullName.isNotEmpty == true ? _currentUser!.fullName.substring(0, 1).toUpperCase() : "D",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_currentUser?.fullName ?? "Médecin", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                            if (_currentUser?.phone != null && _currentUser!.phone.isNotEmpty)
                              Text(_currentUser!.phone, style: const TextStyle(color: Color(0x99ffffff), fontSize: 13)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0x33ffffff), borderRadius: BorderRadius.circular(14)),
                        child: const Icon(FontAwesomeIcons.userDoctor, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                    child: const Row(
                      children: [
                        Icon(FontAwesomeIcons.magnifyingGlass, color: AppColors.textMuted, size: 16),
                        SizedBox(width: 10),
                        Text("Rechercher un patient...", style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Expanded(child: StatCard(value: "17", label: "Total patients", color: AppColors.primary, icon: FontAwesomeIcons.users)),
                  SizedBox(width: 12),
                  Expanded(child: StatCard(value: "2", label: "Critiques", color: AppColors.danger, icon: FontAwesomeIcons.triangleExclamation)),
                  SizedBox(width: 12),
                  Expanded(child: StatCard(value: "15", label: "Stables", color: AppColors.success, icon: FontAwesomeIcons.checkCircle)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ["Tous", "Critiques", "Stables", "À surveiller"].map((label) {
                    final active = selectedFilter == label;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedFilter = label),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: active ? AppColors.primary : AppColors.bgCard,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: active ? AppColors.primary : AppColors.border),
                            boxShadow: active ? [AppShadows.sm] : [],
                          ),
                          child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.textMuted)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('patients').snapshots(),
                builder: (context, snap) {
                  if (snap.hasError) return const Center(child: Text("Erreur de chargement"));
                  if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  if (!snap.hasData || snap.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FontAwesomeIcons.userPlus, size: 48, color: AppColors.textMuted.withOpacity(0.4)),
                          const SizedBox(height: 16),
                          const Text("Aucun patient enregistré", style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                          const SizedBox(height: 8),
                          const Text("Appuyez sur + pour ajouter", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        ],
                      ),
                    );
                  }
                  final patients = snap.data!.docs.map((d) => Patient.fromMap(d.data() as Map<String, dynamic>)).toList();
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: patients.length,
                    itemBuilder: (_, i) => _buildPatientCard(context, patients[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(18), boxShadow: [AppShadows.primaryShadow]),
        child: FloatingActionButton(
          onPressed: _showAddDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _buildPatientCard(BuildContext context, Patient p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(18), boxShadow: [AppShadows.sm]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PatientDetailScreen(patient: p))),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(14)),
                      child: Text(
                        p.name.isNotEmpty ? p.name.substring(0, 1).toUpperCase() : "?",
                        style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textMain)),
                          const SizedBox(height: 3),
                          Text("${p.age} ans • ${p.gender} • ${p.id}", style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                    StatusBadge(status: p.status),
                  ],
                ),
                if (p.alertMsg != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.warningLight, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.triangleExclamation, color: Color(0xFF92400E), size: 14),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            p.alertMsg!,
                            style: const TextStyle(color: Color(0xFF92400E), fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;
  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
              decoration: BoxDecoration(
                gradient: AppGradients.primary,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(Icons.arrow_back_rounded, color: Colors.white), onPressed: () => Navigator.pop(context)),
                      const Text("Détail patient", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      IconButton(icon: const Icon(Icons.more_horiz_rounded, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: const Color(0x33ffffff),
                    child: Text(
                      patient.name.isNotEmpty ? patient.name.substring(0, 1).toUpperCase() : "?",
                      style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(patient.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text("${patient.id} • Chambre 204", style: const TextStyle(color: Color(0x99ffffff), fontSize: 13)),
                  const SizedBox(height: 10),
                  StatusBadge(status: patient.status),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel("Signaux vitaux en temps réel", icon: FontAwesomeIcons.heartPulse),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: const [
                      _VitalCard(icon: FontAwesomeIcons.heart, iconColor: AppColors.danger, value: "72", unit: "bpm", label: "Cardiaque"),
                      _VitalCard(icon: FontAwesomeIcons.gaugeHigh, iconColor: AppColors.warning, value: "145/95", unit: "mmHg", label: "Tension"),
                      _VitalCard(icon: FontAwesomeIcons.lungs, iconColor: AppColors.primary, value: "98", unit: "%", label: "SpO2"),
                      _VitalCard(icon: FontAwesomeIcons.thermometerHalf, iconColor: AppColors.success, value: "36.8", unit: "°C", label: "Température"),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const SectionLabel("Analyse Intelligence Artificielle", icon: FontAwesomeIcons.brain),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(20), boxShadow: [AppShadows.md]),
                    child: const Column(
                      children: [
                        _AIItem(icon: FontAwesomeIcons.personWalking, title: "Analyse de la démarche", desc: "Pattern de marche irrégulier détecté. Risque de chute estimé : 35%", color: AppColors.warning),
                        Divider(height: 24),
                        _AIItem(icon: FontAwesomeIcons.bed, title: "Qualité du sommeil", desc: "Durée de sommeil faible (4h 20m). Recommandation : minimum 6h.", color: AppColors.danger),
                        Divider(height: 24),
                        _AIItem(icon: FontAwesomeIcons.utensils, title: "Habitudes alimentaires", desc: "Repas réguliers détectés. Bonne hydratation.", color: AppColors.success),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const SectionLabel("Prescriptions médicales", icon: FontAwesomeIcons.prescription),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(20), boxShadow: [AppShadows.md]),
                    child: Column(
                      children: [
                        const _MedRow(name: "Amlodipine", dose: "5mg", desc: "1 comprimé le matin avec le petit-déjeuner"),
                        const Divider(height: 24),
                        const _MedRow(name: "Metformine", dose: "500mg", desc: "1 comprimé après le dîner"),
                        const Divider(height: 24),
                        const _MedRow(name: "Paracétamol", dose: "1g", desc: "En cas de douleur, max 3x/jour"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(FontAwesomeIcons.phone, size: 16),
                          label: const Text("Appeler famille"),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(FontAwesomeIcons.commentMedical, size: 16),
                          label: const Text("Envoyer message"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VitalCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String unit;
  final String label;
  const _VitalCard({required this.icon, required this.iconColor, required this.value, required this.unit, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(18), boxShadow: [AppShadows.sm]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textMain, height: 1)),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(unit, style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _AIItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;
  const _AIItem({required this.icon, required this.title, required this.desc, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textMain)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MedRow extends StatelessWidget {
  final String name;
  final String dose;
  final String desc;
  const _MedRow({required this.name, required this.dose, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 36,
          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textMain)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                    child: Text(dose, style: const TextStyle(color: AppColors.primaryDark, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppUser? _user;

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((doc) {
        if (doc.exists && mounted) setState(() => _user = AppUser.fromMap(doc.data()!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(24), boxShadow: [AppShadows.lg]),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(
                      _user?.fullName.isNotEmpty == true ? _user!.fullName.substring(0, 1).toUpperCase() : "?",
                      style: const TextStyle(color: AppColors.primaryDark, fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_user?.fullName ?? "Utilisateur", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textMain)),
                        const SizedBox(height: 4),
                        Text(_user?.email ?? "", style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(6)),
                          child: Text(_user?.role ?? "", style: const TextStyle(fontSize: 11, color: AppColors.primaryDark, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, color: AppColors.textMuted)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (_user?.phone != null && _user!.phone.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(16), boxShadow: [AppShadows.sm]),
                child: Row(
                  children: [
                    const Icon(Icons.phone_rounded, color: AppColors.primary, size: 18),
                    const SizedBox(width: 12),
                    Text(_user!.phone, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            const SizedBox(height: 28),
            const SectionLabel("Paramètres", icon: Icons.tune_rounded),
            _SettingsTile(icon: Icons.notifications_rounded, title: "Notifications", subtitle: "Alertes et rappels", onTap: () {}),
            _SettingsTile(icon: Icons.security_rounded, title: "Sécurité du compte", subtitle: "Mot de passe et 2FA", onTap: () {}),
            _SettingsTile(icon: Icons.palette_rounded, title: "Apparence", subtitle: "Thème et langue", onTap: () {}),
            _SettingsTile(icon: Icons.help_rounded, title: "Aide et support", subtitle: "FAQ et contact", onTap: () {}),
            _SettingsTile(icon: Icons.info_rounded, title: "À propos", subtitle: "Version 1.0.0", onTap: () {}),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.dangerLight, borderRadius: BorderRadius.circular(16)),
              child: TextButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const RoleSelectionScreen()), (route) => false);
                },
                icon: const Icon(Icons.logout_rounded, color: AppColors.danger),
                label: const Text("Se déconnecter", style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _SettingsTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(16), boxShadow: [AppShadows.sm]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: AppColors.primaryDark, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textMain)),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}