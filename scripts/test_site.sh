#!/bin/bash

pass_counter=0
function pass {
  pass_counter=$((pass_counter+1))
}

function fail {
  echo Failed test $1
  fail_counter=$((fail_counter+1))
}

# Ensure that the various files are served correctly.
[ "$(curl -Is localhost:8080 | head -c12)" == "HTTP/1.1 200" ] && pass || fail "ROUTE: index.html"
[ "$(curl -Is localhost:8080/background.jpg | head -c12)" == "HTTP/1.1 200" ] && pass || fail "ROUTE: background.jpg"
[ "$(curl -Is localhost:8080/favicon.ico | head -c12)" == "HTTP/1.1 200" ] && pass || fail "ROUTE: favicon.ico"
[ "$(curl -Is localhost:8080/index.html | head -c12)" == "HTTP/1.1 200" ] && pass || fail "ROUTE: index.html"
[ "$(curl -Is localhost:8080/style.css | head -c12)" == "HTTP/1.1 200" ] && pass || fail "ROUTE: style.css"

# Ensure that redirects work.
[ "$(curl -Is localhost:8080/foo | head -c12)" == "HTTP/1.1 302" ] && pass || fail "ROUTE: foo"
[ "$(curl -Is localhost:8080/../main.js | head -c12)" == "HTTP/1.1 302" ] && pass || fail "ROUTE: ../main.js"

echo $pass_counter out of $((pass_counter+fail_counter)) tests passed.
