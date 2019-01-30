(function() {
  var initQrCode = function() {
    var qrCode = document.getElementById('pk-qr-code__main');

    if (!qrCode) {
      return
    }

    var none = 'none';
    var btn = document.getElementById('show-qr-code-button');

    qrCode.style.display = none;

    btn.addEventListener('click', function(event) {
      event.preventDefault();

      if (qrCode.style.display === none) {
        qrCode.style.display = 'block';
      } else {
        qrCode.style.display = none;
      }

      qrCode.scrollIntoView();
    })
  }

  window.initQrCode = initQrCode;
})();