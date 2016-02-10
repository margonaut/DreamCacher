var replaceKeywords = function(keywords) {
  $(".dream-key").remove();
  var list = $("#keyword-list");
  for (var i = 0; i < keywords.length; i++) {
    list.append("<li class=\"" + keywords[i]["positivity"] + " dream-key\">" + keywords[i].text + "</li>");
  }
};

var replaceLinks = function(dreamId) {
  $("#delete-link").attr("href", "/dreams/" + dreamId);
  $("#edit-link").attr("href", "/dreams/" + dreamId + "/edit");
};

var changeDream = function(dream) {
  var keywords = dream.dreams_keywords;
  var dreamTitle = $("#dream-title");
  var dreamText = $("#dream-text");
  var dreamSentiment = $("#dream-sentiment");
  dreamTitle.text(dream.title);
  dreamText.text(dream.text);
  dreamSentiment.text(dream.sentiment);
  replaceKeywords(keywords);
  replaceLinks(dream.id);
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

$(".dream-key").on("click", function(event) {
  event.preventDefault();
  if(event.isDefaultPrevented()){
      // default event is prevented
  }else{
      event.returnValue = false;
  }
  var string = this.textContent;
  var positivity = this.classList[0];
  toggleKeywords(string, positivity);
});

$(".expand").on("click", function(event) {
  event.preventDefault();
  var snippet = $(this).siblings('.snippet');
  var fullText = $(this).siblings('.full-text');
  fullText.toggleClass('hide');
  snippet.toggleClass('hide');
  this.innerHTML = (this.innerHTML == 'Expand') ? 'Hide' : 'Expand' ;
});
