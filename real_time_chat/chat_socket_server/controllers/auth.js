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

const login = async (request, res = response) => {
    try {
        let token;
        let user;
        const { email, password } = request.body;
        const userModel = await UserModel.findOne({ email });
        if (userModel) {
            const isMatch = bcrypt.compareSync(password, userModel.password);
            if (isMatch) {
                user = UserModel(request.body);
                token = await generateJWT(user._id);
            }
            else {
                return res.status(401).json({
                    ok: false,
                    msg: 'Wrong password'
                });
            }
        } else {
            return res.status(401).json({
                ok: false,
                msg: 'User not found'
            });
        }
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

const renewToken = async (request, res = response) => {
    try {
        // Renuevo el token por detras  y solo devuelvo el usuario que corresponde
        const uid = request.uid;
        const token = await generateJWT(uid);
        const user = await UserModel.findById(uid);
        if (!user) {
            return res.status(400).json({
                ok: false,
                msg: 'User not found'
            });
        } else {
            res.json({
                ok: true,
                msg: 'token renewed',
                user,
                token,
            });
        }
    } catch (error) {
        console.log(error)
        res.status(500).json({
            ok: false,
            msg: 'Error inesperado... revisar logs'
        });
    }
};

module.exports = {
    createUser,
    login,
    renewToken
}