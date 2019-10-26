import _ from "lodash";
import users from "./users";

export const contains = ({city}, query) => {
    //const { first, last } = name;
    if (city.includes(query)) {
        return true;
    }

    return false;
};

export const getUsers = (limit = 385, query = "") => {
    return new Promise((resolve, reject) => {
        if (query.length === 0) {
            resolve(_.take(users, limit));
        } else {
            const formattedQuery = query.toLowerCase();
            const results = _.filter(users, user => {
                return contains(user, formattedQuery);
            });
            resolve(_.take(results, limit));
        }
    });
};

export default getUsers;