$( document ).ready(function(){
  $('.show-unread').on('click', showUnreadLinks)
})

function showUnreadLinks (event) {
  event.preventDefault();
  $('.read-link').parents('tr').addClass('hidden');
  $('.unread-link').parents('tr').removeClass('hidden');
}
