$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
})

function markAsRead(e) {
  e.preventDefault();

  var $link = $(this);//.parents('.link');
  var linkId = $link.data('link-id');

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: true },
  }).then(updateLinkToBeReadText(linkId))
    .fail(displayFailure);
}

function updateLinkToBeReadText(linkId) {
  $(`#link-${linkId}`).find(".read-status").text('Read');
  $(`#link-${linkId}`).find("button").html(`Mark as Unread`);
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
