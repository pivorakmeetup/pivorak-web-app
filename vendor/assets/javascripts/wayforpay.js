function Wayforpay() {
  var frameName = 'WayforpayFrame';
  var formName = 'WayforpayForm';
}

Wayforpay.prototype.build = 42;
Wayforpay.prototype.name = 'WFPWidget';
Wayforpay.prototype.defaultTarget = 'https://secure.wayforpay.com';

Wayforpay.prototype.getTargetHost = function () {
  var script = document.getElementById('widget-wfp-script');
  var url, l;

  if(this.target) {
      return this.target;
  } else if(!script) {
      return this.defaultTarget;
  } else {
      if (script.getAttribute.length !== undefined) {
          url = script.src;
      } else {
          url = script.getAttribute('src');
      }
      l = document.createElement("a");
      l.href = url;
      if('secure.wayforpay.com' == l.hostname) {
          this.target = this.defaultTarget;
      } else {
          this.target = l.protocol + '//' + l.hostname;
      }
      return this.target;
  }
};

Wayforpay.prototype.isVerify = function () {
  return ('VERIFY' == this.requestType);
};

Wayforpay.prototype.getPayUrl = function () {
  if(this.isVerify()) {
      return this.getTargetHost() + '/verify' + (this.skin ? '/' + this.skin : '');
  } else {
      return this.getTargetHost() + '/pay' + (this.skin ? '/' + this.skin : '');
  }
};

Wayforpay.prototype.run = function (options, onApproved, onDeclined, onPending, onUnknown) {
  var that = this;
  var theme = options.hasOwnProperty('theme') ? options.theme : false;

  this.postFields  = options;
  this.straightWidget = options.hasOwnProperty('straightWidget') ? options.straightWidget : false;
  this.makeRedirect = options.hasOwnProperty('makeRedirect') ? options.makeRedirect : false;
  this.requestType = options.hasOwnProperty('requestType') ? options.requestType : false;
  this.skin        = theme ? theme : (this.makeRedirect ? '' : (this.isVerify() ? 'verify_compact' : 'compact'));
  this.postFields.clientStartTime = Date.now();
  this.isMobile   = /Android|webOS|iPhone|iPad|iPod|BlackBerry|BB10|IEMobile|Opera Mini/i.test(navigator.userAgent);

  if (this.makeRedirect) {
      this.submitData('pre');
  } else if (this.isMobile && !this.straightWidget) {
      this.submitData('page');
  } else {
      this.createContainer();
      this.createOverlay();
      this.createFrame();

      that.frame.contentWindow.focus();

      this.onApproved = onApproved;
      this.onDeclined = onDeclined;
      this.onPending  = onPending;
      this.onUnknown  = onUnknown;

      window.addEventListener("message", function (event) {
          if (event.origin != that.getTargetHost()) {
              return;
          }
          if (event.data == 'WfpWidgetEventClose') {
              var cont = document.getElementById('wfp-container');
              if (cont) {
                  cont.parentNode.removeChild(cont);
              }
          } else if (event.data == 'WfpWidgetEventLoaded') {
              that.frame.style.backgroundImage = 'none';
          } else if (event.data == 'WfpWidgetEventFadeOutOverlay') {
              that.overlay.style.backgroundColor = '#fafafa';
              that.overlay.style.opacity         = 1;
              that.overlay.style.filter          = 'alpha(opacity=100)';
              that.container.style.position      = 'initial';
          } else if (event.data == 'WfpWidgetEventFadeInOverlay') {
              that.overlay.style.backgroundColor = '#000000';
              that.overlay.style.opacity         = 0.5;
              that.overlay.style.filter          = 'alpha(opacity=50)';
              that.frame.style.backgroundImage   = 'url("https://s3.eu-central-1.amazonaws.com/w4p-merch/logo/widget_preloader_light.gif")';
              that.container.style.position      = 'fixed';
          } else if (event.data == 'WfpWidgetEventApproved') {
              //
          } else if(event.data == 'WfpWidgetEventDeclined') {
              //
          } else if(event.data == 'WfpWidgetEventPending') {
              //
          } else {
              setTimeout(function(){ that.frame.style.backgroundImage = 'none';}, 10000);
              that.handleResponse(event.data);
          }
      });
  }
};

