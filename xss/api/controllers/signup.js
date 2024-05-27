const admin = require('../models/admin')
const user = require('../models/user')
const bcrypt = require('bcryptjs')

module.exports = (req, res, next) => {
    let model = user
    if(req.body.isAdmin){
        model = admin
    }

    model.findOne({email: req.body.email})
    .then((result) => {
        if(result){
            res.status(202).json({msg: "User already registered"})
        }else{
            const pw = bcrypt.hashSync(req.body.password, 10)
            new model({email: req.body.email, password: pw, name: req.body.name}).save()
            .then((doc) => {
                res.status(201).json({msg: "User Registered Successfully"})
            }).catch((err) => {
                res.status(202).json({msg: err})
            });
        }
    }).catch((err) => {
        res.status(202).json({msg: err})
    });
}