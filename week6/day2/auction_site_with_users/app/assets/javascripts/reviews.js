// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function delete_reviews(event){
  event.preventDefault;
  review_id = $(event.currentTarget).attr('data-id')
  $.ajax({
    url: 'http://localhost:3000/reviews'
    type: 'delete'
    data: {review_id: review_id}
  });
}

$(document).on('ready', function(){
  //$('.js-reviews').on('click', 'img.js-edit', edit_reviews);
  $('.js-reviews').on('click', 'img.js-delete', delete_reviews)
})