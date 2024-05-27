const express = require('express')
const router = express.Router()

const find = require('../controllers/find')

router.route('/')
    .post(find)

module.exports = router