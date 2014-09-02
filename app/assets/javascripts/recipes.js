$(document).ready(function () {
  'use strict';
  var hours_array = [], minutes_array = [];
  var hours = "hours", minutes = "minutes";
  var start_preparation_time_unit = document.getElementById("start_preparation_time_unit"), end_preparation_time_unit = document.getElementById("end_preparation_time_unit"), end_preparation_time = document.getElementById("recipe_end_preparation_time"), start_preparation_time = document.getElementById("recipe_start_preparation_time"), start_cooking_time_unit = document.getElementById("start_cooking_time_unit"), end_cooking_time_unit = document.getElementById("end_cooking_time_unit"), start_cooking_time = document.getElementById("recipe_start_cooking_time"), end_cooking_time = document.getElementById("recipe_end_cooking_time");

  function appendOptions(array, selectTag) {
    for (var opt = 0; opt<array.length; opt++) {
        var option = document.createElement("option");
        option.innerHTML = array[opt];
        option.value = array[opt];
        selectTag.appendChild(option);
    }
  }

  function applyErrorStyle(element) {
    $(element).css({'border-color' : 'red', 'border-style' : 'solid', 'border-width' : '1px'});
  }

  function hideErrorStyle(element) {
  	$(element).css({'border-color' : '#DCE6F7', 'border-style' : 'none'});
  }

  function preparationTimeValidation() {
    var errorString = 'Start time greater than end time';
    var end_prep_time = parseInt($("#end_preparation_time").val());
    var start_prep_time = parseInt($("#start_preparation_time").val());
    if ($("#start_preparation_time_unit").val() == $("#end_preparation_time_unit").val()) {
      if (start_prep_time > end_prep_time) {
        $("#error_preparation_time").text(errorString);
      } else if (start_prep_time <= end_prep_time) {
        $("#error_preparation_time").text("");
      }
    }
  }

  function cookingTimeValidation() {
	var errorString = "Start time greater than end time";
    var start_cook_time = parseInt($("#start_cooking_time").val());
    var end_cook_time = parseInt($("#end_cooking_time").val());
    if ($("#start_cooking_time_unit").val() == $("#end_cooking_time_unit").val()) {
      if (start_cook_time > end_cook_time) {
        $("#error_cooking_time").text(errorString);
      } else if (start_cook_time <= end_cook_time) {
        $("#error_cooking_time").text("");
      }
    }
  }

  // Hide the notice contents
  setTimeout(function() {
    $(".notice").contents().filter(function() {
      return this.nodeType === 3;
    }).remove();
  }, 3000);
   for (var hr=1; hr<=10; hr++) {
    hours_array.push(hr);
  }
  for (var mi=0; mi<=59; mi++) {
    if (mi%5 === 0) {
      minutes_array.push(mi);
    }
  }
   // start_preparation_time_unit change
  $("#start_preparation_time_unit").change(function() {
    var selected_value = start_preparation_time_unit.options[start_preparation_time_unit.selectedIndex].value;
    $("#end_preparation_time_unit").val(selected_value);
    while (end_preparation_time.firstChild) {
      end_preparation_time.removeChild(end_preparation_time.firstChild);
    }
    while (start_preparation_time.firstChild) {
      start_preparation_time.removeChild(start_preparation_time.firstChild);
    }
    if (selected_value === hours) {
      appendOptions(hours_array, end_preparation_time);
      appendOptions(hours_array, start_preparation_time);
    }
    if (selected_value == minutes) {
      appendOptions(minutes_array, end_preparation_time);
      appendOptions(minutes_array, start_preparation_time);
    }
    // reset the error msg
    $("#error_preparation_time").text("");
  });

  // end_preparation_time_unit change
  $("#end_preparation_time_unit").change(function() {
    var selected_value = end_preparation_time_unit.options[end_preparation_time_unit.selectedIndex].value;
    if (selected_value == minutes) {
      $("#start_preparation_time_unit").val(selected_value);
      while (end_preparation_time.firstChild) {
        end_preparation_time.removeChild(end_preparation_time.firstChild);
      }
      appendOptions(minutes_array, end_preparation_time);
      while (start_preparation_time.firstChild) {
        start_preparation_time.removeChild(start_preparation_time.firstChild);
      }
      appendOptions(minutes_array, start_preparation_time);
    }
    if (selected_value == hours) {
      while (end_preparation_time.firstChild) {
        end_preparation_time.removeChild(end_preparation_time.firstChild);
      }
      appendOptions(hours_array, end_preparation_time);
    }
    // reset the error msg
    $("#error_preparation_time").text("");
  });

  // start_cooking_time_unit change
  $("#start_cooking_time_unit").change(function() {
    var selected_value = start_cooking_time_unit.options[start_cooking_time_unit.selectedIndex].value;
    if (selected_value == minutes) {
      $("#end_cooking_time_unit").val(selected_value);
      while (start_cooking_time.firstChild) {
        start_cooking_time.removeChild(start_cooking_time.firstChild);
      }
      appendOptions(minutes_array, start_cooking_time);
      while (end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild);
      }
      appendOptions(minutes_array, end_cooking_time);
    }
    if (selected_value == hours) {
      $("#end_cooking_time_unit").val(selected_value);
      while (start_cooking_time.firstChild) {
        start_cooking_time.removeChild(start_cooking_time.firstChild);
      }
      appendOptions(hours_array, start_cooking_time);
      while (end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild);
      }
      appendOptions(hours_array, end_cooking_time);
    }
    // reset the error msg
    $("#error_cooking_time").text("");
  });

  // end_cooking_time_unit change
  $("#end_cooking_time_unit").change(function() {
    var selected_value = end_cooking_time_unit.options[end_cooking_time_unit.selectedIndex].value;
    if (selected_value == minutes) {
      $("#start_cooking_time_unit").val(selected_value);
      while (end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild);
      }
      appendOptions(minutes_array, end_cooking_time);
      while (start_cooking_time.firstChild) {
        start_cooking_time.removeChild(start_cooking_time.firstChild);
      }
      appendOptions(minutes_array, start_cooking_time);
    }
    else if (selected_value == hours) {
      while (end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild);
      }
      appendOptions(hours_array, end_cooking_time);
    }
    // reset the error msg
    $("#error_cooking_time").text("");
  });

  $("#recipe_start_preparation_time").change(function() {
    preparationTimeValidation();
  });

  $("#recipe_end_preparation_time").change(function() {
    preparationTimeValidation();
  });

  $("#recipe_start_cooking_time").change(function() {
    cookingTimeValidation();
  });

  $("#recipe_end_cooking_time").change(function() {
    cookingTimeValidation();
  });

  $("#recipe_name").focusout(function() {
    var val = $(this).val();
    if (val === '') {
      applyErrorStyle(this);
    } else {
      hideErrorStyle(this);
    }
  });

  $("#recipe_name").focusin(function() {
    hideErrorStyle(this);
  });

  $("#recipe_information").focusout(function() {
    var val = $(this).val();
    if (val === '') {
      applyErrorStyle(this);
    } else {
      hideErrorStyle(this);
    }
  });

  $("#recipe_information").focusin(function() {
    hideErrorStyle(this);
  });

  $("#recipe_preparation_method").focusout(function(){
    var val = $(this).val();
    if (val === '') {
      applyErrorStyle(this);
    } else {
      hideErrorStyle(this);
    }
  });

  $("#recipe_preparation_method").focusin(function() {
    hideErrorStyle(this);
  });
});
