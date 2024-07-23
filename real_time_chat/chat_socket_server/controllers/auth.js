const { response } = require('express');
const bcrypt = require('bcryptjs');
const UserModel = require('../models/user_model');
const { generateJWT } = require('../utils/jwt');

const createUser = async (request, res = response) => {
    try {
        const { email, password } = request.body;
        const existEmail = await UserModel.findOne({ email });
        if (existEmail) {
            return res.status(400).json({
                ok: false,
                msg: 'Email already exists'
            });
        }
        const user = UserModel(request.body);
        const salt = bcrypt.genSaltSync();
        user.password = bcrypt.hashSync(password, salt);
        await user.save();
        const token = await generateJWT(user._id);
        res.json({
            ok: true,
            user,
            token
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            ok: false,
            msg: 'Error inesperado... revisar logs'
        });
    }
};

module.exports = {
    createUser
}