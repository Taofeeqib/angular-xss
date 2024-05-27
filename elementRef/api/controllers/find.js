const user = require('../models/user')
const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {
    if(!req.body.token){
        res.status(401).send()
    }else{
        jwt.verify(req.body.token, 'SECRET_KEY', (err, data) => {
            if(err){
                res.status(401).send()
            }else{
                user.find({})
                    .then(results => {
                        pro = []
                        for(let i = 0; i < results.length; i++){
                            pro.push({name: results[i].name, email: results[i].email, website: results[i].website, profession: results[i].profession})
                        }
                        res.status(200).json({professionals: pro})
                    })
                    .catch(err => {
                        console.log(err)
                        res.status(500).json()
                    })
            }
        })
    }
}