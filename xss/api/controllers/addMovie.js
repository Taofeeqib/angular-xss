const movie = require('../models/movies')
const admin = require('../models/admin')
const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {  
    if(!req.body.token){
        res.status(202).json({msg: "No token available"})
        return
    }
    
    jwt.verify(req.body.token, 'SECRET_KEY', (err, data) => {
        if(err){
            res.status(202).json({msg: "Invalid token"})
        }else{
            if(!data.isAdmin){
                res.status(202).json({msg: "Invalid token"})
            }else{
                let movieData = {name: req.body.name, link: req.body.link}
                new movie(movieData).save()
                .then((result) => {
                    admin.findByIdAndUpdate(data.id, {$push: {movies: result._id}})
                    .then((doc) => {
                        res.status(201).json({msg: 'Movie added Successfully'})
                    }).catch((err) => {
                        res.status(202).json({msg: err})
                    });
                }).catch((err) => {
                    res.status(202).json({msg: err})
                });
            }
            
        }
    })
}