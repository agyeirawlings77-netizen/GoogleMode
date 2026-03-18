import 'package:flutter/foundation.dart';
import '../model/dashboard_stats.dart';
class DashboardViewModel extends ChangeNotifier {
  DashboardStats _stats = const DashboardStats();
  bool _isLoading = false;
  DashboardStats get stats => _stats;
  bool get isLoading => _isLoading;
  void setStats(DashboardStats v) { _stats = v; notifyListeners(); }
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
}
