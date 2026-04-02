import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SeniorCareApp());
}

// ═══════════════════════════════════════════
//           TRADUCTION (i18n)
// ═══════════════════════════════════════════
class L {
  static String lang = 'en';
  static String t(String key) {
    final Map<String, Map<String, String>> map = {
      'en': {
        'welcome': 'Welcome',
        'room': 'Room 204 • Floor 2',
        'press_emergency': 'Press in case of emergency',
        'my_treatments': 'My Treatments',
        'no_treatments': 'No treatments prescribed.',
        'take_at': 'Take at',
        'vital_signs': 'Vital Signs',
        'heart_rate': 'Heart Rate',
        'movement': 'Movement',
        'normal': 'Normal',
        'welcome_doc': 'Welcome,',
        'search': 'Search patients...',
        'all': 'All',
        'critical': 'Critical',
        'stable': 'Stable',
        'review': 'Review',
        'no_patients': 'No registered patients.',
        'press_add': 'Press + to add',
        'dashboard': 'Dashboard',
        'everything_fine': 'Everything is fine',
        'no_anomalies': 'No anomalies detected.',
        'live_feed': 'Live Feed',
        'connecting': 'Camera connecting...',
        'living_room': 'Living Room • Camera 1',
        'relatives': 'Supervised Relatives',
        'last_act': 'Last activity 5 min ago',
        'sos_alert': 'SOS ALERT',
        'triggered_by': 'Triggered by',
        'last_update': 'Last update: 2 min ago',
        'settings': 'Settings',
        'language': 'Language',
        'notifications': 'Notifications',
        'alerts': 'Alerts & reminders',
        'security': 'Account Security',
        'password': 'Password',
        'help': 'Help',
        'faq': 'FAQ & contact',
        'logout': 'Log Out',
        'details': 'Patient Details',
        'realtime': 'Real-time vitals',
        'bp': 'Blood Pressure',
        'spo2': 'SpO2',
        'temp': 'Temperature',
        'ai': 'AI Analysis',
        'gait': 'Gait Analysis',
        'gait_d': 'Irregular walking pattern detected.',
        'sleep': 'Sleep Quality',
        'sleep_d': 'Poor sleep duration (4h 20m).',
        'prescriptions': 'Medical Prescriptions',
        'no_meds': 'No meds. Press + to add.',
        'prescribe': 'Prescribe medication',
        'med_name': 'Medication Name',
        'dosage': 'Dosage',
        'time': 'Time',
        'med_added': 'Medication added!',
        'call_fam': 'Call Family',
        'message': 'Message',
        'new_patient': 'New patient',
        'full_name': 'Full Name',
        'age': 'Age',
        'fam_phone': 'Family Phone',
        'init_status': 'Initial Status',
        'cancel': 'Cancel',
        'add': 'Add',
        'yrs': 'yrs',
        'sent_doc': 'Alert sent to Doctor!',
        'sent_fam': 'Alert sent to Family!',
        'trigger_sos': 'Trigger SOS Alert',
        'who_contact': 'Who to contact?',
        'doctor': 'Doctor',
        'family': 'Family',
        'no_phone': 'No family number provided.',
        'login': 'Login',
        'create_account': 'Create an account',
        'account': 'Account',
        'email': 'Email',
        'pwd': 'Password',
        'phone': 'Phone',
        'connect': 'Log In',
        'create': 'Create Account',
        'no_account': "Don't have an account? ",
        'has_account': 'Already have an account? ',
        'signup': 'Sign Up',
        'signin': 'Log In',
        'no_field': 'Please fill in all fields.',
        'bad_email': 'Invalid email format.',
        'bad_phone': 'Invalid number! (6-10 digits).',
        'total': 'Total',
        'call_err': 'Cannot launch call.',
        'alert_off': 'Turn off alert',
        'en': 'English',
        'fr': 'French',
      },
      'fr': {
        'welcome': 'Bonjour',
        'room': 'Chambre 204 • Étage 2',
        'press_emergency': "Appuyer en cas d'urgence",
        'my_treatments': 'Mes Traitements',
        'no_treatments': 'Aucun traitement prescrit.',
        'take_at': 'À prendre à',
        'vital_signs': 'Signaux vitaux',
        'heart_rate': 'Cardiaque',
        'movement': 'Mouvement',
        'normal': 'Normal',
        'welcome_doc': 'Bienvenue,',
        'search': 'Rechercher un patient...',
        'all': 'Tous',
        'critical': 'Critiques',
        'stable': 'Stables',
        'review': 'À surveiller',
        'no_patients': 'Aucun patient enregistré.',
        'press_add': 'Appuyez sur + pour ajouter',
        'dashboard': 'Tableau de bord',
        'everything_fine': 'Tout va bien',
        'no_anomalies': 'Aucune anomalie détectée.',
        'live_feed': 'Flux en direct',
        'connecting': 'Connexion caméra...',
        'living_room': 'Salon • Caméra 1',
        'relatives': 'Proches surveillés',
        'last_act': 'Dernière activité il y a 5 min',
        'sos_alert': 'ALERTE SOS',
        'triggered_by': 'Déclenchée par',
        'last_update': 'Mise à jour : Il y a 2 min',
        'settings': 'Paramètres',
        'language': 'Langue',
        'notifications': 'Notifications',
        'alerts': 'Alertes et rappels',
        'security': 'Sécurité du compte',
        'password': 'Mot de passe',
        'help': 'Aide',
        'faq': 'FAQ et contact',
        'logout': 'Se déconnecter',
        'details': 'Détail patient',
        'realtime': 'Signaux vitaux',
        'bp': 'Tension',
        'spo2': 'SpO2',
        'temp': 'Température',
        'ai': 'Analyse IA',
        'gait': 'Analyse de la démarche',
        'gait_d': 'Pattern de marche irrégulier détecté.',
        'sleep': 'Qualité du sommeil',
        'sleep_d': 'Durée de sommeil faible (4h 20m).',
        'prescriptions': 'Prescriptions médicales',
        'no_meds': 'Aucun médicament. Appuyez sur +.',
        'prescribe': 'Prescrire un médicament',
        'med_name': 'Nom du médicament',
        'dosage': 'Dosage',
        'time': 'Heure',
        'med_added': 'Médicament ajouté !',
        'call_fam': 'Appeler famille',
        'message': 'Message',
        'new_patient': 'Nouveau patient',
        'full_name': 'Nom complet',
        'age': 'Âge',
        'fam_phone': 'Tél de la famille',
        'init_status': 'Statut initial',
        'cancel': 'Annuler',
        'add': 'Ajouter',
        'yrs': 'ans',
        'sent_doc': 'Alerte envoyée au Médecin !',
        'sent_fam': 'Alerte envoyée à la Famille !',
        'trigger_sos': 'Déclencher une alerte SOS',
        'who_contact': "Qui contacter en cas d'urgence ?",
        'doctor': 'Médecin',
        'family': 'Famille',
        'no_phone': 'Aucun numéro de famille renseigné.',
        'login': 'Connexion',
        'create_account': 'Créer un compte',
        'account': 'Compte',
        'email': 'Email',
        'pwd': 'Mot de passe',
        'phone': 'Téléphone',
        'connect': 'Se connecter',
        'create': 'Créer mon compte',
        'no_account': 'Pas encore de compte ? ',
        'has_account': 'Déjà un compte ? ',
        'signup': "S'inscrire",
        'signin': 'Se connecter',
        'no_field': 'Veuillez remplir tous les champs.',
        'bad_email': "Format d'email invalide.",
        'bad_phone': 'Numéro invalide ! (6 à 10 chiffres).',
        'total': 'Total',
        'call_err': "Impossible de lancer l'appel.",
        'alert_off': "Désactiver l'alerte",
        'en': 'Anglais',
        'fr': 'Français',
      }
    };
    return map[lang]?[key] ?? map['en']?[key] ?? key;
  }
}

