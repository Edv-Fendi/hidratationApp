import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int dailyGoal = 2000;
  int consumed = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dailyGoal = prefs.getInt('dailyGoal') ?? 2000;
      consumed = prefs.getInt('consumed') ?? 0;
    });
  }

  Future<void> _drinkWater(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      consumed += amount;
      if (consumed > dailyGoal) consumed = dailyGoal;
    });
    await prefs.setInt('consumed', consumed);
  }

  Color _getProgressColor(double percentage) {
    if (percentage >= 1.0) return Colors.green;
    if (percentage > 0.6) return Colors.blue;
    if (percentage > 0.25) return Colors.amber;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (consumed / dailyGoal).clamp(0.0, 1.0);
    final progressColor = _getProgressColor(percentage);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'HydroTrack 💧',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                Text(
                  'Meta diária: $dailyGoal ml',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Consumido: $consumed ml',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: percentage,
                  color: progressColor,
                  backgroundColor: Colors.grey[300],
                  minHeight: 14,
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '${(percentage * 100).toStringAsFixed(1)}% da meta atingida',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: progressColor,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                const Center(
                  child: Text(
                    'Beber',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildWaterButton(100),
                    _buildWaterButton(200),
                    _buildWaterButton(500),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaterButton(int amount) {
    return ElevatedButton(
      onPressed: () => _drinkWater(amount),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      child: Text(
        '$amount\nml',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
