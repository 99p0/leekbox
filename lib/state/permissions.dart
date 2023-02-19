/// If our user is signed out, this provider returns [UserRole.none]
/// Otherwise, it mocks a network request and gives out some [UserRole].
// final permissionsProvider = FutureProvider.autoDispose<UserRole>((ref) async {
//   final userId = await ref.watch(authNotifierProvider.future);
//
//   if (userId == null) return UserRole.none;
//
//   return _requestMock();
// });
//
// /// Gives a random [UserRole] based on a dice roll.
// UserRole _requestMock() {
//   // mock
//   final random = Random().nextBool();
//
//   if (random) {
//     return UserRole.user;
//   } else {
//     return UserRole.guest;
//   }
// }
