$(function() {
  function whichAnimationEvent(){
    var t;
    var el = document.createElement('fakeelement');
    var transitions = {
      'animation':'animationend',
      'OAnimation':'oAnimationEnd',
      'MozTransition':'animationend',
      'WebkitAnimation':'webkitAnimationEnd'
    }

    for(t in transitions){
      if( el.style[t] !== undefined ){
          return transitions[t];
      }
    }
  }

  var loadFlash = function() {
    var animationEnd = whichAnimationEvent();
    var mainFlashNode = document.getElementById('main-flash');

    var flashBackDrop = document.createElement("div");
    flashBackDrop.className = "pk-flash-backdrop";
    flashBackDrop.addEventListener("click", function(e){
      e.preventDefault();
      removeAllFlashes(flashNodes, flashNodesLength);
    })

    function removeFlash(flashNode, i, length) {

      function removeAction(e) {
        flashNode.removeEventListener(animationEnd, removeAction);

        flashNode.parentNode.removeChild(flashNode);

        if (i === (length - 1)) {
          flashBackDrop.parentNode.removeChild(flashBackDrop);
          mainFlashNode.parentNode.removeChild(mainFlashNode);
        }
      }

      flashNode.addEventListener(animationEnd, removeAction);

      flashNode.classList.add("pk-flash--hide");
    }

    var flashNodes = mainFlashNode.querySelectorAll(".pk-flash");
    var flashNodesLength = flashNodes.length;

    if (flashNodes.length > 0) {
      mainFlashNode.after(flashBackDrop);
    }

    function removeAllFlashes(flashNodes, length) {
      for(var i = 0; i < length; i++) {
        removeFlash(flashNodes[i], i, length);
      }
    }

    var timeout = setTimeout(function(){
      clearTimeout(timeout);
      removeAllFlashes(flashNodes, flashNodesLength);
    }, 7000);

    for(var i = 0; i < flashNodesLength; i++) {
      var ii = i;
      flashNodes[i].addEventListener("click", function(e){
        e.preventDefault();

        var flashNode = e.currentTarget
        removeFlash(flashNode, ii, flashNodesLength);
      });
    }
  }

  window.loadFlash = loadFlash;
});
