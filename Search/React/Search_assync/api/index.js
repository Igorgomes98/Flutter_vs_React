import _ from "lodash";
import cities from "./cities";

export const contains = ({city}, query) => {
    if (city.includes(query)) {
        return true;
    }

    return false;
};

export const getCities = (limit = 385, query = "") => {
    return new Promise((resolve, reject) => {
        if (query.length === 0) {
            resolve(_.take(cities, limit));
        } else {
            const formattedQuery = query.toLowerCase();
            const results = _.filter(cities, city => {
                return contains(city, formattedQuery);
            });
            resolve(_.take(results, limit));
        }
    });
};

export default getCities;