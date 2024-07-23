const { Router, response } = require('express');
const router = Router();

//crear el endpoint
router.post('/new', (request, res = response) => {
    res.json({
        ok: true,
        msg: 'Login'
    });
});

module.exports = router;
