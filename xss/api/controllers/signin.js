const admin = require('../models/admin')
const user = require('../models/user')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {
    let model = user
    if(req.body.isAdmin){
        model = admin
    }

    model.findOne({email: req.body.email})
    .then((result) => {
        if(result){
            if(bcrypt.compareSync(req.body.password, result.password)){
                let token = ''
                const userData = {id: result._id, isAdmin: req.body.isAdmin}
                jwt.sign(userData, 'SECRET_KEY', (err, data) => {
                    if(err){
                        res.status(202).json({msg: err})
                    }else{
                        res.status(200).json({msg: 'Signed In Successfully', token: data})
                    }
                })
            }else{
                res.status(202).json({msg: "Incorrect email or password"})
            }
        }else{
            res.status(202).json({msg: "Incorrect email or password"})
        }
    }).catch((err) => {
        res.status(202).json({msg: err})
    });
}