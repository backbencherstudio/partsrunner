class LiveTracking {
  final String redisKey;
  final dynamic latestPoint;

  LiveTracking({
    required this.redisKey,
    this.latestPoint,
  });

  factory LiveTracking.fromJson(Map<String, dynamic> json) {
    return LiveTracking(
      redisKey: json['redis_key'],
      latestPoint: json['latest_point'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'redis_key': redisKey,
      'latest_point': latestPoint,
    };
  }
}