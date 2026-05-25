abstract class EndPointsConstants {
  static const String baseUrl = "https://seniocare-backend.onrender.com/";
  static const String aiBaseUrl =
      "https://unseclusive-katlyn-weakheartedly.ngrok-free.dev/";
  // static const String chatAiBaseUrl="https://unseclusive-katlyn-weakheartedly.ngrok-free.dev/";
  static const String aiSenioCareUrl =
      "https://senio-care--ayasserhashem.replit.app/";

  static const String googleSignIn = "auth/google";
  static const String elder = "elders/";
  static const String serviceProvider = "/service-providers/";
  static const String caregiver = "/caregivers/";
  static const String elderById = "/elders/{id}";
  static const String caregiverById = "/caregivers/{id}";
  static const String serviceProviderById = "/service-providers/{id}";
  static const String medicalDocs = "medical-documents/";
  static const String medicalDocsById = "medical-documents/{id}";
  static const String medicalDocByElder = "medical-documents/elder/{elder_id}";
  static const String services = "/services/";

  static const String addService = "/services/";
  static const String getService = "/services/provider/{service_provider_id}";
  static const String deleteService = "/services/{id}";
  static const String editService = "/services/{id}";
  static const String dailyReminderByDate = "/daily-medicines/elder/{elder_id}";
  static const String updateReminderState = "/daily-medicines/{id}/log";
  static const String deleteReminder = "/daily-medicines/{id}";

  static const String addMedicine = "/daily-medicines/";
  static const String createSession =
      '/apps/{app_name}/users/{user_id}/sessions/{session_id}';

  static const String runSse = '/run_sse';

  static const String getChatHistory = '/chat-history/{user_id}';
  static const String getChatConversation =
      '/chat-history/{user_id}/{session_id}';

  static const String getUser = "/users/{user_id}";

  static const String getReports = "/reports/{user_id}";
  static const String getReportsDetails = "/reports/{user_id}/{report_id}";
  static const String getUser="/users/{user_id}";
  static const String notification="/notifications/queue";
}
