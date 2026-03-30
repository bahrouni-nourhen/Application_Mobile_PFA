import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SeniorCareApp());
}

// --- THEME & COLORS ---
class AppColors {
  static const Color primary = Color(0xFF0e7490);
  static const Color primaryDark = Color(0xFF155e75);
  static const Color primaryLight = Color(0xFFccfbf1);
  static const Color success = Color(0xFF10b981);
  static const Color warning = Color(0xFFf59e0b);
  static const Color danger = Color(0xFFef4444);
  static const Color bgBody = Color(0xFFf1f5f9);
  static const Color bgCard = Color(0xFFffffff);
  static const Color textMain = Color(0xFF1e293b);
  static const Color textMuted = Color(0xFF64748b);
  static const Color border = Color(0xFFe2e8f0);
}

// --- DATA MODELS ---
class Patient {
  final String name;
  final int age;
  final String gender;
  final String id;
  final String status;
  final String timeAgo;
  final String? alertMsg;

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    required this.id,
    required this.status,
    required this.timeAgo,
    this.alertMsg,
  });
}

final List<Patient> dummyPatients = [
  Patient(name: "Jean Dupont", age: 84, gender: "Male", id: "#883921", status: "critical", timeAgo: "2m ago", alertMsg: "BP Elevated (145/95)"),
  Patient(name: "Marie Curie", age: 78, gender: "Female", id: "#883922", status: "stable", timeAgo: "1h ago"),
  Patient(name: "Albert Einstein", age: 82, gender: "Male", id: "#883923", status: "warning", timeAgo: "4h ago"),
];

// --- MAIN APP WIDGET ---
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
        cardTheme: CardThemeData(
          color: AppColors.bgCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)),
        ),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}

// --- SCREEN 1: ROLE SELECTION ---
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.heartPulse, size: 64, color: AppColors.primary),
              const SizedBox(height: 16),
              Text("SeniorCare", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Intelligent Health Surveillance", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted)),
              const SizedBox(height: 48),
              _buildRoleCard(context, "Patient", "Monitor my health", FontAwesomeIcons.user, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Patient')));
              }),
              _buildRoleCard(context, "Family", "Check on loved ones", FontAwesomeIcons.houseUser, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Family')));
              }),
              _buildRoleCard(context, "Doctor", "Analyze patient data", FontAwesomeIcons.userDoctor, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Doctor')));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 24, color: AppColors.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
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

// --- SCREEN 2: LOGIN ---
class LoginScreen extends StatelessWidget {
  final String role;
  const LoginScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textMuted),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Login", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text("Login for: $role", style: const TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TextField(decoration: InputDecoration(labelText: "Email", hintText: "doctor@hospital.com", prefixIcon: Icon(Icons.email_outlined))),
                    const SizedBox(height: 16),
                    const TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", hintText: "••••••••", prefixIcon: Icon(Icons.lock_outline))),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainLayout(currentIndex: 0, role: role)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          shadowColor: AppColors.primary.withOpacity(0.3),
                        ),
                        child: const Text("Log In", style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- MAIN LAYOUT (BOTTOM NAVIGATION WRAPPER) ---
class MainLayout extends StatefulWidget {
  final int currentIndex;
  final String role;
  const MainLayout({super.key, required this.currentIndex, required this.role});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _changeTab(int index) {
    setState(() { _currentIndex = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border, width: 1)), color: Colors.white),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.settings, "Settings", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () => _changeTab(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? AppColors.primary : AppColors.textMuted, size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: isActive ? AppColors.primary : AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _getBody() {
    if (_currentIndex == 1) return const SettingsScreen();
    if (widget.role == 'Patient') return const PatientDashboard();
    if (widget.role == 'Family') return const FamilyDashboard();
    return const DoctorDashboard();
  }
}

// --- SCREEN 3: PATIENT DASHBOARD ---
class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello, Mr. Dupont", style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: const Text("System Active", style: TextStyle(color: Color(0xFF166534), fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(70),
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(70),
                        boxShadow: [BoxShadow(color: AppColors.danger.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.bell, size: 32, color: Colors.white),
                          SizedBox(height: 8),
                          Text("SOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Heart Rate", style: TextStyle(color: AppColors.textMuted)), RichText(text: const TextSpan(children: [TextSpan(text: "72 ", style: TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.bold)), TextSpan(text: "bpm", style: TextStyle(color: AppColors.textMuted, fontSize: 14))]))]))),
                  Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Movement", style: TextStyle(color: AppColors.textMuted)), Text("Normal", style: TextStyle(fontWeight: FontWeight.bold))]))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// --- SCREEN 4: FAMILY DASHBOARD ---
