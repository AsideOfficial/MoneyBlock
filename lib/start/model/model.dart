class MCUser {
  final String name;
  final String phoneNumber;
  final String birthday;
  final String gender;
  final String? parentInfo;
  final String? location;

  const MCUser({
    required this.name,
    required this.phoneNumber,
    required this.birthday,
    required this.gender,
    this.parentInfo,
    this.location,
  });
}
