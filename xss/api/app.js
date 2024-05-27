const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')

const signup = require('./routes/signup')
const signin = require('./routes/signin')
const movies = require('./routes/movie')
const check = require('./routes/check')
const update = require('./routes/update')

mongoose.connect('mongodb://database:27017/angularDB')

const app = express()
app.use(express.json())
app.use(cors({
    origin: true
}))

app.use('/signup', signup)
app.use('/signin', signin)
app.use('/movies', movies)
app.use('/check', check)
app.use('/update', update)


app.listen(8000, () =>{console.log('port 8000')})
