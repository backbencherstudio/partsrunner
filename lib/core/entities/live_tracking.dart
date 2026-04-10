class LiveTracking {
  String? redisKey;
  String? latestPoint;

  LiveTracking({this.redisKey, this.latestPoint});

  LiveTracking.fromJson(Map<String, dynamic> json) {
    redisKey = json['redis_key'];
    latestPoint = json['latest_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['redis_key'] = redisKey;
    data['latest_point'] = latestPoint;
    return data;
  }
}
