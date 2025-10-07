import '../models/launchModel.dart';
import '../models/rocketModel.dart';
import '../services/spaceXAPI.dart';


class LaunchRepository {
  final SpaceXAPI api;
  LaunchRepository(this.api);

  Future<List<Launch>> upcomingLaunches() => api.getUpcomingLaunches();
  Future<Rocket> rocketFor(String rocketId) => api.getRocket(rocketId);
}