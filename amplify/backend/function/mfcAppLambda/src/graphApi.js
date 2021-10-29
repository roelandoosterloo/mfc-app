const gql = require('graphql-tag');
const graphql = require('graphql');
const axios = require('axios');

const API_ID = process.env.API_MFCAPP_GRAPHQLAPIIDOUTPUT;
const API_ENDPOINT = process.env.API_MFCAPP_GRAPHQLAPIENDPOINTOUTPUT;
const API_KEY = process.env.API_MFCAPP_GRAPHQLAPIKEYOUTPUT;

const makeRequest = async (query, variables) => {
  console.log({ API_ENDPOINT, API_ID, API_KEY });
  const response = await axios({
    url: API_ENDPOINT,
    method: 'POST',
    headers: {
      'x-api-key': API_ID
    },
    data: {
      query: graphql.print(query),
      variables,
    },
  });

  return response;
}

const hasData = (response) => {
  return response && response.data && response.data.data;
}

const getCourse = async (id) => {
  const courseQuery = gql`
  query getCourse($id: ID!) {
      getCourse(id: $id) {
          id
          name
          accessGroup
          modules {
            items {
              id
              index
              delayNumber
              delayUOM
            }
          }
      }
  }`
  const response = await makeRequest(courseQuery, { id });
  if (hasData(response)) {
    return response.data.data.getCourse;
  }
}

const createEnrollment = async (cognitoId, courseId, startDate) => {
  const enrollmentMutation = gql`
    mutation enrollUser($input: CreateEnrollmentInput!) {
        createEnrollment(input: $input) {
            id
        }
    }
    `
  const input = {
    cognitoId,
    courseId,
    startDate,
  };
  const response = await makeRequest(enrollmentMutation, { input });
  if (hasData(response)) {
    return response.data.data.createEnrollment;
  }
}

const createModuleProgress = async (moduleId, enrollmentId, availableAt) => {
  const progressMutation = gql`
  mutation createModuleProgress($input: CreateModuleProgressInput!) {
    createModuleProgress(input: $input) {
      id
    }
  }
  `
  const input = {
    moduleId,
    enrollmentId,
    availableAt,
  }
  const response = await makeRequest(progressMutation, input);
  if (hasData(response)) {
    return response.data.data.createModuleProgress;
  }
}

const createUser = async (cognitoId, email) => {
  const profileMutation = gql`
  mutation createProfile($input: CreateProfileInput!) {
    createProfile(input: $input) {
      id
    }
  }
  `
  const input = {
    cognitoId,
    email,
  };
  const response = await makeRequest(profileMutation, input);
  if (hasData(response)) {
    return response.data.data.createProfile;
  }
}

module.exports = {
  createEnrollment,
  createModuleProgress,
  createUser,
  getCourse
}