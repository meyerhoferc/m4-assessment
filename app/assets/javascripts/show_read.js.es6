$( document ).ready(function(){
  $('.show-read').on('click', showReadLinks)
})

function showReadLinks (event) {
  event.preventDefault();
  $('.unread-link').parents('tr').addClass('hidden');
  $('.read-link').parents('tr').removeClass('hidden');
}
