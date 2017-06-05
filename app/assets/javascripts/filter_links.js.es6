$(document).ready(function() {
  $('#search').on('keyup', filterSearchResults)
});

function filterSearchResults(event) {
  event.preventDefault();
  let text = $('#search').val().toLowerCase();
  let allTitles = $('.title');
  allTitles.each(function(row) {
    const title = $(this).text().toLowerCase();
    const currentRow = $(this).parents('tr');
    const url = currentRow.find('.link').text().toLowerCase();
    if (!title.includes(text) || !url.includes(text)) {
      currentRow.addClass('hidden');
    };
  });
};
