const { Schema, model } = require('mongoose');

const UserShema = Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    online: {
        type: Boolean,
        default: false
    }
});

UserShema.method('toJSON', function () {
    const { __v, _id, password, ...user } = this.toObject();
    user.uid = _id;
    return user;
});
module.exports = model('UserModel', UserShema)