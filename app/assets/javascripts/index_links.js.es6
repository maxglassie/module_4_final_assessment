const API = 'http://localhost:3000/'

class Link {
  constructor (url, title) {
    this.url = url;
    this.title = title;
  }
}

$(document).ready(function() {
  getLinks();

  $('#link-submit').on('click', (e) => {
    e.preventDefault()
    let linkURL = $('#link-url').val();
    let linkTitle = $('#link-title').val();
    saveLink(linkURL, linkTitle)
  });
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

function saveLink(url, title) {
  let newLink = new Link(url, title)
  $.post('http://localhost:3000/api/v1/links', newLink)
  .then((data) => {
    prependLink(data)
  })
  .fail((xhr, status, error) => {
    raiseErrors(xhr, status, error)
  })
}

function raiseErrors(xhr, status, error) {
  if (xhr.responseJSON[0] == "Url can't be blank") {
    $('.url-field').append(`<div class="validation-error"><p> ${xhr.responseJSON[0]} </p> </div>`)
  }
  if (xhr.responseJSON[0] == "Title can't be blank") {
    $('.title-field').append(`<div class="validation-error"><p> ${xhr.responseJSON[0]} </p> </div>`)
  }
  if (xhr.responseJSON[0] == "Url is not a valid HTTP URL") {
    $('.url-field').append(`<div class="validation-error"><p> Invalid URL </p> </div>`)
  }
}