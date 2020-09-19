import 'dart:ffi';

import 'libc.dart';
import '../posix_exception.dart';

// on systems with _POSIX_SAVED_IDS defined
typedef _seteuid_func = Int32 Function(Uint32 euid);
typedef _seteuid = int Function(int euid);

/// Gets the effective user id (euid)
/// The effective user id is the processes currently active uid
/// and is used when checking if the process has permission to
/// access a resource.
///
/// See: getreuid
void seteuid(int euid) {
  final seteuidPointer = Libc().lookup<_seteuid_func>('seteuid');
  final seteuid = seteuidPointer.asFunction<_seteuid>();

  var result = seteuid(euid);

  if (result != 0) {
    throw PosixException('Unable to set the Effective UID: $result', result);
  }
}