// ═══════════════════════════════════════════
//           DESIGN SYSTEM
// ═══════════════════════════════════════════
class AppColors {
  static const Color primary = Color(0xFF0891b2);
  static const Color primaryDark = Color(0xFF155e75);
  static const Color primaryLight = Color(0xFFe0f7fa);
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
  static final BoxShadow sm = BoxShadow(
      color: AppColors.shadow.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2));
  static final BoxShadow md = BoxShadow(
      color: AppColors.shadow.withOpacity(0.07),
      blurRadius: 16,
      offset: const Offset(0, 4));
  static final BoxShadow lg = BoxShadow(
      color: AppColors.shadow.withOpacity(0.10),
      blurRadius: 24,
      offset: const Offset(0, 8));
  static final BoxShadow dangerShadow = BoxShadow(
      color: AppColors.danger.withOpacity(0.35),
      blurRadius: 24,
      offset: const Offset(0, 8));
  static final BoxShadow primaryShadow = BoxShadow(
      color: AppColors.primary.withOpacity(0.30),
      blurRadius: 16,
      offset: const Offset(0, 6));
}

class AppGradients {
  static LinearGradient get primary => const LinearGradient(
      colors: [Color(0xFF06b6d4), Color(0xFF0e7490)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static LinearGradient get subtle => const LinearGradient(
      colors: [Colors.white, AppColors.bgBody],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static LinearGradient get dangerGrad => const LinearGradient(
      colors: [Color(0xFFf87171), Color(0xFFdc2626)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}

// ═══════════════════════════════════════════
//              MODÈLES
// ═══════════════════════════════════════════
class AppUser {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  AppUser(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.role});
  factory AppUser.fromMap(Map<String, dynamic> m) => AppUser(
      uid: m['uid'] ?? '',
      fullName: m['fullName'] ?? '',
      email: m['email'] ?? '',
      phone: m['phone'] ?? '',
      role: m['role'] ?? '');
}

class Patient {
  final String name;
  final int age;
  final String gender;
  final String id;
  final String status;
  final String timeAgo;
  final String? alertMsg;
  final String familyPhone;
  final String ownerUid;
  Patient(
      {required this.name,
      required this.age,
      required this.gender,
      required this.id,
      required this.status,
      required this.timeAgo,
      this.alertMsg,
      this.familyPhone = '',
      this.ownerUid = ''});
  factory Patient.fromMap(Map<String, dynamic> m) => Patient(
      name: m['name'] ?? '',
      age: m['age']?.toInt() ?? 0,
      gender: m['gender'] ?? '',
      id: m['id'] ?? '',
      status: m['status'] ?? 'stable',
      timeAgo: m['timeAgo'] ?? '',
      alertMsg: m['alertMsg'],
      familyPhone: m['familyPhone'] ?? '',
      ownerUid: m['ownerUid'] ?? '');
}

class Medication {
  final String name;
  final String dose;
  final String times;
  Medication({required this.name, required this.dose, required this.times});
  factory Medication.fromMap(Map<String, dynamic> m) => Medication(
      name: m['name'] ?? '', dose: m['dose'] ?? '', times: m['times'] ?? '');
}

// ═══════════════════════════════════════════
//           WIDGETS RÉUTILISABLES
// ═══════════════════════════════════════════
class SectionLabel extends StatelessWidget {
  final String text;
  final IconData? icon;
  const SectionLabel(this.text, {this.icon, super.key});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8)),
                child:
                    Icon(icon, size: 14, color: AppColors.primaryDark)),
            const SizedBox(width: 8)
          ],
          Text(text,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                  letterSpacing: 1.2))
        ],
      ));
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({required this.status, super.key});
  @override
  Widget build(BuildContext context) {
    Color bg, fg, dot;
    String t;
    if (status == 'critical') {
      bg = AppColors.dangerLight;
      fg = const Color(0xFF991b1b);
      dot = AppColors.danger;
      t = L.t('critical');
    } else if (status == 'warning') {
      bg = AppColors.warningLight;
      fg = const Color(0xFF92400e);
      dot = AppColors.warning;
      t = L.t('review');
    } else {
      bg = AppColors.successLight;
      fg = const Color(0xFF166534);
      dot = AppColors.success;
      t = L.t('stable');
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(t,
              style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700))
        ]));
  }
}

