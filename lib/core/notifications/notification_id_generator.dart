class NotificationIdGenerator {
  static int fromMedicine(String medicineId, int index) {
    return medicineId.hashCode.abs() + (index * 1000);
  }

  static int fromReminder(String reminderId) {
    return reminderId.hashCode;
  }
}