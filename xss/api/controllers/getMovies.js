const movie = require('../models/movies')
const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {
    if (!req.query.token) {
        res.status(202).json({ msg: 'No token available' })
        return
    } else {
        jwt.verify(req.query.token, 'SECRET_KEY', (err, data) => {
            if (err) {
                res.status(202).json({ msg: 'Invalid Token' })
            } else {
                movie
                    .find({})
                    .then((result) => {
                        res.status(200).json({ movies: result })
                    })
                    .catch((err) => {
                        res.status(202).json({ msg: err })
                    })
            }
        })
    }
}