class StatCard extends StatelessWidget {
  final String value, label;
  final Color color;
  final IconData icon;
  const StatCard(
      {required this.value,
      required this.label,
      required this.color,
      required this.icon,
      super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [AppShadows.md]),
      child: Row(children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMain,
                  height: 1.2)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textMuted))
        ])
      ]));
}

class _PulseAnimation extends StatefulWidget {
  final Widget child;
  const _PulseAnimation({required this.child});
  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _s;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat(reverse: true);
    _s = Tween(begin: 1.0, end: 1.08)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(scale: _s, child: widget.child);
}

class _VitalCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value, unit, label;
  const _VitalCard(
      {required this.icon,
      required this.iconColor,
      required this.value,
      required this.unit,
      required this.label});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [AppShadows.sm]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 16)),
        const SizedBox(height: 12),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMain,
                  height: 1)),
          const SizedBox(width: 4),
          Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(unit,
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted)))
        ]),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted))
      ]));
}

// ═══════════════════════════════════════════
//               APP PRINCIPALE
// ═══════════════════════════════════════════
class SeniorCareApp extends StatelessWidget {
  const SeniorCareApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'SeniorCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.inter().fontFamily,
          scaffoldBackgroundColor: AppColors.bgBody,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0),
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.bgBody,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2))),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0))),
      home: const RoleSelectionScreen());
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          decoration: BoxDecoration(gradient: AppGradients.subtle),
          child: SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  child: Column(children: [
                    const Spacer(flex: 2),
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            gradient: AppGradients.primary,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [AppShadows.primaryShadow]),
                        child: const Icon(FontAwesomeIcons.heartPulse,
                            size: 44, color: Colors.white)),
                    const SizedBox(height: 24),
                    Text("SeniorCare",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.textMain)),
                    const SizedBox(height: 8),
                    const Text("Intelligent Health Surveillance",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textMuted)),
                    const Spacer(flex: 3),
                    _buildRoleCard(context,
                        icon: FontAwesomeIcons.user,
                        title: "Patient",
                        subtitle: "Monitor my health",
                        color: AppColors.primary,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const LoginScreen(role: 'Patient')))),
                    const SizedBox(height: 14),
                    _buildRoleCard(context,
                        icon: FontAwesomeIcons.houseUser,
                        title: "Family",
                        subtitle: "Watch over loved ones",
                        color: AppColors.success,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const LoginScreen(role: 'Family')))),
                    const SizedBox(height: 14),
                    _buildRoleCard(context,
                        icon: FontAwesomeIcons.userDoctor,
                        title: "Doctor",
                        subtitle: "Analyze patient data",
                        color: AppColors.warning,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const LoginScreen(role: 'Doctor')))),
                    const SizedBox(height: 32)
                  ])))));
  Widget _buildRoleCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required Color color,
      required VoidCallback onTap}) {
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border.withOpacity(0.6))),
                child: Row(children: [
                  Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(icon, size: 22, color: color)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3),
                        Text(subtitle,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textMuted))
                      ])),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.bgBody,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_forward_ios,
                          size: 14, color: AppColors.textMuted))
                ]))));
  }
}

