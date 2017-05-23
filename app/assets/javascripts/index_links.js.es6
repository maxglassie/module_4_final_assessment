const API = 'http://localhost:3000/'

$(document).ready(function() {
  getLinks();
});

function getLinks() {
  return $.ajax({
    url: '/api/v1/links',
    method: 'GET'
  }).done(function(data) {
    data.forEach(function(e) {
      prependLink(e);
    });
  }).fail(function(error){
    console.error(error);
  });
};

function prependLink(data) {
  $('#tb-links').prepend(`<tr class='link-row'>
    <td id='link-title'> Title: ${data.title} </td>
    <td id='link-url'> URL: ${data.url} </td>
    <td id='link-read'> Read?: ${data.read} </td>
    </tr>`);
}