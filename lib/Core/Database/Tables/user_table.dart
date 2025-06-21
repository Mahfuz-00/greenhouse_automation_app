class UserTable {
  static const String tableName = 'users';
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone1 = 'phone1';
  static const String phone2 = 'phone2';
  static const String profilePicture = 'profile_picture';
  static const String isAdmin = 'is_admin';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $id TEXT PRIMARY KEY,
      $name TEXT NOT NULL,
      $email TEXT NOT NULL UNIQUE,
      $phone1 TEXT NOT NULL,
      $phone2 TEXT,
      $profilePicture TEXT,
      $isAdmin INTEGER NOT NULL DEFAULT 0
    )
  ''';
}