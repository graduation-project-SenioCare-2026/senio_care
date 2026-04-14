class NotificationIdGenerator {
  static int fromMedicine(String medicineId, int index) {
    return (medicineId.hashCode.abs() % 100000) + (index * 1000);
  }

  // ✅ Add this
  static int fromMedicineReminder(String medicineId, int index) {
    return (medicineId.hashCode.abs() % 100000) + (index * 1000) + 50000;
  }

  static int fromReminder(String reminderId) {
    return reminderId.hashCode;
  }
}