// ═══════════════════════════════════════════
//             LOGIN
// ═══════════════════════════════════════════
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
  String _selectedDialCode = '+216';
  int _getPhoneMaxLength() {
    switch (_selectedDialCode) {
      case '+216': return 8; // Tunisie
      case '+33': return 9;  // France
      case '+213': return 9; // Algérie
      case '+1': return 10;  // USA
      default: return 10;
    }
  }

  String _getPhoneRegex() {
    switch (_selectedDialCode) {
      case '+216': return r'^[0-9]{8}$';
      case '+33': return r'^[0-9]{9}$';
      case '+213': return r'^[0-9]{9}$';
      case '+1': return r'^[0-9]{10}$';
      default: return r'^[0-9]{6,10}$';
    }
  }
  Future<void> _submit() async {
    if (_emailCtrl.text.trim().isEmpty ||
        _passwordCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L.t('no_field')),
              behavior: SnackBarBehavior.floating));
      return;
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(_emailCtrl.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L.t('bad_email')),
              backgroundColor: AppColors.danger,
              behavior: SnackBarBehavior.floating));
      return;
    }
    if (!_isLogin) {
      if (_nameCtrl.text.trim().isEmpty || _phoneCtrl.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(L.t('no_field')),
                behavior: SnackBarBehavior.floating));
        return;
      }
            if (!RegExp(_getPhoneRegex()).hasMatch(_phoneCtrl.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(L.t('bad_phone')),
                backgroundColor: AppColors.danger,
                behavior: SnackBarBehavior.floating));
        return;
      }
    }
    setState(() => _isLoading = true);
    try {
      UserCredential cred;
      if (_isLogin) {
        cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text.trim());
      } else {
        cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text.trim());
        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set({
          'uid': cred.user!.uid,
          'fullName': _nameCtrl.text.trim(),
          'email': _emailCtrl.text.trim(),
          'phone': "$_selectedDialCode${_phoneCtrl.text.trim()}",
          'role': widget.role,
          'createdAt': FieldValue.serverTimestamp()
        });
      }
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    MainLayout(currentIndex: 0, role: widget.role)));
      }
    } catch (e) {
      String msg = "Error";
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found')
          msg = 'No account found.';
        else if (e.code == 'wrong-password')
          msg = 'Wrong password.';
        else if (e.code == 'email-already-in-use')
          msg = 'Email already used.';
        else if (e.code == 'weak-password')
          msg = 'Password too short.';
        else
          msg = e.message ?? msg;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg),
                backgroundColor: AppColors.danger,
                behavior: SnackBarBehavior.floating));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roleIcon = widget.role == 'Doctor'
        ? FontAwesomeIcons.userDoctor
        : widget.role == 'Family'
            ? FontAwesomeIcons.houseUser
            : FontAwesomeIcons.user;
    final roleColor = widget.role == 'Doctor'
        ? AppColors.warning
        : widget.role == 'Family'
            ? AppColors.success
            : AppColors.primary;
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(gradient: AppGradients.subtle),
            child: SafeArea(
                child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.arrow_back_rounded),
                              onPressed: () => Navigator.pop(context)),
                          const SizedBox(height: 8),
                          Text(
                              _isLogin ? L.t('login') : L.t('create_account'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textMain)),
                          const SizedBox(height: 8),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: roleColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(roleIcon, size: 14, color: roleColor),
                                    const SizedBox(width: 8),
                                    Text("${L.t('account')} ${widget.role}",
                                        style: TextStyle(
                                            color: roleColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13))
                                  ])),
                          const SizedBox(height: 36),
                          AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                      color: AppColors.bgCard,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [AppShadows.lg]),
                                  child: Column(children: [
                                    if (!_isLogin) ...[
                                      TextField(
                                          controller: _nameCtrl,
                                          decoration: InputDecoration(
                                              labelText: L.t('full_name'),
                                              prefixIcon: const Icon(
                                                  Icons.person_outline_rounded))),
                                      const SizedBox(height: 14)
                                    ],
                                    TextField(
                                        controller: _emailCtrl,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            labelText: L.t('email'),
                                            prefixIcon: const Icon(
                                                Icons.mail_outline_rounded))),
                                    const SizedBox(height: 14),
                                    TextField(
                                        controller: _passwordCtrl,
                                        obscureText: _obscurePassword,
                                        decoration: InputDecoration(
                                            labelText: L.t('pwd'),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_rounded),
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                    _obscurePassword
                                                        ? Icons
                                                            .visibility_off_outlined
                                                        : Icons
                                                            .visibility_outlined,
                                                    color: AppColors.textMuted),
                                                onPressed: () => setState(() =>
                                                    _obscurePassword =
                                                        !_obscurePassword)))),
                                    if (!_isLogin) ...[
                                      const SizedBox(height: 14),
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Phone",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.textMuted))),
                                      const SizedBox(height: 8),
                                      Row(children: [
                                        Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 14),
                                            decoration: BoxDecoration(
                                                color: AppColors.bgBody,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: AppColors.border)),
                                            child:
                                                DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                            String>(
                                                        value:
                                                            _selectedDialCode,
                                                        icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: AppColors
                                                                .textMuted,
                                                            size: 20),
                                                        items: const [
                                                          DropdownMenuItem(
                                                              value: '+216',
                                                              child: Text(
                                                                  '🇹🇳 +216',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))),
                                                          DropdownMenuItem(
                                                              value: '+33',
                                                              child: Text(
                                                                  '🇫🇷 +33',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))),
                                                          DropdownMenuItem(
                                                              value: '+213',
                                                              child: Text(
                                                                  '🇩🇿 +213',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))),
                                                          DropdownMenuItem(
                                                              value: '+1',
                                                              child: Text(
                                                                  '🇺🇸 +1',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)))
                                                        ],
                                                        onChanged: (v) =>
                                                            setState(() =>
                                                                _selectedDialCode =
                                                                    v!)))),
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: TextField(
                                                controller: _phoneCtrl,
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: _getPhoneMaxLength(),
                                                decoration: InputDecoration(
                                                    hintText: "XX XXX XXX",
                                                    counterText: "",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12),
                                                        borderSide: const BorderSide(
                                                            color: AppColors
                                                                .border)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12),
                                                        borderSide: const BorderSide(
                                                            color: AppColors
                                                                .primary,
                                                                width: 2)))))
                                      ])
                                    ],
                              const SizedBox(height: 2),
                                    SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed:
                                                _isLoading ? null : _submit,
                                            child: _isLoading
                                                ? const SizedBox(
                                                    height: 22,
                                                    width: 22,
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2.5))
                                                : Text(_isLogin
                                                    ? L.t('connect')
                                                    : L.t('create')))),
                                    const SizedBox(height: 16),
                                    TextButton(
                                        onPressed: () => setState(
                                            () => _isLogin = !_isLogin),
                                        child: RichText(
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    fontSize: 13),
                                                children: [
                                              TextSpan(
                                                  text: _isLogin
                                                      ? L.t('no_account')
                                                      : L.t('has_account'),
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .textMuted)),
                                              TextSpan(
                                                  text: _isLogin
                                                      ? L.t('signup')
                                                      : L.t('signin'),
                                                  style: const TextStyle(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w700))
                                            ])))
                                  ])))
                        ])))));
  }
}

// ═══════════════════════════════════════════
//               MAIN LAYOUT
// ═══════════════════════════════════════════
class MainLayout extends StatefulWidget {
  final int currentIndex;
  final String role;
  const MainLayout(
      {super.key, required this.currentIndex, required this.role});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    L.lang = 'en';
  }

  void _changeLang(String l) => setState(() => L.lang = l);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250), child: _getBody()),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [AppShadows.lg]),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.sensors_rounded, "Home", 0),
                _buildNavItem(
                    Icons.settings_rounded, L.t('settings'), 1)
              ])));

  Widget _buildNavItem(IconData icon, String label, int index) {
    final active = _currentIndex == index;
    return GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: active ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: active ? [AppShadows.primaryShadow] : []),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon,
                  size: 20,
                  color: active ? Colors.white : AppColors.textMuted),
              if (active) ...[
                const SizedBox(width: 8),
                Text(label,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))
              ]
            ])));
  }

  Widget _getBody() {
    if (_currentIndex == 1) return SettingsScreen(onChangeLang: _changeLang);
    if (widget.role == 'Patient') return const PatientDashboard();
    if (widget.role == 'Family') return const FamilyDashboard();
    return const DoctorDashboard();
  }
}

