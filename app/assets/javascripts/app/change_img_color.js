(function() {
  var initChangeImageColor = function() {
    var elements = document.querySelectorAll('.pk-js-changed-color-images');

    for(var i = 0; i < elements.length; i++) {
      var elem = elements[i];
      processElement(elem);
    }

    function processElement(elem) {
      var imgNode = elem.childNodes[0];
      var canvas = document.createElement('canvas');
      var imgObj = new Image();
      imgObj.onload = function() {
        canvas.width = imgObj.width;
        canvas.height = imgObj.height;

        x = canvas.getContext('2d');

        x.drawImage(imgObj, 0, 0);

        var img = x.getImageData(0, 0, canvas.width, canvas.height);
        var pix = img.data;
        var n = pix.length;

        for (i = 0; i < n; i += 4) {
          if (pix[i + 3] > 0) {
            pix[i] = 255;
            pix[i + 1] = 244;
            pix[i + 2] = 218;
          }
        }

        x.putImageData(img, 0, 0);

        elem.appendChild(canvas);
      }
      imgObj.src = imgNode.src;
    }
  }

  window.initChangeImageColor = initChangeImageColor;
})();
