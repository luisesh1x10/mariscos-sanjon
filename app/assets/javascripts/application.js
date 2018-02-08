// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= requier turbolinks
//= require_tree 
//= require jquery
//= require materialize
//= require materialize-sprockets
//= require materialize/extras/nouislider


$(document).ready(function() {
$('.modal-trigger').leanModal();
 });
$(document).ready(function(){
    $(".button-collapse").sideNav();  
    $('.collapsible').collapsible();
});
function hostReachable() {

  // Handle IE and more capable browsers
  var xhr = new ( window.ActiveXObject || XMLHttpRequest )( "Microsoft.XMLHTTP" );
  var status;

  // Open new request as a HEAD to the root hostname with a random param to bust the cache
  xhr.open( "HEAD", "//" + window.location.hostname + "/?rand=" + Math.floor((1 + Math.random()) * 0x10000), false );

  // Issue request and handle response
  try {
    xhr.send();
    return ( xhr.status >= 200 && (xhr.status < 300 || xhr.status === 304) );
  } catch (error) {
    return false;
  }

}
setInterval(function(){  
    if(hostReachable()){
      $("#barra_coneccion").hide();
     } else {
      $("#barra_coneccion").show();
     } 
}, 15000);