// ═══════════════════════════════════════════
//            DASHBOARDS
// ═══════════════════════════════════════════
class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});
  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  AppUser? _currentUser;
  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots()
          .listen((doc) {
        if (doc.exists && mounted) {
          setState(() => _currentUser = AppUser.fromMap(doc.data()!));
        }
      });
    }
  }

  void _triggerSOS(BuildContext ctx, String target) async {
    final u = FirebaseAuth.instance.currentUser;
    if (u == null) return;
    await FirebaseFirestore.instance.collection('alerts').add({
      'patientUid': u.uid,
      'patientName': _currentUser?.fullName ?? 'Patient',
      'targetRole': target,
      'timestamp': FieldValue.serverTimestamp(),
      'isActive': true
    });
    if (ctx.mounted) {
      Navigator.pop(ctx);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(target == 'Doctor'
              ? L.t('sent_doc')
              : L.t('sent_fam')),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating));
    }
  }

  void _showSOSDialog(BuildContext ctx) => showDialog(
      context: ctx,
      builder: (c) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(L.t('trigger_sos'),
              style: const TextStyle(fontWeight: FontWeight.w700)),
          content: Text(L.t('who_contact')),
          actions: [
            TextButton(
                onPressed: () => _triggerSOS(c, 'Doctor'),
                child: Text(L.t('doctor'),
                    style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700))),
            TextButton(
                onPressed: () => _triggerSOS(c, 'Family'),
                child: Text(L.t('family'),
                    style: const TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w700)))
          ]));

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          gradient: AppGradients.primary,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [AppShadows.primaryShadow]),
                      child: Row(children: [
                        const CircleAvatar(
                            radius: 26,
                            backgroundColor: Color(0x33ffffff),
                            child: Icon(FontAwesomeIcons.user,
                                color: Colors.white, size: 22)),
                                                const SizedBox(width: 14),
                        Expanded(
                            child: Text(
                                "${L.t('welcome')}, ${_currentUser?.fullName ?? 'Patient'}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                            ),
                        )
                      ])),
                  const SizedBox(height: 28),
                  const SizedBox(height: 32),
                  SectionLabel(L.t('my_treatments'),
                      icon: FontAwesomeIcons.pills),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('patients')
                          .doc(uid)
                          .collection('medications')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox();
                        final meds = snapshot.data!.docs
                            .map((d) => Medication.fromMap(
                                d.data() as Map<String, dynamic>))
                            .toList();
                        if (meds.isEmpty) {
                          return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.bgCard,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [AppShadows.md]),
                              child: Center(
                                  child: Text(L.t('no_treatments'),
                                      style: const TextStyle(
                                          color: AppColors.textMuted))));
                        }
                        return Column(
                            children: meds.map((m) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.bgCard,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [AppShadows.sm]),
                              child: Row(children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryLight,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Icon(
                                        FontAwesomeIcons.capsules,
                                        color: AppColors.primaryDark,
                                        size: 20)),
                                const SizedBox(width: 14),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(m.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15)),
                                      const SizedBox(height: 4),
                                      Text(
                                          "${m.dose} • ${L.t('take_at')} ${m.times}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textMuted))
                                    ])),
                                const Icon(Icons.alarm_rounded,
                                    color: AppColors.warning)
                              ]));
                        }).toList());
                      }),
                  const SizedBox(height: 24),
                  SectionLabel(L.t('vital_signs'),
                      icon: FontAwesomeIcons.heartPulse),
                  const SizedBox(height: 4),
                  Row(children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: AppColors.bgCard,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [AppShadows.md]),
                            child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(FontAwesomeIcons.heart,
                                            color: AppColors.danger,
                                            size: 18),
                                        Text(L.t('normal'),
                                            style: const TextStyle(
                                                color: AppColors.success,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700))
                                      ]),
                                  const SizedBox(height: 12),
                                  Text(L.t('heart_rate'),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textMuted,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 2),
                                  const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("72",
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.textMain,
                                                height: 1)),
                                        SizedBox(width: 4),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 4),
                                            child: Text("bpm",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: AppColors
                                                        .textMuted)))
                                      ])
                                ]))),
                    const SizedBox(width: 14),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: AppColors.bgCard,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [AppShadows.md]),
                            child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                            FontAwesomeIcons.personWalking,
                                            color: AppColors.primary,
                                            size: 18),
                                        Text(L.t('normal'),
                                            style: const TextStyle(
                                                color: AppColors.success,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700))
                                      ]),
                                  const SizedBox(height: 12),
                                  Text(L.t('movement'),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textMuted,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 2),
                                  const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("85",
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.textMain,
                                                height: 1)),
                                        SizedBox(width: 4),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 4),
                                            child: Text("%",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: AppColors
                                                        .textMuted)))
                                      ])
                                ])))
                  ]),
                  const SizedBox(height: 32)
                ]))));
  }
}

