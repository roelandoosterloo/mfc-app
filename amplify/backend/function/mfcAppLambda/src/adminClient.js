const { CognitoIdentityServiceProvider } = require('aws-sdk');
const { v4: uuid } = require('uuid')

const cognitoClient = new CognitoIdentityServiceProvider();
const POOL_ID = process.env.AUTH_MFCAPPF4FDFC42_USERPOOLID;

const createUser = async (email) => {
  try {
    const checkList = await cognitoClient.listUsers({
      UserPoolId: POOL_ID,
      Filter: `email="${email}"`,
    }).promise();
    if (checkList.Users.length > 0) {
      throw new Error("User already exists");
    }
  } catch (ex) {
    console.error(ex);
    throw new Error("Could not verify user");
  }
  try {
    const userId = uuid();
    const user = await cognitoClient.adminCreateUser({
      UserPoolId: POOL_ID,
      Username: userId,
      DesiredDeliveryMediums: ["EMAIL"],
      UserAttributes: [{
        Name: "email",
        Value: email,
      }]
    }).promise();
    return user.User;
  } catch (ex) {
    console.error(ex);
    throw new Error("user not created");
  }
}

const addUserToGroup = async (username, groupName) => {
  try {
    await cognitoClient.adminAddUserToGroup({
      UserPoolId: POOL_ID,
      Username: username,
      GroupName: groupName,
    }).promise();
    return true;
  } catch (ex) {
    console.error(ex);
    throw new Error("User not added to group");
  }
}

const listUsers = async () => {
  try {
    const res = await cognitoClient.listUsers({
      UserPoolId: POOL_ID,
    }).promise();
    return res.Users;
  } catch (ex) {
    console.error(ex);
    throw new Error("Users not found");
  }
}

const listGroups = async () => {
  try {
    const res = await cognitoClient.listGroups({
      UserPoolId: POOL_ID,
    }).promise();
    console.log(res);
    return res.Groups;
  } catch (ex) {
    console.error(ex);
    throw new Error("Groups nto found");
  }
}

const deleteUser = async (username) => {
  try {
    await cognitoClient.adminDeleteUser({
      UserPoolId: POOL_ID,
      Username: username,
    }).promise();
    return true;
  } catch (ex) {
    console.error(ex);
    throw new Error("User not deleted");
  }
}

const createGroup = async (groupName, description) => {
  try {
    return await cognitoClient.createGroup({
      UserPoolId: POOL_ID,
      GroupName: groupName,
      Description: description,
    }).promise();
  } catch (ex) {
    console.error(ex);
    throw new Error("Group not created");
  }
}

module.exports = {
  addUserToGroup,
  createUser,
  createGroup,
  deleteUser,
  listUsers,
  listGroups,
}