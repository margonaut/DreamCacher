var changeSlide = function(current, next) {
  current.toggleClass("current");
  next.toggleClass("current");
};

$('.arrow').on("click", function(event) {
  var $slideOne = $(".analytics-slide");
  var $slideTwo = $(".timeline-slide");
  var $slideThree = $(".recording-slide");
  var $currentSlide = $(".current");

  if ($currentSlide.hasClass("analytics-slide")) {
    changeSlide($currentSlide, $slideTwo);
  } else if ($currentSlide.hasClass("timeline-slide")) {
    changeSlide($currentSlide, $slideThree);
  } else if ($currentSlide.hasClass("recording-slide")) {
    changeSlide($currentSlide, $slideOne);
  }
});
