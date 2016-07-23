$(function() {

  $( ".draggable" ).draggable({
  containment: ".chessboard",
  
   });
  $( ".draggable a" ).disableSelection();
   $('td').droppable({
     drop: function(ev, ui) {
          var dropped = ui.draggable;
          var droppedOn = $(this);
         $(droppedOn).droppable("disable");
         $(dropped).parent().droppable("enable");
          $(dropped).detach().css({top: 0, left: 0}).appendTo(droppedOn);
      }
    });
   });