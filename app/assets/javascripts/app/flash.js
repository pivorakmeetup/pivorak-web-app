$(function() {
  var loadFlash = function() {
    var mainFlashNode = document.getElementById('main-flash');

    function removeFlash(flashNode) {
      flashNode.parentNode.removeChild(flashNode);
    }

    var flashNodes = mainFlashNode.querySelectorAll(".pk-flash");

    var timeout = setTimeout(function(){
      clearTimeout(timeout);
      for(var i = 0; i < flashNodes.length; i++) {
        removeFlash(flashNodes[i]);
      }
    }, 4000);

    for(var i = 0; i < flashNodes.length; i++) {
      flashNodes[i].addEventListener("click", function(e){
        e.preventDefault();

        var flashNode = e.currentTarget
        removeFlash(flashNode);
      });
    }
  }

  window.loadFlash = loadFlash;
});
