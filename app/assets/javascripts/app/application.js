// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require svgxuse
//= require lory
//= require_tree .



(function() {
  document.addEventListener('DOMContentLoaded', function () {
    var sliderContainer = document.querySelector('.js-slider');

    if (sliderContainer) {
      var slider = lory(sliderContainer, {
        infinite: false,
        rewind: false,
        rewindOnResize: false
      });
    }
  });

  var PIXEL_RATIO = (function () {
      var ctx = document.createElement("canvas").getContext("2d"),
          dpr = window.devicePixelRatio || 1,
          bsr = ctx.webkitBackingStorePixelRatio ||
                ctx.mozBackingStorePixelRatio ||
                ctx.msBackingStorePixelRatio ||
                ctx.oBackingStorePixelRatio ||
                ctx.backingStorePixelRatio || 1;

      return dpr / bsr;
  })();


  createHiDPICanvas = function(node, w, h, ratio) {
      if (!ratio) { ratio = PIXEL_RATIO; }
      var can = node;
      can.width = w * ratio;
      can.height = h * ratio;
      can.style.width = w + "px";
      can.style.height = h + "px";
      var ctx = can.getContext("2d");
      ctx.setTransform(ratio, 0, 0, ratio, 0, 0);
    return ctx;
  }



  // var w = Math.max(document.body.clientWidth, window.innerWidth || 0);
  // var h = Math.max(document.body.clientHeight, window.innerHeight || 0);

  // var bgNode = document.getElementById("main-bg-canvas");

  // var ctx = createHiDPICanvas(bgNode, w, h);

  // bgNode.width = w;
  // bgNode.height = h;

  // var ctx = bgNode.getContext("2d");

  // if (window.devicePixelRatio > 1) {
  //     var canvasWidth = bgNode.width;
  //     var canvasHeight = bgNode.height;

  //     var cWidth = canvasWidth * window.devicePixelRatio;
  //     var cHeight = canvasHeight * window.devicePixelRatio;
  //     bgNode.width = canvasWidth * window.devicePixelRatio;
  //     bgNode.height = canvasHeight * window.devicePixelRatio;
  //     bgNode.style.width = cWidth + "px";
  //     bgNode.style.height = cHeight + "px";

  //     ctx.scale(window.devicePixelRatio, window.devicePixelRatio);
  // }

  // var img = document.createElement('img');
  // img.src = "/assets/paper-imit-bg-blanding.png";

  // img.onload = function(){
  //   var ptrn = ctx.createPattern(img, 'repeat');
  //   ctx.fillStyle = ptrn;
  //   ctx.fillRect(0, 0, w, h);
  //   ctx.globalCompositeOperation = 'screen';
  //   // ctx.fillRect(0, 0, bgNode.width, bgNode.height);
  // }

  // var dots=[];
  // var numDots = 10000;
  // var width = cWidth;
  // var height = cHeight;
  // for(var i=0 ; i<numDots ; i++){
  //   dots.push({
  //     x : Math.random() * width,
  //     y : Math.random() * height
  //   })
  // }

  // ctx.clearRect(0, 0, width, height);
  // var j, dot;

  // var round = Math.round;

  // for(j = 0; j < numDots; j++) {
  //   dot = dots[j];
  //   ctx.beginPath();
  //   ctx.fillStyle = "rgb(237, 183, 171)";
  //   ctx.fillRect(round(dot.x) + 0.5,round(dot.y) + 0.5,0.5,0.5);
  //   ctx.fill();
  //   //ctx.stroke();
  // }


  // function update(){
  //   var i,dot;
  //   for( i=0 ; i< numDots ; i++){
  //     dot = dots[i];
  //     dot.x += dot.vx;
  //     dot.y += dot.vy;

  //     if(dot.x >width){
  //       dot.x = width;
  //       dot.vx *= bounce;
  //     }else if(dot.x <0){
  //       dot.x = 0;
  //       dot.vx *= bounce;
  //     }

  //     if(dot.y > height){
  //       dot.y = height;
  //       dot.vy *= bounce;
  //     }else if(dot.y<0){
  //       dot.y = 0;
  //       dot.vy *= bounce;
  //     }
  //   }
  // }

  // setInterval(function() {
  //     update();
  //     draw();
  // }, 1000/24);

})()
