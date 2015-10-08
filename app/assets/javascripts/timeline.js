var changeDream = function(dream) {
  var dreamTitle = $("#dream-title");
  var dreamText = $("#dream-text");
  var dreamKeys = $(".dream-key");
  dreamTitle.text(dream.title);
  dreamText.text(dream.text);
  // loop through dreamKeys
  // write method to wipe list and write new lis correctly
};

$(".details").on("click", function(event) {
  debugger;
  event.preventDefault();
  if(event.isDefaultPrevented()){
      // default event is prevented
  }else{
      event.returnValue = false;
      console.log("what")
  }
  var dreamId = this.id;
  $.ajax({
    method: "GET",
    url: ("/dreams"),
    data: { dream_id: dreamId },
    dataType: "json"
  })
  .done(function(data){
    var activeDream = data["active_dream"];
    changeDream(activeDream);
  });
});
