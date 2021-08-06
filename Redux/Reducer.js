import { SET_USER_NAME, SET_USER_AGE, INCREASE_AGE, SET_USER_EMAIL, SET_LIKED_USERS } from './Actions';

const initialState = {
    name: '',
    email: '',
    users: []
}

function userReducer(state = initialState, action) {
    switch (action.type) {
        case SET_USER_NAME:
            return { ...state, name: action.payload };
        case SET_USER_EMAIL:
            return { ...state, email: action.payload };
        case SET_LIKED_USERS:
            console.log('user:', state.users)
            console.log('payload:', action.payload)
            return { ...state, users: [...state.users, action.payload] };
        default:
            return state;
    }
}

export default userReducer;