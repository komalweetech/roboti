abstract class NewsEvent {}

class NewsInitialEvent extends NewsEvent {}

class FetchGlobalNewsEvent extends NewsEvent {}

class FetchRobotiNewsEvent extends NewsEvent {}

class ResetNewsDataEvent extends NewsEvent {}

class GetPaginatedGlobalNewsEvent extends NewsEvent {}
