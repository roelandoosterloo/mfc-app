import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/ModelProvider.dart';

class Queries {
  Queries._();

  static GraphQLRequest<PaginatedResult<Membership>> listSubscribedCourses() {
    const listMemberships = 'listMemberships';
    String graphQLDocument = '''
      query ListSubscribedCourses  {
        $listMemberships (limit: 1000) {
          items {
            program {
              courses {
                items {
                  course {
                    id
                    name
                    description
                    coverImage
                  }
                }
              }
            }
          }
        }
      }
    ''';
    return GraphQLRequest<PaginatedResult<Membership>>(
      document: graphQLDocument,
      modelType: PaginatedModelType(Membership.classType),
      decodePath: listMemberships,
    );
  }

  static GraphQLRequest<PaginatedResult<Enrollment>> listEnrolledCourses() {
    const listEnrollments = 'listEnrollments';
    String graphQLDocument = ''' 
    query ListEnrolledCourses {
      $listEnrollments (limit: 1000) {
        items {
          id
          enrolledAt
          startedAt
          completedAt
          moduleSchedule {
            items {
              id
              enrollmentId
              availableAt
              completedAt
            }
          }
          course {
            id
            name
            description
            coverImage
          }
        }
      }
    }
    ''';
    return GraphQLRequest<PaginatedResult<Enrollment>>(
      document: graphQLDocument,
      modelType: PaginatedModelType(Enrollment.classType),
      decodePath: listEnrollments,
    );
  }

  static GraphQLRequest<Enrollment> getEnrollment(String id) {
    const getEnrollment = 'getEnrollment';
    String graphQLDocument = '''
      query GetEnrollment (\$id: ID!) {
        $getEnrollment(id: \$id) {
          id
          enrolledAt
          startedAt
          completedAt
          course {
            id
            name
            description
            coverImage
          }
          moduleSchedule (limit: 1000) {
            items {
              id
              enrollmentId
              availableAt
              startedAt
              completedAt
              module {
                index
                courseId
                name
                id
                coverImage
                description
                videoUrl
                delayNumber
                delayUOM
              }
            }
          }
        }
      }
    ''';
    return GraphQLRequest<Enrollment>(
      document: graphQLDocument,
      modelType: Enrollment.classType,
      variables: <String, String>{'id': id},
      decodePath: getEnrollment,
    );
  }

  static GraphQLRequest<ModuleProgress> getModuleProgress(String id) {
    const getModuleProgress = 'getModuleProgress';
    String graphQLDocument = '''
      query GetModuleProgress (\$id: ID!) {
        getModuleProgress(id: \$id) {
          id
          enrollmentId
          availableAt
          owner
          module {
            coverImage
            description
            courseId
            id
            name
            videoUrl
            index
            delayNumber
            delayUOM
            assignments (limit: 1000) {
              items {
                id
                moduleId
                type
                introduction
                question
                index
                options {
                  items {
                    id
                    questionId
                    label
                    index
                  }
                }
              }
            }
            tools {
              items {
                id
                moduleId
                name
                url
                index
              }
            }
          }
          workbook (limit: 1000) {
            items {
              id
              question {
                id
                question
              }
              moduleProgressId
              answer
            }
          }
        }
      }
    ''';
    return GraphQLRequest<ModuleProgress>(
      document: graphQLDocument,
      modelType: ModuleProgress.classType,
      variables: <String, String>{'id': id},
      decodePath: getModuleProgress,
    );
  }
}
