class ApiEndPoint {
  static const String baseUrl = 'https://mvpitch.com';
  //static const String baseUrl = 'https://7025aa2bacb2.ngrok-free.app';
  static const String socketUrl = 'https://mvpitch.com';

  static String imagePath(String imageUrl) =>
      '$baseUrl/uploads/images/$imageUrl';


  // auth
  static const String login = '$baseUrl/api/users/login';
  static const String checkUser = '$baseUrl/api/users/check';
  static const String createAdminAccount = '$baseUrl/api/users/register';
  static const String getUserDetails = '$baseUrl/api/users/check';
  static const String forgotPassword =
      '$baseUrl/api/users/request-forgot-password-otp';
  static const String resetPassword =
      '$baseUrl/api/users/reset-forgot-password';
  static const String changeEmail = '$baseUrl/api/users/emailUpdate';
  static String updateUser(String userId) =>
      '$baseUrl/api/users/update-profile/$userId';

  //
  static const String addNewPlayer = '$baseUrl/api/admin/new-palyer-create';
  static const String createMatch = '$baseUrl/api/admin/create-match';
  static String updateMatch(String matchId) =>
      '$baseUrl/api/match/simple_updateMatch/$matchId';
  static const String getAllParentList = '$baseUrl/api/admin/all-parents';

  // admin home
  static const String adminHomeData = '$baseUrl/api/admin/home-data';

  // user management
  static const String getAllPlayerList = '$baseUrl/api/admin//all-Player';

  // match management
  static String getAllMatchList =
      '$baseUrl/api/match/all-match';

  static String selectPlayerForMatch(String matchId) =>
      '$baseUrl/api/admin/$matchId/update-players';

  static String editMatch(String matchId) =>
      "$baseUrl/api/match/one-match-details/$matchId";

  static String matchDetail(String matchId) =>
      "$baseUrl/api/match/one-match-details/$matchId";

  static String matchStart(String matchId) =>
      "$baseUrl/api/match//time-mangement/$matchId";
  static String mathResultPublish(String matchId) =>
      "$baseUrl/api/match/updateMatch/$matchId";

  static String startVote(String matchId) =>
      "$baseUrl/api/vote/$matchId/start-voting";
  static String submitVote = "$baseUrl/api/vote/vote";

  static String getOnePlayerDetail(String playerId) =>
      "$baseUrl/api/admin/single-player/$playerId";

  static String oneMatchAllParents(String matchId) =>
      "$baseUrl/api/admin/onematchAllparents/$matchId";

  static String voteHandOver(String matchId) =>
      "$baseUrl/api/vote/vote-hand-over/$matchId";

  static String votHandOverRequest(String matchId) =>
      "$baseUrl/api/vote/totalvoteOnematch/$matchId";

  static String totalHanoverVote(String matchId) =>
      "$baseUrl/api/vote/matches/$matchId/not-given-votes/count";

  static String acceptHandOver(String matchId, String parentId) =>
      "$baseUrl/api/vote/accept_handoverVote/${matchId}/$parentId";

  static const String getNotification = '/api/notification/manger-notification';

  static String voteEnd(String matchId) =>
      "$baseUrl/api/vote/$matchId/end-voting";

  static String oneParentAllMatchPast(String parentId) =>
      "$baseUrl/api/match/parentallmatch/$parentId";

  static String manOfTheMatch(String matchId) =>
      "$baseUrl/api/vote/$matchId/results";

  static String playerSubstitution(String matchId) =>
      "$baseUrl/api/match/substitution/$matchId";

  static String managerPlayerOfTheMatch(String matchId) =>
      "$baseUrl/api/admin/$matchId/manager-player-of-the-match";

  static String oneManagerAllMatch =
      "$baseUrl/api/users/oneuser/as-Amangaer/allmatches";

  static String adminAllMatchHistory = "$baseUrl/api/admin/all-matches";
  static String oneMatchDetail(String matchId) =>
      "$baseUrl/api/match/one-match-details/$matchId";
  static String editPLayer(String playersId) =>
      "$baseUrl/api/admin/palyer-data-upadte/$playersId";
  static String playerDelete(String playersId) =>
      "$baseUrl/api/admin/delete-player/$playersId";
  static String matchDelete(String matchId) =>
      "$baseUrl/api/match/delete-match/$matchId";
  static String matchCancel(String matchId) =>
      "$baseUrl/api/match/cancel-match/$matchId";
}
