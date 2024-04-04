abstract class JobStates {}

class JobInitialState extends JobStates {}

class PostJobState extends JobStates {}

class PickDeadlineState extends JobStates {}

class GetMyJobsState extends JobStates {}

class GetAllJobsState extends JobStates {}