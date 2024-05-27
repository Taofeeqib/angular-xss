const router = require('express').Router()
const addMovie = require('../controllers/addMovie')
const getMovies = require('../controllers/getMovies')

router.route('/')
    .get(getMovies)
    .post(addMovie)

module.exports = router