(function() {
  var initSlider = function() {
    var sliderContainer = document.querySelector('.js-slider');

    if (sliderContainer) {
      var slider = lory(sliderContainer, {
        infinite: false,
        rewind: false,
        rewindOnResize: false
      });
    }
  }

  window.initSlider = initSlider;
})();
