var datas = [];

function form_submit(){
  $('.js-searcher').on('submit',function(event){
    event.preventDefault();
    var artist = $('#name_artist').val();
    var url_spotify = "https://api.spotify.com/v1/search?type=artist&query="+artist;
    $.ajax({
      url: url_spotify,
      method: "GET",
      success: function(data){
       var arr = take_names_imgs_and_ids_artist(data);
       show_list_artist(arr);
      },
      error: function(){ console.log("error form_submit")}
    });
  });
};

function take_names_imgs_and_ids_artist(data){
  var artists_info = [];
  data.artists.items.forEach(function(artist){
    if (artist.images.length != 0){
      var index = artist.images.length-1;
      var images = artist.images[index].url;
      var name = artist.name;
      var id = artist.id;
      artists_info.push({ name: name, img: images, id: id });
    };
  });
  return artists_info;
};

function show_list_artist(arr_artist){
  $('.js-table-artist').hide();
  $('#list').empty();
  $('.js-table-artist').fadeIn(1000).slideDown(3000);
  arr_artist.forEach(function(artist){
  var html = '<tr><td data-id="'+artist.id+'" data-name="'+artist.name+'"><img src="'+artist.img+'" class="img-thumbnail"/></td><td data-id="'+artist.id+'" data-name="'+artist.name+'"><h3><b>'+artist.name+'</b></h3></td></tr>';
  $('#list').append(html);
  artist_click();
  });
};

function show_albums_with_modals(arr_albums,name_artist){
  $('.modal-body').empty();
  $('.modal-title').empty();
  $('.modal-title').text('Albums of '+name_artist);
  arr_albums.forEach(function(album){
    var html = '<div class="album"><p>'+album.title+'</p><img class="img-thumbnail" data-id="'+album.id+'" data-title="'+album.title+'" src="'+album.img+'"></div>';
    $('.modal-body').append(html);
  });
  $('#js-albums-modal').modal('show');
};

function take_titles_ids_and_imgs_albums(data){
  var albums_info = [];
  data.items.forEach(function(album){
    var index = album.images.length-1;
    var title = album.name;
    var images = album.images[index].url;
    var id = album.id;
    albums_info.push({ title: title, img: images, id: id });
  });
  return albums_info;
};

function reload_audio_player(audio){
  var html = '<audio controls class="audio"><source src="'+audio+'" id="player"></audio>';
  $('.modal-body audio').remove();
  $('.modal-body ol').before(html);
  //$('#player').attr('src',audio);
};

function show_tracks_with_modals(arr_tracks,title_album){
  $('.modal-body').empty();
  $('.modal-title').empty();
  $('.modal-title').text(title_album+' album');  
  $('.modal-body').html('<audio controls class="audio"><source src="" id="player"></audio>');
  $('.modal-body').append('<ol></ol>');
  arr_tracks.forEach(function(track){
    var html = '<li class="text-left"><a href="'+track.preview+'">'+track.name+'</a></li>'
    $('.modal-body ol').append(html);
  });
  $('#js-albums-modal').modal('show');
  $('.modal-body ol').on('click', 'a', function(event){
    event.preventDefault();
    var audio = $(event.currentTarget).attr('href');
    reload_audio_player(audio);
  });
};

function take_name_and_previewurl_tracks(data){
  var tracks_info = [];
  data.items.forEach(function(track){
    var name = track.name;
    var url_preview = track.preview_url;
    tracks_info.push({ name: name, preview: url_preview });
  });
  console.log(tracks_info);
  return tracks_info;
};

function album_click(){
  $('.modal-body').on('click', 'img', function(event){
    var id_album = $(event.currentTarget).attr('data-id');
    var title_album = $(event.currentTarget).attr('data-title');
    var request = $.get('https://api.spotify.com/v1/albums/'+id_album+'/tracks');
    request.done(function(data){
      var arr = take_name_and_previewurl_tracks(data);
      show_tracks_with_modals(arr,title_album);
    });
    request.fail(function(){ console.log("error album_click")});
  });
};

function artist_click(){
  $('#list').on('click', 'td', function(event){
    var element = $(event.currentTarget);
    var id_artist = element.attr('data-id');
    var name_artist = element.attr('data-name');
    var request = $.get('https://api.spotify.com/v1/artists/'+id_artist+'/albums');
    request.done(function(data){
      var arr = take_titles_ids_and_imgs_albums(data);
      show_albums_with_modals(arr,name_artist);
      album_click();
    });
    request.fail(function(){ console.log("error artist_click")});
  });
};

$(document).on('ready',function(){
  form_submit();
});