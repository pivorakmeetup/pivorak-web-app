(function(){
  var listenDonateTermsOfUse = function() {
    var agreeToTermsCheckbox = document.getElementsByClassName('js-donate-form-agree')[0];

    // when user accepts terms of use we should show toggle button instead of form submit.
    // form submit is preventing user from submitting form.
    var toggleBtns = function() {
      var paymentBtn = document.getElementsByClassName('js-donate-form-payment-btn')[0];
      var validationBtn = document.getElementsByClassName('js-donate-form-validation-btn')[0];
      toggleElement(paymentBtn);
      toggleElement(validationBtn);
    }

    if(agreeToTermsCheckbox) {
      agreeToTermsCheckbox.addEventListener( 'change', toggleBtns);
    }

    var toggleElement = function(element) {
      element.classList.toggle("pk-no-display");
    }
  }

  window.listenDonateTermsOfUse = listenDonateTermsOfUse;
})();
