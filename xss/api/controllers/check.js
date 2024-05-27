const jwt = require('jsonwebtoken')
const admin = require('../models/admin')
const user = require('../models/user')

module.exports = (req, res, next) => {
    if(!req.body.token){
        res.status(200).json({signedin: false})
        console.log("No token")
    }
    jwt.verify(req.body.token, 'SECRET_KEY', (err, data) => {
        if(err){
            res.status(200).json({signedin: false})
        }else{
            const p = data.isAdmin ? admin : user
            p.findById(data.id)
                .then((result) => {
                    res.status(200).json({signedin: true, name: result.name, email: result.email, isAdmin: data.isAdmin})
                }).catch((err) => {
                    res.status(200).json({signedin: false})
                    console.log('user not found')
                });
        }
    })
}