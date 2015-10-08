var replaceKeywords = function(keywords) {
  $(".dream-key").remove();
  var list = $("#keyword-list");
  for (var i = 0; i < keywords.length; i++) {
    list.append("<li class=\"dream-key\">" + keywords[i].text + "</li>");
  }
};

var changeDream = function(dream) {
  var keywords = dream.dreams_keywords;
  var dreamTitle = $("#dream-title");
  var dreamText = $("#dream-text");
  dreamTitle.text(dream.title);
  dreamText.text(dream.text);
  replaceKeywords(keywords);
};

$(".details").on("click", function(event) {
  event.preventDefault();
  if(event.isDefaultPrevented()){
      // default event is prevented
  }else{
      event.returnValue = false;
  }
  var dreamId = this.id;
  $.ajax({
    method: "GET",
    url: ("/api/v1/dreams/" + dreamId),
    data: { dream_id: dreamId },
    dataType: "json"
  })
  .done(function(data){
    changeDream(data.dream);
  });
});
