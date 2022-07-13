const express = require('express')
const fs = require('fs')
const morgan = require('morgan')

const app = express()

/*
 * 'morgan' is used to log the HTTP requests that this server gets. When used
 * this way, it will log to both a file and standard output.
 */
app.use(morgan('common', {
  stream: fs.createWriteStream('./access.log', { flags: 'a' })
}))
app.use(morgan('dev'))

/*
 * Create a static route. Everything in the 'public' directory will be sent
 * as-is. That includes the index, CSS styling, script files, and images.
 */
app.use(express.static('public'))

/*
 * Redirect all traffic not handled by the above to the document root.
 */
app.get('*', function (req, res) {
  res.redirect('/')
})

app.listen(8080)
console.log('Listening on port 8080...')
