const check = require('../controllers/check')
const router = require('express').Router()

router.route('/')
    .post(check)

module.exports = router