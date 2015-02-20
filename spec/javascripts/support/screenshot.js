exports.page = require('webpage').create();

exports.render = function(width, height) {
  exports.page.viewportSize = {
    width: width,
    height: height
  };
}

exports.fetch = function() {
  exports.page.open('http://localhost:3000/', function() {
      exports.page.render('enroll'+ exports.page.viewportSize.width +'x'+ exports.page.viewportSize.height +'.png');
      phantom.exit();
  });
}
