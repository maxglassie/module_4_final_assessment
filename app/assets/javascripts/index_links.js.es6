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
    <td id='link-edit'>
        <form action="http://localhost:3000/links/${data.id}/edit">
            <input type="submit" value="Edit">
        </form>
     </td>
    </tr>`);
}

function saveLink(url, title) {
  let newLink = new Link(url, title)
  $.post('http://localhost:3000/api/v1/links', newLink)
  .then((data) => {
    prependLink(data)
    clearErrors();
    clearInput();
  })
  .fail((xhr, status, error) => {
    clearErrors();
    clearInput();
    raiseErrors(xhr, status, error);
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

function clearErrors() {
  $('.validation-error').empty();
}

function clearInput() {
  $('#link-url').val("");
  $('#link-title').val("");
}

function filterLinks() {
  let input, filter, table, tr, td, i;
  input = document.getElementById("input-field");
  filter = input.value.toUpperCase();
  table = document.getElementById("the-table");
  tr = table.getElementsByTagName("tr");

  for (i = 1; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}