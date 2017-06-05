$( document ).ready(function(){
    $("body").on("click", ".mark-as-read", markAsRead)
});

function markAsRead(event) {
  event.preventDefault();
  const linkId = $(this).data('link-id');
  const link = $(this);

  $.ajax({
    url: '/api/v1/links' + linkId,
    method: 'PATCH',
    data: { read: true }
  }).then(updateLinkText(link))
};

function updateLinkText(link) {
  $(`.link[data-link-id=${link.id}]`).find(".read-status").text(link.read);
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
