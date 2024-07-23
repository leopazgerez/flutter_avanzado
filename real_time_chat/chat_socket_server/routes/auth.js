const { Router } = require('express');
const { check } = require('express-validator');
const { createUser } = require('../controllers/auth');
const { fieldValidator } = require('../middlewares/field_validator');
const router = Router();

//crear el endpoint
router.post('/new', [
    check('name', 'El nombre es obligatorio').not().isEmpty(),
    check('email', 'El email es obligatorio').isEmail(),
    check('password', 'La contraseña es obligatoria').not().isEmpty(),
    fieldValidator
], createUser);

module.exports = router;
