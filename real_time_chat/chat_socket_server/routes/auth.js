const { Router } = require('express');
const { check } = require('express-validator');
const { createUser, login, renewToken } = require('../controllers/auth');
const { fieldValidator } = require('../middlewares/field_validator');
const router = Router();

// Crear usuario
router.post('/new', [
    check('name', 'El nombre es obligatorio').not().isEmpty(),
    // check('email', 'El email es obligatorio').isEmail(),
    check('password', 'La contraseña es obligatoria').not().isEmpty(),
    fieldValidator
], createUser);

// Inicio de sesion
router.post('', [
    check('email', 'El email es obligatorio').isEmail(),
    check('password', 'La contraseña es obligatoria').not().isEmpty(),
    fieldValidator],
    login
);

router.get('/renew', renewToken);

module.exports = router;
