abstract class HistoryStates {}

class HistoryInitialState extends HistoryStates {}

// Get All History States

class GetAllHistoryLoadingState extends HistoryStates {}

class GetAllHistoryPaginationLoadingState extends HistoryStates {}

class GetAllHistorySuccessState extends HistoryStates {}

class GetAllHistoryErrorState extends HistoryStates {}

// Get History By Id
class GetHistoryByIdErrorState extends HistoryStates {}

class GetHistoryByIdSuccessState extends HistoryStates {}

class GetHistoryByIdLoadingState extends HistoryStates {}

class UpdateHistoryLoadingState extends HistoryStates {}

class UpdateHistorySuccessState extends HistoryStates {}
