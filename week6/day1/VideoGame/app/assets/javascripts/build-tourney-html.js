function buildTourneyHtml (tournament) {
  return '\
    <li>\
      <a href="/tournaments/' + tournament.id + '">' + tournament.name + '</a>\
    </li>\
  ' +
  '<button class="js-button" data-hook="tourney-delete" type="submit" name="tournament" value="'+ tournament.id + '">DELETE</button>\ '
	+
	'<button class="js-btn-players" data-id="'+tournament.id+'">Add players</button>'
	+
	'<form><select class="js-select hidden" data-Tid="'+tournament.id+'"></select></form>'
}
