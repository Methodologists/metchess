$(document).ready(function(){
  $("td").click(function(){
    var data= $(this).data();
    console.log("data: ", data);
  });
});