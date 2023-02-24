const express = require('express')
var PORT = process.env.PORT || 4000
let nunjucks = require('nunjucks');

//express app
const app = express()

app.post('/initialize', (req, res) => {
    res.status(200).send({
        
    })
});

app.listen(
    PORT,
    () => console.log(`hello there http://localhost:${PORT}`)
)