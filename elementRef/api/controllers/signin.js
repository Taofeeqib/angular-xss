const user = require('../models/user')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {
    user.findOne({email: req.body.email})
        .then(result => {
            if(result){
                if(!bcrypt.compareSync(req.body.password, result.password)){
                    res.status(402).json({msg: "Email or password is wrong"})
                }else{
                    const token = jwt.sign({
                        name: result.name,
                        email: result.email,
                        profession: result.profession,
                        url: result.website
                    }, 'SECRET_KEY')
                    res.status(200).json({token})
                }
            }else{
                res.status(402).json({msg: "Email or password is wrong"})
            }
        })
        .catch(err => {
            res.status(500).send()
        })
}