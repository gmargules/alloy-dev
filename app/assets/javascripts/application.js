// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
$(document).ajaxSend(function(event, request, settings) {
  if (settings.type == 'get' || settings.type == 'GET' || typeof(AUTH_TOKEN) == "undefined") return;
  var authTokenRegExp = /authenticity_token=\w{40}/
  settings.data = settings.data || "";
  if (authTokenRegExp.test(settings.data))
  {
    settings.data=settings.data.replace(authTokenRegExp, "authenticity_token=" + encodeURIComponent(AUTH_TOKEN));
  }
  else
  {
    settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
  }
})
