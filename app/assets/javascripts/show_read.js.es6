$( document ).ready(function(){
  $('.show-read').on('click', showReadLinks)
})

function showReadLinks (event) {
  event.preventDefault();
  console.log('function')
  $('.unread-link').parents('tr').addClass('hidden');
}

function updateLinkToBeReadText(linkId) {
  $(`#link-${linkId}`).find(".read-status").text('Read');
  $(`#link-${linkId}`).find("button").html(`Mark as Unread`);
  $(`#link-${linkId}`).find("button").removeClass('mark-as-read');
  $(`#link-${linkId}`).find("button").addClass('mark-as-unread');
  $(`#link-${linkId}`).find('.link').removeClass('unread-link');
  $(`#link-${linkId}`).find('.link').addClass('read-link');
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
