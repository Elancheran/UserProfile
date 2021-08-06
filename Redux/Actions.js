export const SET_USER_NAME = 'SET_USER_NAME';
export const SET_USER_EMAIL = 'SET_USER_EMAIL';
export const SET_LIKED_USERS = 'SET_LIKED_USERS';

export const setName = name => dispatch => {
    dispatch({
        type: SET_USER_NAME,
        payload: name,
    });
};

export const setEmail = email => dispatch => {
    dispatch({
        type: SET_USER_EMAIL,
        payload: email,
    });
};

export const setLikedUsers = user => dispatch => {
    dispatch({
        type: SET_LIKED_USERS,
        payload: user,
    });
};