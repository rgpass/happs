$(".gratitudes.new, .joys.new, .kindnesses.new, .engagements.new").ready(function() {

window.startTrip = function() {
  var trip;
  trip = new Trip([
    {
      sel: $(".form"),
      content: "Write about this activity.",
      expose: true,
      position: "n"
    }, {
      sel: $("blockquote"),
      content: "Get inspiration.",
      expose: true,
      position: "n"
    }, {
      sel: $(".panel-group"),
      content: "Read about different strategies.",
      expose: true,
      position: "n"
    }
  ], {
    showNavigation: true,
    showCloseBox: true,
    delay: -1,
    animation: "fadeInUp"
  });
  trip.start();
};

});
