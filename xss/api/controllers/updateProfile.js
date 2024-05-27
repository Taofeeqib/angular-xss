const jwt = require('jsonwebtoken')
const admin = require('../models/admin')
const user = require('../models/user')

module.exports = (req, res, next) => {
    if(!req.body.token){
        res.status(202).json({signedin: false})
    }
    jwt.verify(req.body.token, 'SECRET_KEY', (err, data) => {
        if(err){
            res.status(202).json({signedin: false})
        }else{
            const p = data.isAdmin ? admin : user
            p.findByIdAndUpdate(data.id, {name: req.body.name, email: req.body.email})
                .then((result) => {
                    res.status(200).json(result)
                }).catch((err) => {
                    res.status(202).json({msg: err})
                });
        }
    })
}