const express = require('express')
const app = express()

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
