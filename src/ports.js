'use strict'
const Elm = require('./Main.js')

// get a reference to the div where we will show our UI
let container = document.getElementById('container')

// start the elm app in the container
// and keep a reference for communicating with the app
let electronelmapp = Elm.Main.embed(container)