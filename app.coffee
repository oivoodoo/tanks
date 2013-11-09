express = require('express')
path    = require('path')
app     = express()

app.use express.logger('dev')
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.static(path.join(__dirname, 'public'))
app.use app.router
app.use require('connect-assets')()
app.use express.errorHandler()

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'

app.get '/', (request, response) ->
  response.render('index')

module.exports = app

port = process.env.PORT || 3003
app.listen(port)

console.log("Listening on port #{port}")

