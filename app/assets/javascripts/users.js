$(".users.show").ready(function() {
  var alignHeights, waitForFinalEvent;
  alignHeights = function() {
    var breakdownHeight, effectiveHeight, happinessHeight, historyHeight;
    effectiveHeight = $(".my-effective-activities").height();
    happinessHeight = $(".my-happiness").height();
    historyHeight = $(".my-activity-history").height();
    breakdownHeight = $(".my-activity-breakdown").height();
    if (effectiveHeight > happinessHeight) {
      $(".my-happiness").height(effectiveHeight);
    } else {
      $(".my-effective-activities").height(happinessHeight);
    }
    if (historyHeight > breakdownHeight) {
      $(".my-activity-breakdown").height(historyHeight);
    } else {
      $(".my-activity-history").height(breakdownHeight);
    }
  };
  alignHeights();
  waitForFinalEvent = (function() {
    var timers;
    timers = {};
    return function(callback, ms, uniqueId) {
      if (!uniqueId) {
        uniqueId = "Don't call this twice without a uniqueId";
      }
      if (timers[uniqueId]) {
        clearTimeout(timers[uniqueId]);
      }
      timers[uniqueId] = setTimeout(callback, ms);
    };
  })();
  $(window).resize(function() {
    waitForFinalEvent(alignHeights(), 25, "div heights");
  });
  $("#container1").highcharts({
    chart: {
      type: "spline"
    },
    title: {
      text: ""
    },
    subtitle: {
      text: ""
    },
    xAxis: {
      type: "datetime",
      dateTimeLabelFormats: {
        day: "%b",
        month: "%b",
        year: "%b"
      },
      title: {
        text: ""
      }
    },
    yAxis: {
      title: {
        text: ""
      },
      max: 100
    },
    tooltip: {
      headerFormat: "<b>Happiness Level</b><br>",
      pointFormat: "{point.x:%b %e}: {point.y:.0f} / 100"
    },
    series: [
      {
        showInLegend: false,
        data: [[Date.UTC(2014, 6, 15), 78], [Date.UTC(2014, 6, 30), 83], [Date.UTC(2014, 7, 18), 81], [Date.UTC(2014, 8, 8), 88], [Date.UTC(2014, 8, 28), 92], [Date.UTC(2014, 9, 19), 84], [Date.UTC(2014, 10, 2), 87], [Date.UTC(2014, 10, 20), 90]],
        pointInterval: 24 * 3600 * 1000
      }
    ]
  });
});

$('.users.new').ready(function() {
  window.startTrip = function() {
    var trip;
    trip = new Trip([
      {
        sel: $("#user_first_name, label[for=\"user_first_name\"]"),
        content: "Required. Max length of 20 characters.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_last_name, label[for=\"user_last_name\"]"),
        content: "Required. Max length of 30 characters.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_email, label[for=\"user_email\"]"),
        content: "Required. Valid email address.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_password, label[for=\"user_password\"]"),
        content: "Required. Min length of 6 characters.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_password_confirmation, label[for=\"user_password_confirmation\"]"),
        content: "Required. Must be the same.",
        expose: true,
        position: "e"
      }, {
        sel: $(".create"),
        content: "When finished, click to here create your account.",
        expose: true,
        position: "e"
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

$('.users.edit').ready(function() {
  window.startTrip = function() {
    var trip;
    trip = new Trip([
      {
        sel: $("#user_first_name, label[for=\"user_first_name\"]"),
        content: "Required. Max length of 20 characters.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_last_name, label[for=\"user_last_name\"]"),
        content: "Required. Max length of 30 characters.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_email, label[for=\"user_email\"]"),
        content: "Required. Valid email address.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_password, label[for=\"user_password\"]"),
        content: "Required to save any changes. Can be same as previous. Min length of 6 characters.",
        expose: true,
        position: "e"
      }, {
        sel: $("#user_password_confirmation, label[for=\"user_password_confirmation\"]"),
        content: "Required. Must be the same as Password field.",
        expose: true,
        position: "e"
      }, {
        sel: $(".update"),
        content: "When finished, click to here update your account.",
        expose: true,
        position: "e"
      }, {
        sel: $(".gravatar-link"),
        content: "Visit Gravatar's website to change your picture.",
        expose: true,
        position: "e"
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
