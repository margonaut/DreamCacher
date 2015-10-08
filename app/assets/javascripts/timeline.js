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
  var $t = $(this);
  $.ajax({
    method: "GET",
    url: ("/dreams"),
    data: { dream_id: dreamId },
    dataType: "json"
  })
  .done(function(data){
    var activeDream = data["active_dream"]
    changeDream(activeDream);
  });
});


var changeDream = function(dream) {
  var dreamTitle = $('#dream-title');
  var dreamText = $('#dream-text');
  var dreamKeys = $('.dream-key');
  dreamTitle.text(dream.title);
  dreamText.text(dream.text);

  for (i = 0; i > dreamKeys.length; i++ ) {
    var key = dreamKeys[i];
    // write method to wipe list and write new lis correctly
  };
};
