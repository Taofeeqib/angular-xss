    const user = require('../models/user')
    const bcrypt = require('bcryptjs')

    module.exports = (req, res, next) => {
        user.findOne({email: req.body.email})
            .then(result => {
                if(result){
                    res.status(409).json({msg: "User already exists"})
                }else{
                    const pw = bcrypt.hashSync(req.body.password, 10)
                    new user({
                        email: req.body.email,
                        name: req.body.name,
                        password: pw
                    }).save()
                        .then(doc => {
                            res.status(201).send()
                        })
                        .catch(err => {
                            res.status(500).send()
                        })
                }
            })
            .catch(err => {
                res.status(500).send()
            })
    }