Wayforpay.prototype.invoice = function (url, straight) {
  var that = this;

  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|BB10|IEMobile|Opera Mini/i.test(navigator.userAgent) && !straight) {
      window.location.href = url;
  } else {
      this.createContainer();
      this.createOverlay();
      this.createFrameUrl(url);

      that.frame.contentWindow.focus();

      window.addEventListener("message", function (event) {
          if (event.origin != that.getTargetHost()) {
              //return;
          }
          if (event.data == 'WfpWidgetEventClose') {
              var cont = document.getElementById('wfp-container');
              if (cont) {
                  cont.parentNode.removeChild(cont);
              }
          } else if (event.data == 'WfpWidgetEventLoaded') {
              that.frame.style.backgroundImage = 'none';
          } else if (event.data == 'WfpWidgetEventFadeOutOverlay') {
              that.overlay.style.backgroundColor = '#fafafa';
              that.overlay.style.opacity         = 1;
              that.overlay.style.filter          = 'alpha(opacity=100)';
          } else if (event.data == 'WfpWidgetEventFadeInOverlay') {
              that.overlay.style.backgroundColor = '#000000';
              that.overlay.style.opacity = 0.5;
              that.overlay.style.filter = 'alpha(opacity=50)';
              that.frame.style.backgroundImage = 'url("https://s3.eu-central-1.amazonaws.com/w4p-merch/logo/widget_preloader_light.gif")';
          } else if(event.data == 'WfpWidgetEventApproved') {
              //
          } else if(event.data == 'WfpWidgetEventDeclined') {
              //
          } else if(event.data == 'WfpWidgetEventPending') {
              //
          } else {
              setTimeout(function(){ that.frame.style.backgroundImage = 'none';}, 10000);
              that.handleResponse(event.data);
          }
      });
  }
};

Wayforpay.prototype.handleResponse = function (data) {
  var response;
  try {
      response = JSON.parse(data);
      if ('reasonCode' in response) {
          if (1100 == response.reasonCode) {
              if (typeof this.onApproved == 'function') {
                  this.onApproved(response);
              }
          } else if (1134 == response.reasonCode || 1131 == response.reasonCode) {
              if (typeof this.onPending == 'function') {
                  this.onPending(response);
              }
          } else if (typeof this.onDeclined == 'function') {
              this.onDeclined(response);
          }
      } else if ('pay_way' in response && response.pay_way == 'privat24') {
          this.submitForm('https://api.privatbank.ua/p24api/ishop', response);
      } else {
          if (typeof this.onUnknown == 'function') {
              this.onUnknown(data);
          }
      }
  } catch (error) {
      /*if (typeof this.onUnknown == 'function') {
          this.onUnknown(data);
      }*/
  }

};

Wayforpay.prototype.closeit = function () {
  if (this.container) {
      this.container.parentNode.removeChild(this.container);
      this.container = null;
  }
};

Wayforpay.prototype.createContainer = function () {
  var cont = document.getElementById('wfp-container');
  if (cont) {
      cont.parentNode.removeChild(cont);
  }

  this.container = document.createElement('div');
  this.container.style.cssText = 'z-index: 9997; height: 100%; width: 100%; position: fixed; left: 0px; top: 0px;';
  this.container.setAttribute('id', 'wfp-container');
  document.body.appendChild(this.container);
};

Wayforpay.prototype.createOverlay = function () {
  this.overlay = document.createElement('div');
  this.overlay.style.cssText = '-ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity:0.5;opacity:0.5;position:absolute;z-index:9997;background:black;top:0;left:0;width:100%;height:100%;';
  this.container.appendChild(this.overlay);
};