class FamilyDashboard extends StatelessWidget {
  const FamilyDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                AppColors.success,
                                const Color(0xFF059669)
                              ]),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColors.success.withOpacity(0.25),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6))
                              ]),
                          child: Row(children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(L.t('family'),
                                          style: const TextStyle(
                                              color: Color(0xB3ffffff),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 4),
                                      Text(L.t('dashboard'),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800))
                                    ])),
                            const Icon(FontAwesomeIcons.houseUser,
                                color: Colors.white, size: 22)
                          ])),
                      const SizedBox(height: 24),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('alerts')
                              .where('targetRole', isEqualTo: 'Family')
                              .where('isActive', isEqualTo: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              final a = snapshot.data!.docs.first;
                              return Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 24),
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      color: AppColors.danger,
                                      borderRadius:
                                          BorderRadius.circular(20),
                                      boxShadow: [AppShadows.dangerShadow]),
                                  child: Row(children: [
                                    const Icon(
                                        FontAwesomeIcons.triangleExclamation,
                                        color: Colors.white,
                                        size: 28),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(L.t('sos_alert'),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              const SizedBox(height: 4),
                                              Text(
                                                  "${L.t('triggered_by')} ${a['patientName']}",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.9),
                                                      fontSize: 13))
                                            ])),
                                    IconButton(
                                        icon: const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.white),
                                        onPressed: () => FirebaseFirestore
                                            .instance
                                            .collection('alerts')
                                            .doc(a.id)
                                            .update({'isActive': false}))
                                  ]));
                            }
                            return Container(
                                margin:
                                    const EdgeInsets.only(bottom: 24),
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                    color: AppColors.successLight,
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    border: Border.all(color: AppColors.success
                                        .withOpacity(0.3))),
                                child: Row(children: [
                                  const Icon(
                                      FontAwesomeIcons.shieldHeart,
                                      color: AppColors.success,
                                      size: 22),
                                  const SizedBox(width: 14),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(L.t('everything_fine'),
                                                style: const TextStyle(
                                                    color:
                                                        Color(0xFF166534),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            const SizedBox(height: 2),
                                            Text(L.t('no_anomalies'),
                                                style: const TextStyle(
                                                    color:
                                                        Color(0xFF4ade80),
                                                    fontSize: 12))
                                          ])),
                                  const Icon(Icons.check_circle_rounded,
                                      color: AppColors.success, size: 32)
                                ]));
                          }),
                      const SizedBox(height: 24),
                      SectionLabel(L.t('live_feed'),
                          icon: FontAwesomeIcons.video),
                      Container(
                          height: 160,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1e293b),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [AppShadows.md]),
                          child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                        FontAwesomeIcons.mapLocationDot,
                                        size: 40,
                                        color: AppColors.primary),
                                    const SizedBox(height: 10),
                                    const Text(
                                        "36.8065 N, 10.1815 E",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(L.t('last_update'),
                                        style: const TextStyle(
                                            color: AppColors.textMuted,
                                            fontSize: 12))
                                  ]))),
                      const SizedBox(height: 32)
                    ]))));
  }
}

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});
  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  String selectedFilter = L.t('all');
  AppUser? _currentUser;
  String _selectedDialCode = '+216'; // <-- AJOUTÉ

  int _getPhoneMaxLength() {
    switch (_selectedDialCode) {
      case '+216': return 8;
      case '+33': return 9;
      case '+213': return 9;
      case '+1': return 10;
      default: return 10;
    }
  } // <-- AJOUTÉ

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots()
          .listen((doc) {
        if (doc.exists && mounted) {
          setState(() => _currentUser = AppUser.fromMap(doc.data()!));
        }
      });
    }
  }

  void _showAddDialog() {
    final nCtrl = TextEditingController();
    final aCtrl = TextEditingController();
    final pCtrl = TextEditingController();
    String st = 'stable';
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(builder: (ctx, setD) {
              return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  title: Text(L.t('new_patient')),
                  content: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                        TextField(
                            controller: nCtrl,
                            decoration: InputDecoration(
                                labelText: L.t('full_name'))),
                        const SizedBox(height: 12),
                        TextField(
                            controller: aCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration:
                                InputDecoration(labelText: L.t('age'))),
                        const SizedBox(height: 12),
                        const Text("Phone",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textMuted)),
                        const SizedBox(height: 8),
                        Row(children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              decoration: BoxDecoration(
                                  color: AppColors.bgBody,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColors.border)),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      value: _selectedDialCode,
                                      icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: AppColors.textMuted,
                                          size: 20),
                                      items: const [
                                        DropdownMenuItem(
                                            value: '+216',
                                            child: Text('🇹🇳 +216',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        DropdownMenuItem(
                                            value: '+33',
                                            child: Text('🇫🇷 +33',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        DropdownMenuItem(
                                            value: '+213',
                                            child: Text('🇩🇿 +213',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        DropdownMenuItem(
                                            value: '+1',
                                            child: Text('🇺🇸 +1',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600)))
                                      ],
                                      onChanged: (v) => setState(
                                          () => _selectedDialCode = v!)))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: TextField(
                                  controller: pCtrl,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: _getPhoneMaxLength(),
                                  decoration: InputDecoration(
                                      hintText: "XX XXX XXX",
                                      counterText: "",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: AppColors.border)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: AppColors.primary,
                                              width: 2)))))
                        ]),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                            value: st,
                            items: [
                              DropdownMenuItem(
                                  value: "stable",
                                  child: Text(L.t('stable'))),
                              DropdownMenuItem(
                                  value: "warning",
                                  child: Text(L.t('review'))),
                              DropdownMenuItem(
                                  value: "critical",
                                  child: Text(L.t('critical')))
                            ],
                            onChanged: (v) => setD(() => st = v!),
                            decoration: InputDecoration(
                                labelText: L.t('init_status')))
                      ])),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(L.t('cancel'))),
                    ElevatedButton(
                        onPressed: () async {
                          if (nCtrl.text.trim().isEmpty ||
                              aCtrl.text.trim().isEmpty) return;
                          await FirebaseFirestore.instance
                              .collection('patients')
                              .add({
                            'name': nCtrl.text.trim(),
                            'age': int.tryParse(aCtrl.text.trim()) ?? 0,
                            'gender': 'Male',
                            'id':
                                '#${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                            'status': st,
                            'timeAgo': 'Now',
                            'alertMsg': st == 'critical'
                                ? 'Requires attention'
                                : null,
                            'familyPhone': "$_selectedDialCode${pCtrl.text.trim()}",                            'ownerUid':
                                FirebaseAuth.instance.currentUser?.uid
                          });
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text(L.t('add')))
                  ]);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: BoxDecoration(
                  gradient: AppGradients.primary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28))),
              child: Column(children: [
                Row(children: [
                  CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0x33ffffff),
                      child: Text(
                          _currentUser?.fullName.isNotEmpty == true
                              ? _currentUser!.fullName
                                  .substring(0, 1)
                                  .toUpperCase()
                              : "D",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20))),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                            "${L.t('welcome_doc')} ${_currentUser?.fullName ?? "Doctor"}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800))
                      ])),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0x33ffffff),
                          borderRadius: BorderRadius.circular(14)),
                      child: const Icon(FontAwesomeIcons.userDoctor,
                          color: Colors.white, size: 20))
                ]),
                const SizedBox(height: 18),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(children: [
                      const Icon(FontAwesomeIcons.magnifyingGlass,
                          color: AppColors.textMuted, size: 16),
                      const SizedBox(width: 10),
                      Text(L.t('search'),
                          style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 14))
                    ]))
              ])),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Expanded(
                    child: StatCard(
                        value: "17",
                        label: L.t('total'),
                        color: AppColors.primary,
                        icon: FontAwesomeIcons.users)),
                const SizedBox(width: 12),
                Expanded(
                    child: StatCard(
                        value: "2",
                        label: L.t('critical'),
                        color: AppColors.danger,
                        icon: FontAwesomeIcons.triangleExclamation)),
                const SizedBox(width: 12),
                Expanded(
                    child: StatCard(
                        value: "15",
                        label: L.t('stable'),
                        color: AppColors.success,
                        icon: FontAwesomeIcons.checkCircle))
              ])),
          const SizedBox(height: 20),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('patients')
                      .where('ownerUid',
                          isEqualTo:
                              FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snap) {
                    if (snap.hasError) {
                      return const Center(child: Text("Error"));
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primary));
                    }
                    if (!snap.hasData || snap.data!.docs.isEmpty) {
                      return Center(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            Icon(FontAwesomeIcons.userPlus,
                                size: 48,
                                color: AppColors.textMuted
                                    .withOpacity(0.4)),
                            const SizedBox(height: 16),
                            Text(L.t('no_patients'),
                                style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 14)),
                            const SizedBox(height: 8),
                            Text(L.t('press_add'),
                                style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 12))
                          ]));
                    }
                    final p = snap.data!.docs
                        .map((d) => {
                              'm': Patient.fromMap(
                                  d.data() as Map<String, dynamic>),
                              'id': d.id
                            })
                        .toList();
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        itemCount: p.length,
                        itemBuilder: (_, i) {
                          final pt = p[i]['m'] as Patient;
                          return Container(
                              margin:
                                  const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                  color: AppColors.bgCard,
                                  borderRadius:
                                      BorderRadius.circular(18),
                                  boxShadow: [AppShadows.sm]),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PatientDetailScreen(
                                                      patient: pt,
                                                      docId: p[i]['id']
                                                          as String))),
                                      borderRadius:
                                          BorderRadius.circular(18),
                                      child: Padding(
                                          padding: const EdgeInsets.all(
                                              16),
                                          child: Column(children: [
                                            Row(children: [
                                              Container(
                                                  width: 46,
                                                  height: 46,
                                                  alignment:
                                                      Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryLight,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  14)),
                                                  child: Text(
                                                      pt.name.isNotEmpty
                                                          ? pt.name
                                                              .substring(0, 1)
                                                              .toUpperCase()
                                                          : "?",
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .primaryDark,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                          fontSize: 18))),
                                              const SizedBox(width: 14),
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(pt.name,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    15)),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            "${pt.age} ${L.t('yrs')} • ${pt.gender}",
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .textMuted))
                                                      ])),
                                              StatusBadge(
                                                  status: pt.status)
                                            ]),
                                            if (pt.alertMsg != null) ...[
                                              const SizedBox(height: 12),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          12),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .warningLight,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  12)),
                                                  child: Row(children: [
                                                    const Icon(
                                                        FontAwesomeIcons
                                                            .triangleExclamation,
                                                        color: Color(
                                                            0xFF92400E),
                                                        size: 14),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                        child: Text(
                                                            pt.alertMsg!,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xFF92400E),
                                                                fontSize:
                                                                    12)))
                                                  ]))
                                            ]
                                          ])))));
                        });
                  }))
        ])),
        floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
                gradient: AppGradients.primary,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [AppShadows.primaryShadow]),
            child: FloatingActionButton(
                onPressed: _showAddDialog,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.add_rounded,
                    color: Colors.white, size: 28))));
  }
}

