const mongoose = require('mongoose')

const movieSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    link:{
        type: String,
        required: true
    }
},
{
    timestamps: true
}
)

module.exports = mongoose.model('Movie', movieSchema)