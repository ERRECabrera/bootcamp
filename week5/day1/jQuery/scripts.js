var phrases = [
  "Always return the bright sido of life",
  "Code caffeine",
  "Error 404"
];

var index = null;

function random_phrass(){
  index = Math.round((Math.random())*phrases.length-1);
  phrass = phrases[index];
  $('#phrass').text('"'+phrass+'"');
};

function paint_phrass_with_color(){
  position = index+1
  css = '#phrases p:nth-child('+position+')';
  $(css).toggleClass("colorize");
};

function html_phrases(){
  var phrases_html = "";
  phrases.forEach(function(sentence){
    phrases_html = phrases_html + '<p><img src="">' + sentence + '</p>';
  });
  $('#phrases').html(phrases_html);
  $('#phrases img').attr('src',"https://www.seguronline.com/userfiles/image/iconos/icono-x.gif");
  $('#phrases').append('<p></p>');
};

$(document).on('ready', function(){
  $('a').text("Show Sentences");
  $('#phrases').hide();
  html_phrases();
  random_phrass();
  paint_phrass_with_color()
  $('.js-refresh').on('click', function(){
    random_phrass();
    $('#phrases *').removeClass('colorize');
    paint_phrass_with_color()
  });
  $('#input-phrass').on('keyup', function(){
    var chars = $(this).val();
    //$('#phrases').append();
    $('#phrases p:last-child').html("<p>"+chars+"</p>");
  });
  $('#input-phrass').on('keypress', function(event){
    if (event.keyCode == 13){
      event.preventDefault();
      var new_phrass = $('#input-phrass').val();
      phrases.push(new_phrass);
      //$('#phrases p:last-child').remove();
      //$('#input-phrass').attr('value',"");
      //$('#phrases').append("<p><img src='https://www.seguronline.com/userfiles/image/iconos/icono-x.gif'>"+new_phrass+"</p>");
      html_phrases();
      $('#input-phrass').val('');
      //$('#phrass').text('"'+new_phrass+'"');
    };/* else {
      var chars = $(this).val();
      //$('#phrases').append('<p></p>');
      $('#phrases p:last-child').html("<p>"+chars+"</p>"); 
      //$('#phrases p:last-child-1').remove();
    };*/
  });
  $('a').on('click',function(){
    if (/^S/.test($('a').text())){
      $('a').text("Hide Sentences");
    } else {
      $('a').text("Show Sentences");
    };
    $('#phrases').toggle();
  });
  $("#phrases").on("click", "img", function(event){
    $(event.currentTarget).parent().remove()
    /*$('#phrass').text('"'+father.id()+'"')*/
    phrases = phrases.filter(function(phrass){
      return phrass != $(event.currentTarget).parent().text();
    });
    //html_phrases();
  });
});

