const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')

mongoose.connect('mongodb://database:27017/angularDB', {
    useUnifiedTopology: true,
    useNewUrlParser: true,
})

const app = express()
app.use(express.json())
app.use(cors())

const signin = require('./routes/signin')
const signup = require('./routes/signup')
const update = require('./routes/update')
const find = require('./routes/find')

app.use('/signin', signin)
app.use('/signup', signup)
app.use('/update', update)
app.use('/find', find)

app.listen(8000, () => {
    console.log('Server is up and running')
})
