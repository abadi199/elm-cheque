'use strict';

require('./index.html');
require('./index.css');
var Elm = require('./Main');

var elm = Elm.Main.embed(document.getElementById("elmApp"));