(function() {
  var initSlider = function() {
    var sliderContainer = document.querySelector('.js-slider');

    function onInit() {
      var containerNode = sliderContainer.querySelector('.js_slides');
      var prevNode = sliderContainer.querySelector('.js_prev');
      var nextNode = sliderContainer.querySelector('.js_next');
      if (sliderContainer.offsetWidth >= containerNode.offsetWidth) {
        prevNode.style.display = "none";
        nextNode.style.display = "none";
      }
    }

    if (sliderContainer) {
      sliderContainer.addEventListener('after.lory.init', onInit);

      var slider = lory(sliderContainer, {
        infinite: false,
        rewind: false,
        rewindOnResize: false
      });
    }
  }

  window.initSlider = initSlider;
})();
