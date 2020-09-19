import 'dart:ffi';

import 'libc.dart';
import '../posix_exception.dart';

/// on systems that don't support _POSIX_SAVED_IDS
/// sets the effective and real uids.
typedef _setreuid_func = Int32 Function(Uint32 realUID, Uint32 effectiveUID);
typedef _setreuid = int Function(int realUID, int effectiveUID);

/// Sets the real and effective user id (euid)
///
/// The effective user id [euid] is the processes currently active uid
/// and is used when checking if the process has permission to
/// access a resource.
///
/// The real user id [ruid] is the uid of the user that started the process.
///
/// See: getreuid
void setreuid(int ruid, int euid) {
  final setreuidPointer = Libc().lookup<_setreuid_func>('setreuid');
  final setreuid = setreuidPointer.asFunction<_setreuid>();

  var result = setreuid(ruid, euid);

  if (result != 0) {
    throw PosixException(
        'Unable to set the real and effetive UID: $result', result);
  }
}
