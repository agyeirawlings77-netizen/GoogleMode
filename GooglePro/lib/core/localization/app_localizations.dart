import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizations(const Locale('en'));

  static const supportedLocales = [Locale('en'), Locale('fr'), Locale('es'), Locale('ar'), Locale('pt'), Locale('hi'), Locale('yo'), Locale('zh'), Locale('de'), Locale('ja')];

  static const _strings = {
    'en': {
      'appName': 'GooglePro', 'signIn': 'Sign In', 'signUp': 'Sign Up', 'email': 'Email', 'password': 'Password', 'forgotPassword': 'Forgot Password?', 'noAccount': "Don't have an account?", 'hasAccount': 'Already have an account?', 'dashboard': 'Dashboard', 'devices': 'Devices', 'settings': 'Settings', 'notifications': 'Notifications', 'profile': 'Profile', 'signOut': 'Sign Out', 'connect': 'Connect', 'disconnect': 'Disconnect', 'online': 'Online', 'offline': 'Offline', 'connecting': 'Connecting...', 'screenShare': 'Screen Share', 'remoteControl': 'Remote Control', 'fileTransfer': 'File Transfer', 'chat': 'Chat', 'voiceCall': 'Voice Call', 'location': 'Location', 'parentalControls': 'Parental Controls', 'security': 'Security', 'appLock': 'App Lock', 'trustedDevices': 'Trusted Devices', 'aiAssistant': 'AI Assistant', 'loading': 'Loading...', 'error': 'Error', 'retry': 'Retry', 'cancel': 'Cancel', 'save': 'Save', 'delete': 'Delete', 'edit': 'Edit', 'ok': 'OK', 'yes': 'Yes', 'no': 'No',
    },
    'fr': {
      'appName': 'GooglePro', 'signIn': 'Se connecter', 'signUp': "S'inscrire", 'email': 'E-mail', 'password': 'Mot de passe', 'dashboard': 'Tableau de bord', 'devices': 'Appareils', 'settings': 'Paramètres', 'online': 'En ligne', 'offline': 'Hors ligne', 'connect': 'Connecter', 'disconnect': 'Déconnecter', 'loading': 'Chargement...', 'cancel': 'Annuler', 'save': 'Enregistrer',
    },
    'es': {
      'appName': 'GooglePro', 'signIn': 'Iniciar sesión', 'signUp': 'Registrarse', 'email': 'Correo electrónico', 'password': 'Contraseña', 'dashboard': 'Panel', 'devices': 'Dispositivos', 'settings': 'Ajustes', 'online': 'En línea', 'offline': 'Fuera de línea', 'connect': 'Conectar', 'loading': 'Cargando...', 'cancel': 'Cancelar', 'save': 'Guardar',
    },
    'ar': {
      'appName': 'GooglePro', 'signIn': 'تسجيل الدخول', 'signUp': 'إنشاء حساب', 'email': 'البريد الإلكتروني', 'password': 'كلمة المرور', 'dashboard': 'لوحة التحكم', 'devices': 'الأجهزة', 'settings': 'الإعدادات', 'online': 'متصل', 'offline': 'غير متصل', 'connect': 'اتصال', 'loading': 'جاري التحميل...', 'cancel': 'إلغاء', 'save': 'حفظ',
    },
  };

  String t(String key) {
    final langCode = locale.languageCode;
    return (_strings[langCode] ?? _strings['en']!)[key] ?? _strings['en']![key] ?? key;
  }

  // Convenience getters
  String get appName => t('appName');
  String get signIn => t('signIn');
  String get signUp => t('signUp');
  String get email => t('email');
  String get password => t('password');
  String get dashboard => t('dashboard');
  String get devices => t('devices');
  String get settings => t('settings');
  String get online => t('online');
  String get offline => t('offline');
  String get connect => t('connect');
  String get disconnect => t('disconnect');
  String get loading => t('loading');
  String get cancel => t('cancel');
  String get save => t('save');
  String get screenShare => t('screenShare');
  String get remoteControl => t('remoteControl');
  String get signOut => t('signOut');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();
  @override bool isSupported(Locale locale) => AppLocalizations.supportedLocales.map((l) => l.languageCode).contains(locale.languageCode);
  @override Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);
  @override bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
