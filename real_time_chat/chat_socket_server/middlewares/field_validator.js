const { validationResult } = require('express-validator');

const fieldValidator = (request, res, next) => {
    errors = validationResult(request);

    if (!errors.isEmpty()) {
        return res.status(400).json({
            errors: errors.mapped()
        });
    }
    next();
}

module.exports = {
    fieldValidator
}