// ═══════════════════════════════════════════
//          DÉTAIL PATIENT
// ═══════════════════════════════════════════
class PatientDetailScreen extends StatefulWidget {
  final Patient patient;
  final String docId;
  const PatientDetailScreen(
      {super.key, required this.patient, required this.docId});
  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Future<void> _callFam() async {
    final p = widget.patient.familyPhone;
    if (p.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(L.t('no_phone')),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating));
      return;
    }
    final u = Uri(scheme: 'tel', path: p);
    try {
      await launchUrl(u);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(L.t('call_err')),
            backgroundColor: AppColors.danger,
            behavior: SnackBarBehavior.floating));
      }
    }
  }

  void _showMedDialog() {
    final n = TextEditingController();
    final d = TextEditingController();
    final t = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            title: Text(L.t('prescribe')),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                  controller: n,
                  decoration: InputDecoration(labelText: L.t('med_name'))),
              const SizedBox(height: 12),
              TextField(
                  controller: d,
                  decoration: InputDecoration(labelText: L.t('dosage'))),
              const SizedBox(height: 12),
              TextField(
                  controller: t,
                  decoration: InputDecoration(labelText: L.t('time')))
            ]),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(L.t('cancel'))),
              ElevatedButton(
                  onPressed: () async {
                    if (n.text.trim().isEmpty || d.text.trim().isEmpty) return;
                    await FirebaseFirestore.instance
                        .collection('patients')
                        .doc(widget.docId)
                        .collection('medications')
                        .add({
                      'name': n.text.trim(),
                      'dose': d.text.trim(),
                      'times': t.text.trim().isEmpty
                          ? '--:--'
                          : t.text.trim()
                    });
                    if (ctx.mounted) Navigator.pop(ctx);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(L.t('med_added')),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating));
                    }
                  },
                  child: Text(L.t('add')))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
              decoration: BoxDecoration(
                  gradient: AppGradients.primary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28))),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context)),
                      Text(L.t('details'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      IconButton(
                          icon: const Icon(Icons.more_horiz_rounded,
                              color: Colors.white),
                          onPressed: () {})
                    ]),
                const SizedBox(height: 16),
                CircleAvatar(
                    radius: 42,
                    backgroundColor: const Color(0x33ffffff),
                    child: Text(
                        widget.patient.name.isNotEmpty
                            ? widget.patient.name
                                .substring(0, 1)
                                .toUpperCase()
                            : "?",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700))),
                const SizedBox(height: 12),
                Text(widget.patient.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text("${widget.patient.id} • Room 204",
                    style: const TextStyle(
                        color: Color(0x99ffffff), fontSize: 13)),
                const SizedBox(height: 10),
                StatusBadge(status: widget.patient.status)
              ])),
          const SizedBox(height: 24),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionLabel(L.t('realtime')),
                    GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: [
                          _VitalCard(
                              icon: FontAwesomeIcons.heart,
                              iconColor: AppColors.danger,
                              value: "72",
                              unit: "bpm",
                              label: L.t('heart_rate')),
                          _VitalCard(
                              icon: FontAwesomeIcons.gaugeHigh,
                              iconColor: AppColors.warning,
                              value: "145/95",
                              unit: "mmHg",
                              label: L.t('bp')),
                          _VitalCard(
                              icon: FontAwesomeIcons.lungs,
                              iconColor: AppColors.primary,
                              value: "98",
                              unit: "%",
                              label: L.t('spo2')),
                          _VitalCard(
                              icon: FontAwesomeIcons.thermometerHalf,
                              iconColor: AppColors.success,
                              value: "36.8",
                              unit: "°C",
                              label: L.t('temp'))
                        ]),
                    const SizedBox(height: 28),
                    Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          SectionLabel(L.t('prescriptions')),
                          IconButton(
                              icon: const Icon(
                                  Icons.add_circle_rounded,
                                  color: AppColors.primary),
                              onPressed: _showMedDialog)
                        ]),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('patients')
                            .doc(widget.docId)
                            .collection('medications')
                            .snapshots(),
                        builder: (context, s) {
                          if (!s.hasData || s.data!.docs.isEmpty) {
                            return Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: AppColors.bgCard,
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    boxShadow: [AppShadows.md]),
                                child: Center(
                                    child: Text(L.t('no_meds'),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: AppColors.textMuted,
                                            fontSize: 13))));
                          }
                          final m = s.data!.docs
                              .map((d) => Medication.fromMap(
                                  d.data() as Map<String, dynamic>))
                              .toList();
                          return Container(
                              decoration: BoxDecoration(
                                  color: AppColors.bgCard,
                                  borderRadius:
                                      BorderRadius.circular(20),
                                  boxShadow: [AppShadows.md]),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount: m.length,
                                  itemBuilder: (_, i) {
                                    final med = m[i];
                                    return Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(med.name,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      14)),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                              "${L.t('take_at')}: ${med.times}",
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .textMuted,
                                                                  fontSize:
                                                                      12))
                                                        ])),
                                                Container(
                                                    padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryLight,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8)),
                                                    child: Text(med.dose,
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .primaryDark,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)))
                                              ]),
                                          if (i < m.length - 1)
                                            const Divider(height: 24)
                                        ]));
                                  }));
                        }),
                    const SizedBox(height: 28),
                    Row(children: [
                      Expanded(
                          child: ElevatedButton.icon(
                              icon: const Icon(FontAwesomeIcons.phone,
                                  size: 16),
                              label: Text(L.t('call_fam')),
                              onPressed: _callFam)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: OutlinedButton.icon(
                              icon: const Icon(
                                  FontAwesomeIcons.commentMedical,
                                  size: 16),
                              label: Text(L.t('message')),
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(
                                      color: AppColors.primary),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16)),
                              onPressed: () {}))
                    ]),
                    const SizedBox(height: 40)
                  ]))
        ])));
  }
}

