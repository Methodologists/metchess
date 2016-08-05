$(function() {

  $( ".draggable" ).draggable({
    containment: ".chessboard",
    cursor: 'move',
    snap: '.droppable',
    stack: '.draggable'
  });

  $('td').droppable({
    drop: function(event, ui){
      // $(ui.draggable).detach().css({top: 0,left: 0});
      // $(this).replaceWith(ui.draggable);
      var pieceId = ui.draggable.data('piece_id');
      var gameTable = ui.draggable.parents('table');
      var gameId = $(gameTable).data('game_id');
      var updateUrl = "/games/" + gameId + "/pieces/" + pieceId;
      var row = $(this).data('row');
      var col = $(this).data('column');

      $.ajax({
        type: 'PUT',
        url: updateUrl,
        dataType: 'json', 
        data: { piece: { 
                y_cord: row, 
                x_cord: col 
        }},
        complete: function(){
          location.reload(true);
        }
      });
    }

  });




  // $( ".draggable a" ).disableSelection();
  //  $('td').droppable({
  //    drop: function(ev, ui) {

  //         var dropped = ui.draggable;
  //         var droppedOn = $(this);
  //        $(droppedOn).droppable("disable");
  //        $(dropped).parent().droppable("enable");
  //         $(dropped).detach().css({top: 0, left: 0}).appendTo(droppedOn);
  //     }
  //   });
   });