class FamilyDashboard extends StatelessWidget {
  const FamilyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(16), color: Colors.white, child: Text("Family Dashboard", style: Theme.of(context).textTheme.headlineSmall)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    color: AppColors.success.withOpacity(0.05),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: AppColors.success, width: 1)),
                    child: const Padding(padding: EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Everything is Fine", style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 18)), SizedBox(height: 8), Text("No anomalies detected today.", style: TextStyle(color: AppColors.textMuted))])),
                  ),
                  Card(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Padding(padding: EdgeInsets.all(12.0), child: Text("LIVE FEED", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textMuted))),
                      Container(height: 150, margin: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8),), child: const Center(child: Icon(FontAwesomeIcons.video, size: 32, color: Colors.white))),
                      const Padding(padding: EdgeInsets.all(12.0), child: Text("Living Room • Camera 1", style: TextStyle(fontSize: 12, color: AppColors.textMuted), textAlign: TextAlign.center)),
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// --- SCREEN 5: DOCTOR DASHBOARD ---
class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  String selectedFilter = "All Patients";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Welcome back,", style: TextStyle(fontSize: 12, color: AppColors.textMuted)), Text("Dr. Martin", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))]), Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)), child: const Icon(FontAwesomeIcons.userDoctor, color: AppColors.primaryDark))]),
                const SizedBox(height: 16),
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)), child: const Row(children: [Icon(FontAwesomeIcons.magnifyingGlass, color: AppColors.textMuted, size: 18), SizedBox(width: 10), Text("Search patients...", style: TextStyle(color: AppColors.textMuted, fontSize: 14))])),
                const SizedBox(height: 16),
                SizedBox(height: 32, child: ListView(scrollDirection: Axis.horizontal, children: [_buildFilterChip("All Patients"), _buildFilterChip("Critical (2)"), _buildFilterChip("Stable (15)")]))
              ],
            ),
          ),
          Expanded(child: ListView(padding: const EdgeInsets.all(16), children: dummyPatients.map((patient) => _buildPatientCard(context, patient)).toList()))
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isActive = selectedFilter == label;
    return Padding(padding: const EdgeInsets.only(right: 8.0), child: ChoiceChip(label: Text(label, style: const TextStyle(fontSize: 12)), selected: isActive, onSelected: (bool selected) { setState(() { selectedFilter = label; }); }, backgroundColor: Colors.white, selectedColor: AppColors.primary, labelStyle: TextStyle(color: isActive ? Colors.white : AppColors.textMuted), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isActive ? AppColors.primary : AppColors.border))));
  }

  Widget _buildPatientCard(BuildContext context, Patient patient) {
    Color badgeColor;
    String badgeText;
    switch(patient.status) {
      case 'critical': badgeColor = AppColors.danger; badgeText = "Critical"; break;
      case 'warning': badgeColor = AppColors.warning; badgeText = "Review"; break;
      default: badgeColor = AppColors.success; badgeText = "Stable";
    }

    return Card(clipBehavior: Clip.antiAlias, child: InkWell(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => PatientDetailScreen(patient: patient))); }, child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(patient.name, style: const TextStyle(fontWeight: FontWeight.bold)), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: badgeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(badgeText, style: TextStyle(color: badgeColor.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold)))]),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("${patient.age} years • ${patient.gender}", style: const TextStyle(fontSize: 12, color: AppColors.textMuted)), Row(children: [const Icon(FontAwesomeIcons.clock, size: 10, color: AppColors.textMuted), const SizedBox(width: 4), Text(patient.timeAgo, style: const TextStyle(fontSize: 12, color: AppColors.textMuted))])]),
      if (patient.alertMsg != null) ...[const SizedBox(height: 8), Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(4)), child: Row(children: [const Icon(FontAwesomeIcons.triangleExclamation, color: Color(0xFF92400E), size: 12), const SizedBox(width: 6), Expanded(child: Text(patient.alertMsg!, style: const TextStyle(color: Color(0xFF92400E), fontSize: 11)))]))]
    ]))));
  }
}

