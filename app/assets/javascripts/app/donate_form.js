(function(){
  var listenDonateTermsOfUse = function() {
    var agreeToTermsCheckbox = document.getElementsByClassName('js-donate-form-agree')[0];
    var paymentBtn = document.getElementsByClassName('js-donate-form-payment-btn')[0];
    var validationBtn = document.getElementsByClassName('js-donate-form-validation-btn')[0];

    // when user accepts terms of use we should show toggle button instead of form submit.
    // form submit is preventing user from submitting form.
    var toggleBtns = function() {
      toggleElement(paymentBtn);
      toggleElement(validationBtn);
    }

    if(agreeToTermsCheckbox) {
      agreeToTermsCheckbox.addEventListener('change', toggleBtns);
      paymentBtn.addEventListener('click', runWayforpayWidget);
    }

    var toggleElement = function(element) {
      element.classList.toggle("pk-no-display");
    }
  }

  function runWayforpayWidget() {var wayforpay = new Wayforpay(); wayforpay.invoice('https://secure.wayforpay.com/button/b644556e003e4');}

  window.listenDonateTermsOfUse = listenDonateTermsOfUse;
  window.runWayforpayWidget = runWayforpayWidget;
})();