// ═══════════════════════════════════════════
//          SETTINGS
// ═══════════════════════════════════════════
class SettingsScreen extends StatelessWidget {
  final Function(String) onChangeLang;
  const SettingsScreen({super.key, required this.onChangeLang});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, s) {
          AppUser? u;
          if (s.hasData && s.data!.exists) {
            u = AppUser.fromMap(s.data!.data() as Map<String, dynamic>);
          }
          return SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.bgCard,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [AppShadows.lg]),
                        child: Row(children: [
                          CircleAvatar(
                              radius: 32,
                              backgroundColor: AppColors.primaryLight,
                              child: Text(
                                  u?.fullName.isNotEmpty == true
                                      ? u!.fullName
                                          .substring(0, 1)
                                          .toUpperCase()
                                      : "?",
                                  style: const TextStyle(
                                      color: AppColors.primaryDark,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700))),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(u?.fullName ?? "User",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 4),
                                    Text(u?.email ?? "",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textMuted)),
                                    const SizedBox(height: 4),
                                    Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3),
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryLight,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Text(u?.role ?? "",
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color:
                                                    AppColors.primaryDark,
                                                fontWeight:
                                                    FontWeight.w700)))
                                  ])),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit_outlined,
                                  color: AppColors.textMuted))
                        ])),
                    const SizedBox(height: 28),
                    SectionLabel(L.t('settings')),
                    _STile(
                        icon: Icons.language_rounded,
                        title: L.t('language'),
                        sub: L.lang == 'en'
                            ? L.t('en')
                            : L.t('fr'),
                        onTap: () => showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20)),
                                title: Text(L.t('language')),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                          title: Text(L.t('en')),
                                          trailing: L.lang == 'en'
                                              ? const Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.primary)
                                              : null,
                                          onTap: () {
                                            onChangeLang('en');
                                            Navigator.pop(c);
                                          }),
                                      ListTile(
                                          title: Text(L.t('fr')),
                                          trailing: L.lang == 'fr'
                                              ? const Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.primary)
                                              : null,
                                          onTap: () {
                                            onChangeLang('fr');
                                            Navigator.pop(c);
                                          })
                                    ])))),
                    _STile(
                        icon: Icons.notifications_rounded,
                        title: L.t('notifications'),
                        sub: L.t('alerts'),
                        onTap: () {}),
                    _STile(
                        icon: Icons.security_rounded,
                        title: L.t('security'),
                        sub: L.t('password'),
                        onTap: () {}),
                    _STile(
                        icon: Icons.help_rounded,
                        title: L.t('help'),
                        sub: L.t('faq'),
                        onTap: () {}),
                    const SizedBox(height: 32),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.dangerLight,
                            borderRadius: BorderRadius.circular(16)),
                        child: TextButton.icon(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const RoleSelectionScreen()),
                                  (route) => false);
                            },
                            icon: const Icon(Icons.logout_rounded,
                                color: AppColors.danger),
                            label: Text(L.t('logout'),
                                style: const TextStyle(
                                    color: AppColors.danger,
                                    fontWeight: FontWeight.w700)))),
                    const SizedBox(height: 32)
                  ])));
        });
  }
}

class _STile extends StatelessWidget {
  final IconData icon;
  final String title, sub;
  final VoidCallback onTap;
  const _STile(
      {required this.icon,
      required this.title,
      required this.sub,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [AppShadows.sm]),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(icon,
                              color: AppColors.primaryDark, size: 20)),
                      const SizedBox(width: 14),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                            Text(sub,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted))
                          ])),
                      const Icon(Icons.chevron_right_rounded,
                          color: AppColors.textMuted)
                    ])))));
  }
}
