'use strict'

$(document).on('ready',function(){
  searcher_song();
  audio_player();
});

var spotify_uris = {};

spotify_uris.base = "https://api.spotify.com";
spotify_uris.song = function(track){ return '/v1/search?q='+track+'&type=track' };

function audio_player(){

  function seekbar_progress(){
    var current_time = $('.js-player').prop('currentTime');
    $('progress').attr('value', current_time);
  };

  $('.btn-play').on('click',function(){
    if ($('.btn-play').hasClass('playing')){
      $('.js-player').trigger('pause');
    } else {
      $('.js-player').trigger('play');
    };
    $('.btn-play').toggleClass('disabled playing');
  });

  $('.js-player').on('timeupdate', seekbar_progress);
}

function caller_api_spotify(uri, f_success){
  $.ajax({
    type:"get",
    url: uri,
    success: f_success,
    fail: return_error_info,
  });
};

function load_audio_track(response){
  var index = 0;
  var song_title = response.tracks.items[index].name;
  var artists_names = "";
  for (var i=0; i<response.tracks.items[index].artists.length; i++){
    if (i==response.tracks.items[index].artists.length-1){
      artists_names += ("and " + response.tracks.items[index].artists[i].name);
    } else if (i==response.tracks.items[index].artists.length-2){
      artists_names += (response.tracks.items[index].artists[i].name+" ");
    } else {
      artists_names += (response.tracks.items[index].artists[i].name+", ");
    };
  };  
  var cover_image = response.tracks.items[index].album.images[1].url;
  var preview_song = response.tracks.items[index].preview_url;
  $('.js-player').attr('src', preview_song);
  $('.js-player').bind('load', function(){
    $('.title').text(song_title);
    $('.author').text(artists_names);
    $('.cover img').attr('src', cover_image);
    $('progress').attr('value', 0);
  });
  $('.js-player').trigger('load');
}

function return_error_info(error){
  console.error(error.responseJSON);
};

function searcher_song(){
  $('#searcher').on('keypress', function(event){
    if (event.keyCode == 13){
      event.preventDefault();
      var $track = $('#searcher').val(); 
      var uri = spotify_uris.base + spotify_uris.song($track); 
      caller_api_spotify(uri, load_audio_track);
    };
  });
};