Wayforpay.prototype.createFrame = function () {
  this.frame = document.createElement('iframe');
  //this.frame.setAttribute('id', 'wfp-' + this.name + 'Frame');
  this.frame.setAttribute('name', this.name + 'Frame');
  this.frame.setAttribute('src', 'about:blank');
  this.frame.style.cssText = 'background: transparent; z-index: 9999; position: fixed; top: 0; left: 0; width: 100%; height: 100%;background-image:url("https://s3.eu-central-1.amazonaws.com/w4p-merch/logo/widget_preloader_light.gif");background-position: center center;background-repeat: no-repeat';
  //this.frame.setAttribute('scrolling', 'no');
  this.frame.setAttribute('frameborder', '0');
  this.container.appendChild(this.frame);
  this.submitData('frame');
};

Wayforpay.prototype.createFrameUrl = function (url) {
  this.frame = document.createElement('iframe');
  //this.frame.setAttribute('id', 'wfp-' + this.name + 'Frame');
  this.frame.setAttribute('name', this.name + 'Frame');
  this.frame.setAttribute('src', url + '?behavior=frame&build=' + this.build);
  this.frame.style.cssText = 'background: transparent; z-index: 9999; position: fixed; top: 0; left: 0; width: 100%; height: 100%;background-image:url("https://s3.eu-central-1.amazonaws.com/w4p-merch/logo/widget_preloader_light.gif");background-position: center center;background-repeat: no-repeat';
  this.frame.setAttribute('frameborder', '0');
  this.frame.setAttribute('scrolling', 'no');
  this.container.appendChild(this.frame);
};

Wayforpay.prototype.submitData = function (behavior) {
  var form = document.createElement('form');
  var i, field, a, e, n;
  var body = document.getElementsByTagName('body')[0];

  form.style.cssText = 'display: none;';
  form.setAttribute('name', this.name + 'Form');
  form.setAttribute('action', this.getPayUrl() + (behavior ? '?behavior=' + behavior + '&build=' + this.build : '?build=' + this.build));
  form.setAttribute('method', 'POST');
  if ('frame' === behavior) {
      form.setAttribute('target', this.name + 'Frame');
  }
  i = document.createElement('input');
  i.setAttribute('type', 'submit');
  form.appendChild(i);

  for (field in this.postFields) {
      if (this.postFields.hasOwnProperty(field)) {
          if(this.postFields[field] instanceof Array) {
              n = 0;
              a = this.postFields[field];
              for (e in a) {
                  if (a.hasOwnProperty(e)) {
                      i = document.createElement('input');
                      i.setAttribute('type', 'text');
                      i.setAttribute('name', field + '[]');
                      i.setAttribute('value', a[e]);
                      form.appendChild(i);
                      n++;
                  }
              }
          } else {
              i = document.createElement('input');
              i.setAttribute('type', 'text');
              i.setAttribute('name', field);
              i.setAttribute('value', this.postFields[field]);
              form.appendChild(i);
          }
      }
  }

  if (behavior === 'frame') {
      this.container.appendChild(form);
  } else {
      body.appendChild(form);
  }

  form.submit();
};

Wayforpay.prototype.submitForm = function (url, data) {
  var form = document.createElement('form');
  var i, field, a, e, n;
  var body = document.getElementsByTagName('body')[0];

  //form.style.cssText = 'display: none;';
  form.setAttribute('name', this.name + 'FreeForm');
  form.setAttribute('action', url);
  form.setAttribute('method', 'POST');
  form.setAttribute('accept-charset', 'UTF-8');
  i = document.createElement('input');
  i.setAttribute('type', 'submit');
  form.appendChild(i);

  for (field in data) {
      if (data.hasOwnProperty(field)) {
          i = document.createElement('input');
          i.setAttribute('type', 'text');
          i.setAttribute('name', field);
          i.setAttribute('value', data[field]);
          form.appendChild(i);
      }
  }
  body.appendChild(form);
  form.submit();
};
