function tournamentsIndex () {
  $('.js-tourney-section').empty();
  var request = $.get('/api/tournaments.json')
  request.fail(showError)
  request.done(showTournaments)
  $(document).on('click', '[data-hook~=tourney-delete]', deleteTournament);
  $(document).on('click', '.js-btn-players', call_api_players);

  var $tourneySection = $('.js-tourney-section')  

  function showError (error) {
    console.error('Error fetching tournament list.', '\n' + error.responseText)
    var message = 'There was a problem fetching the list of tournaments.'
    $tourneySection.append(buildErrorHtml(message))
  }

  function showTournaments (tournaments) {
    var html

    if (tournaments.length === 0) {
      html = buildErrorHtml('Looks like there aren\'t any tournaments yet.')
    } else {
      html = buildTourneyListHtml(tournaments)
    }

    $tourneySection.append(html)

    $('[data-hook~=tourney-add]').removeClass('hidden')
  }

 function deleteTournament (event) {
   var tournament_id = $(event.currentTarget).val();
    var request = $.ajax({
    url: '/api/tournaments',
    type: 'DELETE',
    data: {id:tournament_id},
    success: tournamentsIndex
  });

  }


}
