$(document).ready(function(){
  $("td").click(function(){
    var data= $(this).data();
    console.log("data: ", data);
    var piece= $(this).find(".piece");
    console.log("piece", piece);
    if(piece.length > 0){
      var pieceId= piece.data();
      console.log(pieceId);
    }; 
  });
});