(function(){

  var initDropdowns = function() {

    function whichTransitionEvent(){
      var t;
      var el = document.createElement('fakeelement');
      var transitions = {
        'transition':'transitionend',
        'OTransition':'oTransitionEnd',
        'MozTransition':'transitionend',
        'WebkitTransition':'webkitTransitionEnd'
      }

      for(t in transitions){
        if( el.style[t] !== undefined ){
            return transitions[t];
        }
      }
    }

    var transitionEndEvent = whichTransitionEvent();


    var parentToOpen;
    document.addEventListener("click", function(e) {
      for (var target=e.target; target && target!=this; target=target.parentNode) {
        if (target.classList.contains('js-toggle-dropdown')) {

          var parent = target.parentElement;

          parentToOpen = parent;

          function transitionEndAction(e) {
            parentToOpen.removeEventListener(transitionEndEvent, transitionEndAction);
            parentToOpen.classList.remove('opening');
          }

          parentToOpen.classList.add('opening');
          parentToOpen.addEventListener(transitionEndEvent, transitionEndAction);

          if (parent.classList.contains('open')) {
            parent.classList.remove('open');
          } else {
            parent.classList.add('open');
          }

          break;
        }
      }
    }, false);
  }

  window.initDropdowns = initDropdowns;

})()
