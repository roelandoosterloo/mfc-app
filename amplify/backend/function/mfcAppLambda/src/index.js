/* Amplify Params - DO NOT EDIT
    API_MFCAPP_GRAPHQLAPIENDPOINTOUTPUT
    API_MFCAPP_GRAPHQLAPIIDOUTPUT
    AUTH_MFCAPPF4FDFC42_USERPOOLID
    ENV
    REGION
Amplify Params - DO NOT EDIT */

const admin = require('./adminClient');
const graphApi = require('./graphApi');

const generateSchedule = (startDate, modules) => {
    var date = startDate;
    const schedule = [];
    modules.sort((a, b) => a.index - b.index);
    for (const module of modules) {
        const available = new Date(date.valueOf());
        const delay = module.delayNumber;
        switch (module.delayUOM) {
            case 'MINUTE':
                available.setMinutes(available.getMinutes() + delay);
                break;
            case 'HOUR':
                available.setHours(available.getHours() + delay);
                break;
            case 'DAY':
                available.setDate(available.getDate() + delay);
                break;
            case 'WEEK':
                available.setDate(available.getDate() + delay * 7);
                break;
            case 'MONTHS':
                available.setMonth(available.getMonth() + delay);
                break;
        }
        schedule.push({ 
            moduleId: module.id, 
            availableAt: available
        });
        date = available;
    }
    return schedule;
}

const createUser = async (email) => {
    const user = await admin.createUser(email);
    const username = user.Username;
    await graphApi.createUser(username, email);
    return user;
}

const subscribeUser = async (username, courseId) => {
    const course = await graphApi.getCourse(courseId);
    console.log(course);
    if (!course) {
        throw Error("Could not find course");
    }

    const startDate = new Date();

    const enrollment = await graphApi.createEnrollment(username, courseId, startDate);
    if (!enrollment) {
        throw Error("could not enroll user");
    }

    const schedule = generateSchedule(startDate, course.modules.items);
    for(const entry of schedule) {
        await graphApi.createModuleProgress(entry.moduleId, enrollment.id, entry.availableAt);
    }

    await admin.addUserToGroup(username, course.accessGroup);

}

const resolvers = {
    Query: {
        adminListUsers: async ctx => {
            return await admin.listUsers();
        },
        adminListGroups: async ctx => {
            return await admin.listGroups();
        }
    },
    Mutation: {
        adminAddUserToGroup: async ctx => {
            const { username, groupName } = ctx.arguments;
            return await admin.addUserToGroup(username, groupName);
        },
        subscribeUser: async ctx => {
            const { username, courseId } = ctx.arguments;
            await subscribeUser(username, courseId);
            return true;
        },
        adminCreateUser: async ctx => {
            return await createUser(ctx.arguments.username);
        },
        adminDeleteUser: async ctx => {
            const { username } = ctx.arguments;
            return await admin.deleteUser(username)
        },
        adminCreateGroup: async ctx => {
            const { groupName, description } = ctx.arguments;
            return await admin.createGroup(groupName, description);
        }
    }
}

exports.handler = async (event) => {
    const typeHandler = resolvers[event.typeName];
    if (typeHandler) {
        const resolver = typeHandler[event.fieldName];
        if (resolver) {
            return await resolver(event);
        }
    }
    throw new Error("Resolver not found.");
};
