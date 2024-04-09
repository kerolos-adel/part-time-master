abstract class JobStates {}

class JobInitialState extends JobStates {}

class PostJobOnProgressState extends JobStates {}

class PostJobFinishedState extends JobStates {}

class PickDeadlineState extends JobStates {}

class GetMyJobsOnProgressState extends JobStates {}

class GetMyJobsFinishedState extends JobStates {}

class GetAllJobsOnProgressState extends JobStates {}

class GetAllJobsFinishedState extends JobStates {}

class DeleteJobOnProgressState extends JobStates {}

class DeleteJobFinishedState extends JobStates {}

class UpdateJobOnProgressState extends JobStates {}

class UpdateJobFinishedState extends JobStates {}

