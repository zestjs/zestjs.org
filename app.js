var connect = require('connect');
var zest = require('zest-server');

var app = connect();

zest.init('dev', function() {
  app.use(zest.server);
  app.listen(8080);
});
