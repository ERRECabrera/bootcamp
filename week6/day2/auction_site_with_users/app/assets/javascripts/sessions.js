// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function user_logout(){
  var request = $.ajax({
    url: 'http://localhost:3000/logout',
    type: 'delete',
  });
  request.done(function(){ console.log('logout')})
  request.fail(function(){
   console.log('fail');
   window.location.replace('http://localhost:3000/');
  })
}

function event_logout(){
  $('#log_out').on('click', user_logout);
}

$(document).on('ready', event_logout)
