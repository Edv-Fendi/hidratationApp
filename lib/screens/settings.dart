import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = TextEditingController();
  int _dailyGoal = 2000;
  int _consumed = 0;
  Duration? _selectedInterval;

  final List<Duration> intervals = [
    const Duration(minutes: 1), // teste
    const Duration(hours: 2),
    const Duration(hours: 4),
    const Duration(hours: 6),
    const Duration(hours: 8),
    const Duration(hours: 12),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyGoal = prefs.getInt('dailyGoal') ?? 2000;
      _consumed = prefs.getInt('consumed') ?? 0;
      _controller.text = _dailyGoal.toString();

      final savedMinutes = prefs.getInt('selectedIntervalMinutes');
      if (savedMinutes != null) {
        _selectedInterval = Duration(minutes: savedMinutes);
      }
    });
  }

  Future<void> _saveGoal() async {
    final prefs = await SharedPreferences.getInstance();
    final goal = int.tryParse(_controller.text);
    if (goal != null) {
      await prefs.setInt('dailyGoal', goal);
      await prefs.setInt('consumed', 0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meta salva e consumo resetado!')),
      );
    }
  }

  Future<void> _scheduleNotification(Duration interval) async {
    final alarmStatus = await Permission.scheduleExactAlarm.status;

    if (!alarmStatus.isGranted) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Permissão necessária'),
          content: const Text(
            'Para que os lembretes funcionem com o app fechado, '
            'você precisa ativar a permissão de "Alarmes Exatos" nas configurações do sistema.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text('Abrir configurações'),
            ),
          ],
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIntervalMinutes', interval.inMinutes);

    setState(() {
      _selectedInterval = interval;
    });

    await NotificationService().scheduleIntervalNotification(
      interval: interval,
      title: 'Hora de beber água!',
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Notificações a cada ${_formatDuration(interval)} configuradas!',
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d.inMinutes == 1) return '1 minuto (teste)';
    return '${d.inHours} horas';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Meta diária de água (ml)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ex: 2000',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _saveGoal,
                  icon: const Icon(Icons.check),
                  label: const Text('Salvar Meta'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(height: 40),
                const Text(
                  'Lembretes de Hidratação',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: intervals.map((interval) {
                    final isSelected = _selectedInterval == interval;
                    return ElevatedButton(
                      onPressed: () => _scheduleNotification(interval),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? Colors.blueAccent
                            : Colors.blueGrey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      child: Text(
                        _formatDuration(interval),
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
