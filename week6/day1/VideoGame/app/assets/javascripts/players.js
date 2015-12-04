// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function call_api_players(event){
  var tournament_id = $(event.currentTarget).attr('data-id');
  $.ajax({
    url: '/api/players.json',
    type: 'get',
    data: {id:tournament_id},
    success: select_players
  });
  $('[data-Tid~='+tournament_id+']').toggleClass('hidden');
};

function select_players(response){
  var select_input = $('.js-select');
  select_input.empty();
  response.forEach(function(player){
    var html = '<option value="'+player.name+'">'+player.name+'</option>';
    select_input.append(html);
  });
  $('select').on('click', selected_player);
}

function selected_player(event){
  event.preventDefault;
  var player = $(event.currentTarget).val();
  var tournament_id = $('.js-select:not(.hidden)').attr('data-Tid');
  //console.log(player+tournament_id);
  $.ajax({
    url: '/api/players',
    type: "post",
    data: {player_name: player, tournament_id: tournament_id},
    success: tournamentsIndex
  });
}
