const update = require('../controllers/updateProfile')
const router = require('express').Router()

router.route('/')
    .post(update)

module.exports = router