// --- SCREEN 6: PATIENT DETAIL ---
class PatientDetailScreen extends StatelessWidget {
  final Patient patient;
  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.primary), onPressed: () => Navigator.pop(context)), title: const Text("Back", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)), actions: const [Icon(Icons.more_vert, color: AppColors.textMuted), SizedBox(width: 8)], elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(color: Colors.white, padding: const EdgeInsets.all(16), child: Column(children: [Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primaryLight, width: 3)), child: const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://picsum.photos/seed/grandpa/80/80'))), const SizedBox(height: 12), Text(patient.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text("ID: ${patient.id} • Room 204", style: const TextStyle(color: AppColors.textMuted, fontSize: 12)), const SizedBox(height: 8), _buildStatusBadge(patient.status)])),
            const SizedBox(height: 16),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("REAL-TIME VITALS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
              const SizedBox(height: 8),
              GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, children: const [_VitalBox(value: "145/95", label: "BP (mmHg)"), _VitalBox(value: "98", label: "SpO2 (%)"), _VitalBox(value: "72", label: "Pulse (bpm)"), _VitalBox(value: "36.8°", label: "Temp (°C)")]),
              const SizedBox(height: 24),
              const Text("DEEP LEARNING ANALYSIS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
              const SizedBox(height: 8),
              Card(child: Padding(padding: const EdgeInsets.all(12.0), child: Column(children: [_AIItem(icon: FontAwesomeIcons.personWalking, title: "Gait Analysis", desc: "Detected irregular walking pattern."), const Divider(height: 24), _AIItem(icon: FontAwesomeIcons.bed, title: "Sleep Quality", desc: "Poor sleep duration (4h 20m).")]))),
              const SizedBox(height: 24),
              const Text("PRESCRIPTIONS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
              const SizedBox(height: 8),
              Card(child: Padding(padding: const EdgeInsets.all(12.0), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Amlodipine", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text("5mg", style: TextStyle(color: AppColors.textMuted, fontSize: 12))]), const SizedBox(height: 4), const Text("Take 1 tablet daily with breakfast.", style: TextStyle(color: AppColors.textMuted, fontSize: 12)), const Divider(height: 24), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Metformin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text("500mg", style: TextStyle(color: AppColors.textMuted, fontSize: 12))]), const SizedBox(height: 4), const Text("Take 1 tablet after dinner.", style: TextStyle(color: AppColors.textMuted, fontSize: 12))]))),
              const SizedBox(height: 24),
              Row(children: [Expanded(child: ElevatedButton.icon(icon: const Icon(FontAwesomeIcons.phone, size: 16), label: const Text("Call Family"), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), onPressed: () {})), const SizedBox(width: 10), Expanded(child: OutlinedButton.icon(icon: const Icon(FontAwesomeIcons.commentMedical, size: 16), label: const Text("Message"), style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.primary), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), onPressed: () {}))]),
              const SizedBox(height: 32),
            ]))
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg; Color fg; String text;
    if (status == 'critical') { bg = AppColors.danger.withOpacity(0.1); fg = const Color(0xFF991b1b); text = "Critical"; }
    else if (status == 'stable') { bg = AppColors.success.withOpacity(0.1); fg = const Color(0xFF166534); text = "Stable"; }
    else { bg = AppColors.warning.withOpacity(0.1); fg = const Color(0xFF92400e); text = "Review Needed"; }
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)), child: Text(text, style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.bold)));
  }
}

// --- HELPER WIDGETS ---
class _VitalBox extends StatelessWidget {
  final String value;
  final String label;
  const _VitalBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFf8fafc), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(value, style: const TextStyle(color: AppColors.primaryDark, fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11))]));
  }
}

class _AIItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _AIItem({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(6)), child: Icon(icon, color: AppColors.primaryDark, size: 16)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 2), Text(desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 12))]))]);
  }
}

// --- SCREEN 7: SETTINGS ---
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(16), color: Colors.white, child: Text("Settings", style: Theme.of(context).textTheme.headlineSmall)),
          Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
            Card(child: ListTile(title: const Text("Notifications"), trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted), onTap: () {})),
            Card(child: ListTile(title: const Text("Account Security"), trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted), onTap: () {})),
            const SizedBox(height: 32),
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const RoleSelectionScreen()), (route) => false); }, style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.danger), foregroundColor: AppColors.danger), child: const Text("Log Out")))
          ]))
        ],
      ),
    );
  }
}