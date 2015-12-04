// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function main () {
  var isJoining = false

  $('[data-hook~=join-bbq]').on('click', function (event) {
    if (isJoining) {
      return
    }

    isJoining = true
    var $button = $(event.target)
    var bbqId = $button.closest('[data-bbq]').data('bbq')

    var request = $.post('/api/barbecues/' + bbqId + '/join')

    request.fail(function (response) {
      alert('Couldn’t join the barbecue'+ response.responseJSON.error)
      isJoining = false
    })

    request.done(function () {
      $button.fadeOut()
      isJoining = false
    })
  })

  if ($('[data-hook~=controller-barbecues][data-hook~=action-show]').length) {
    var $bbqContainer = $('[data-hook=bbq-info]')
    var bbqId = $bbqContainer.data('bbq')
    var request = $.get('/api/barbecues/' + bbqId)

    request.fail(function () {
      var htmlParts = [
        '<div class="alert alert-danger" role="alert">',
        '  There was a problem retrieving the BBQ info. Try again later.',
        '</div>'
      ]
      $bbqContainer.append(htmlParts.join('\n'))
    })

    request.done(function (bbq) {
      var bbqMoment = moment(bbq.date)
      
      var items = '';
      if (!(/^\w+\:\/\/\w+\:\d+\/$/).test(window.location.href)) {
        items = '<dt>Items:</dt><dd><ul>';
        bbq.items.forEach(function(item){
          items += '<li>' + item.name + '</li>';
        });
        items += '</ul></dd>';
        if (bbq.items.length == 0){ items = '<dt>Items:</dt><dd>Nothing yet.</dd>'; };
      };

      var htmlParts = [
        '<h2>' + bbq.title + '</h2>',
        '<dl>',
        '  <dt>Date:</dt>',
        '  <dd>' + bbqMoment.format('MMMM, D YYYY [at] h:mm a') + '</dd>',
        '  <dt>Venue:</dt>',
        '  <dd>' + bbq.venue + '</dd>',
        items,
        '</dl>'
      ]
      $bbqContainer.append(htmlParts.join('\n'))
    })
  }
})()
