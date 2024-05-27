const mongoose = require('mongoose')

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    profession:{
        type: String,
        default: ''
    },
    website:{
        type: String,
        default: ''
    }
})

module.exports = mongoose.model("User", userSchema)