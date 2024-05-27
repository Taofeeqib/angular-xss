const router = require('express').Router()
const signin = require('../controllers/signin')

router.route('/')
    .post(signin)

module.exports = router