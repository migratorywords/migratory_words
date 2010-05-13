var active_color = '#000';
var inactive_color = '#ccc';
$(document).ready(function  () {
  $('input:submit').button().css({});
  $('#filter_toggle').click(function(){
    $('.filter_box').toggle();
  });
  // textarea
  $("textarea").css({"color":active_color,'width':'99%','height':'200px'});
  // var default_values = new Array();
  var default_value = 'Type a phrase you want to investigate or paste a bulk text.';
  $("textarea").focus(function() {
    // if (!default_values[this.id]) {
    //   default_values[this.id] = this.value;
    // }
    // if (this.value == default_values[this.id]) {
    this.style.color = active_color;
    if (this.value == default_value) {
      this.value = '';
    }
    $(this).blur(function() {
      if (this.value == '') {
        this.style.color = inactive_color;
        // this.value = default_values[this.id];
        this.value = default_value;
      }
    });
  });
  
  // slider
  $('#word-length').slider({min:2, max:6, step:1, values:[2,6], slide:updateWordLength, change:updateWordLength});
  
});

function updateWordLength () {
  var lengthVals = $('#word-length').slider('values');
  $('#min').text(lengthVals[0]);
  $('#max').text(lengthVals[1]);
  $('#word-length-min').val(lengthVals[0]);
  $('#word-length-max').val(lengthVals[1]);
}
