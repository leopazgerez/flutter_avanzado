const jwt = require('jsonwebtoken');

const validateJWT = (request, res, next) => {
    // leer el jwt que recibo en el header
    const token = request.header('token');
    if (!token) {
        return res.status(401).json({
            ok: false,
            msg: 'Token is required'
        });
    }
    try {
        const { uid } = jwt.verify(token, process.env.JWT_KEY);
        request.uid = uid;
        next();
    } catch (error) {
        return res.status(401).json({
            ok: false,
            msg: 'Invalid token'
        })
    }
}

module.exports = {
    validateJWT
}