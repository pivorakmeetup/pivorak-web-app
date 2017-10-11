(function() {
  var URLreg = /(?:\(['|"]?)(.*?)(?:['|"]?\))/;

  function checkSupportsAndCreateBlendedBackgrounds() {
    var supportsBackgroundBlendMode = window.getComputedStyle(document.body).backgroundBlendMode;
    var supportsNode = document.createElement("div");
    supportsNode.style.backgroundBlendMode = "luminosity";
    if((typeof supportsBackgroundBlendMode === 'undefined') || (supportsNode.style.backgroundBlendMode !== "luminosity")) {
      createBlendedBackgrounds();
    }
  }

  function createBlendedBackgrounds() {
    var els = document.querySelectorAll('.pk-main-speakers__blend-image');
    for(var i = 0; i < els.length; i++) {
      var el = els[i];
      processElement(el);
    }
  }

  function processElement(el) {
    var style = window.getComputedStyle(el);
    var backgroundImageURL = URLreg.exec(style.backgroundImage)[1];
    var backgroundColor = style.backgroundColor;
    createBlendedBackgroundImageFromURLAndColor(backgroundImageURL, backgroundColor, function(imgData) {
      el.style.backgroundImage = 'url(' + imgData + ')';
    });
  }

  function createBlendedBackgroundImageFromURLAndColor(url, color, callback) {
    var img = document.createElement('img');
    img.src = url;
    img.onload = function() {
      var canvas = document.createElement('canvas');
      canvas.width = this.naturalWidth;
      canvas.height = this.naturalHeight;
      var context = canvas.getContext('2d');
      context.globalCompositeOperation = 'luminosity'
      context.fillStyle = color;
      context.fillRect(0, 0, canvas.width, canvas.height);
      context.drawImage(this, 0, 0);
      var data = canvas.toDataURL('image/jpeg');
      callback(data);
    };
  }

  window.blendedImg = checkSupportsAndCreateBlendedBackgrounds;
})();
