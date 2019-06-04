$(document).ready(function(){
  // increment
  $('.btn-outline-success').click(function(event) {
    event.preventDefault();
    
    var cardId = $(this).attr('scryfall_id');
    var userTotal = document.getElementById('totality').innerText;
    var cardPrice = $(this).attr('price');

    $.ajax({
      type: 'PUT',
      url: '/increment_counter',
      data: {scryfall_id: cardId},
      success: function(data) {
        console.log(data);
        $('#' + cardId).html(data.quantity_value);
        $('#totality').html((parseFloat(userTotal) + parseFloat(cardPrice)).toFixed(2));
      },
      dataType: 'json'
    });
  });

  // decrement
  $('.btn-outline-danger').click(function(event) {
    event.preventDefault(); 

    var cardId = $(this).attr('scryfall_id');
    console.log(cardId);
    $.ajax({
      type: 'PUT',
      url: '/decrement_counter',
      data: {scryfall_id: cardId},
      success: function(data) {
        console.log(data);
        $('#' + cardId).html(data.quantity_value);
      },
      dataType: 'json'
    });
  });

});

