const $ = require('jquery');
const API = 'http://localhost:3000/'

$(document).ready(function() {
  getLinks();
});

function getLinks() {
  return $.ajax({
    url: '/api/v1/links',
    method: 'GET'
  }).done(function(data) {
    debugger;
    // data.forEach(e) {
    //   prependLink(e)
    // };
  })
};

function prependLinks(data) {
  $('#tb-links').prepend(`<tr class='link-row'>
    <td id='link-title'> Title: ${data.title} </td>
    <td id='link-url'> URL: ${data.url} </td>
    <td id='link-read'> Read?: ${data.read} </td>
    </tr>
    `)
}