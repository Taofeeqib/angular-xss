const mongoose = require('mongoose')
const movies = require('./movies')

const adminSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email:{
        type: String,
        required: true
    },
    password:{
        type: String,
        required: true
    },
    movies:{
        type: [mongoose.Schema.Types.ObjectId],
        ref: 'Movie',
        default: []
    }
},
{
    timestamps: true
}
)

module.exports = mongoose.model('Admin', adminSchema)