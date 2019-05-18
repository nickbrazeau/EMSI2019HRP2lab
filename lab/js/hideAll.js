$(document).ready(function() {
  $plots = $('img.plot');
  $output = $("pre").not(".r");
  // Add the show/hide-button to each output chunk
  $output.prepend("<div class=\"showopt\">Show Output</div><br/>");
  // Select the <pre> tags, then choose their <code> child tags and toggle visibility
  $output.children("code").css({display: "none"});

  $plots.each(function () {
    $(this).wrap('<pre class=\"plot\"></pre>');
    $(this).parent('pre.plot').prepend("<div class=\"showopt\">Show Plot</div><br style=\"line-height:22px;\"/>");
  });

  // hide all chunks when document is loaded
  $output.children('.r').toggle();
  $('pre.plot').children('img').toggle();
  // function to toggle the visibility
  $('.showopt').click(function() {
    var label = $(this).html();
    if (label.indexOf("Show")) {
      $(this).html(label.replace("Show", "Hide"));
    } else {
      $(this).html(label.replace("Hide", "Show"));
    }
    $(this).siblings('code, img').slideToggle('fast', 'swing');
  });
});
