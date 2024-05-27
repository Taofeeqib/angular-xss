const user = require('../models/user')
const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {
    if(!req.body.token && !req.body.details){
        res.status(401).send()
    }else{
        jwt.verify(req.body.token, 'SECRET_KEY', (err, data) => {
            if(err){
                res.status(401).send()
            }else{
                console.log(req.body.details)
                user.updateOne({email: data.email}, req.body.details)
                    .then(result => {
                        const token = jwt.sign({
                            email: req.body.details.email, 
                            name: req.body.details.name,
                            profession: req.body.details.profession,
                            url: req.body.details.website
                        }, 'SECRET_KEY')
                        res.status(200).json({token})
                    })
                    .catch(err => {
                        console.log(err)
                        res.status(500).send()
                    })
            }
        })
    }
}