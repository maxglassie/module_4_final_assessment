$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
})

function markAsRead(e) {
  e.preventDefault();
  var linkId = $(this).parents('tr').data('id');

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: true }
  }).then((link) => {
    updateLinkStatus(link);
    sendToHotReads(link);
  })
  .fail(displayFailure);
}

function updateLinkStatus(link) {
  $(`.link-row[data-id=${link.id}]`).find("#link-read").text(`Read?: ${link.read}`)
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}

function sendToHotReads(link) {
  $.ajax({
    type: "POST",
    url: "http://localhost:4000/api/v1/links",
    data: {origin_id: link.id, url: link.url, read: link.read}
  }).then((data) => {
    if (data.number_one == true) {
      $(`.link-row[data-id=${data.origin_id}]`).append("TOP LINK")
    } else if (data.top_ten == true) {
      $(`.link-row[data-id=${data.origin_id}]`).append("HOT!")
    };
  })
}