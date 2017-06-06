$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead);
  $("body").on("click", ".mark-as-unread", markAsUnread);
});

function markAsRead(e) {
  e.preventDefault();

  var $link = $(this);
  var linkId = $link.data('link-id');
  var link = $(this).parents('tr').find('.link').text()
  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: true },
  }).then(updateLinkToBeReadText(linkId))
    .then(increaseHotReadCount(link))
    .fail(displayFailure);
};

function increaseHotReadCount(link) {
  $.ajax({
    type: 'POST',
    url: 'https://desolate-crag-20501.herokuapp.com/api/v1/links',
    data: {url: link}
  });
};

function markAsUnread(e) {
  e.preventDefault();

  var $link = $(this);
  var linkId = $link.data('link-id');

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: false },
  }).then(updateLinkToBeUnreadText(linkId))
    .fail(displayFailure);
}

function updateLinkToBeReadText(linkId) {
  $(`#link-${linkId}`).find(".read-status").text('Read');
  $(`#link-${linkId}`).find("button").html(`Mark as Unread`);
  $(`#link-${linkId}`).find("button").removeClass('mark-as-read');
  $(`#link-${linkId}`).find("button").addClass('mark-as-unread');
  $(`#link-${linkId}`).find('.link').removeClass('unread-link');
  $(`#link-${linkId}`).find('.link').addClass('read-link');
}

function updateLinkToBeUnreadText(linkId) {
  $(`#link-${linkId}`).find(".read-status").text('Unread');
  $(`#link-${linkId}`).find("button").html(`Mark as Read`);
  $(`#link-${linkId}`).find("button").removeClass('mark-as-unread');
  $(`#link-${linkId}`).find("button").addClass('mark-as-read');
  $(`#link-${linkId}`).find('.link').removeClass('read-link');
  $(`#link-${linkId}`).find('.link').addClass('unread-link');
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
