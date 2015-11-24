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
       console.log(data);
       arr = take_names_and_imgs(data);
       show_list_artist(arr);
      },
      error: function(){ console.log("error")}
    });
  });
};

function take_names_and_imgs(data){
  var arr_artist = [];
  data.artists.items.forEach(function(artist){
    if (artist.images.length != 0){
      var index = artist.images.length-1;
      var images = artist.images[index].url;
      var name = artist.name;
      arr_artist.push({ name: name, img: images });
    };
  });
  return arr_artist;
};

function show_list_artist(arr_artist){
  $('.js-table-artist').hide();
  $('#list').empty();
  $('.js-table-artist').fadeIn(1000).slideDown(3000);
  arr_artist.forEach(function(artist){
  var html = '<tr><td><img src="'+artist.img+'"/></td><td style="">'+artist.name+'</td></tr>';
  $('#list').append(html);
  });
};

function artist_click(){
  $('.js-table-artist').on('click',function(event){

  });
};

$(document).on('ready',function(){
  form_submit();
});