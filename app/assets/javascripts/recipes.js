$(document).ready(function(){
  var hours_array = [];
  var minutes_array = [];
  var hours = "hours"
  var minutes = "minutes"
  var start_preparation_time_unit = document.getElementById("start_preparation_time_unit");
  var end_preparation_time_unit = document.getElementById("end_preparation_time_unit");
  var end_preparation_time = document.getElementById("end_preparation_time");
  var start_preparation_time = document.getElementById("start_preparation_time");
  var start_cooking_time_unit = document.getElementById("start_cooking_time_unit");
  var end_cooking_time_unit = document.getElementById("end_cooking_time_unit");
  
  function appendOptions(array, selectTag){
    for(var i=0;i<array.length;i++) {
        var option = document.createElement('option');
        option.innerHTML = array[i];
        option.value = array[i];
        selectTag.appendChild(option);
    }
  }
  
  function appendErrorLabel(element){
    $(element).css({'border-color':'red', 'border-style':'solid','border-width':'1px'});
    var id = $(element).attr('id')+'_error';
    $("."+id).prev().remove();
    $("."+id).remove();
    var label = $('<label>');
    label.text('* This field is required');
    label.css('color','red');
    label.attr('class', id);
    var br_label = $("<br/>").add(label)
    $(br_label).insertAfter(element);
  }
  
  function hideErrorLabel(element){
    $(element).css({'border-color':'#DCE6F7','border-style':'none'});
    
    var id = $(element).attr('id')+'_error';
    $("."+id).prev().remove();
    $("."+id).remove();
  }
  
  for(var i=1;i<=10;i++) {
    hours_array.push(i);
  }
  for(var i=0;i<=59;i++) {
    if(i%5 == 0) {
      minutes_array.push(i);
    }
  }

  // start_preparation_time_unit change  
  $("#start_preparation_time_unit").change(function(){

    var selected_value = start_preparation_time_unit.options[start_preparation_time_unit.selectedIndex].value
    $("#end_preparation_time_unit").val(selected_value);
    while (end_preparation_time.firstChild) {
      end_preparation_time.removeChild(end_preparation_time.firstChild);
    }
    while(start_preparation_time.firstChild) {
      start_preparation_time.removeChild(start_preparation_time.firstChild);
    }
    if(selected_value == hours) {
      appendOptions(hours_array, end_preparation_time)
      appendOptions(hours_array, start_preparation_time)
    }
    
    if(selected_value == minutes) {
      appendOptions(minutes_array, end_preparation_time)
      appendOptions(minutes_array, start_preparation_time)
    }
  });  
  
  // end_preparation_time_unit change
  $("#end_preparation_time_unit").change(function(){
    var selected_value = end_preparation_time_unit.options[end_preparation_time_unit.selectedIndex].value
    if(selected_value == minutes) {
      $("#start_preparation_time_unit").val(selected_value);
      while(end_preparation_time.firstChild) {
        end_preparation_time.removeChild(end_preparation_time.firstChild)
      }
      appendOptions(minutes_array, end_preparation_time)
      while(start_preparation_time.firstChild) {
        start_preparation_time.removeChild(start_preparation_time.firstChild)
      }
      appendOptions(minutes_array, start_preparation_time)
    }
    if(selected_value == hours) {
      while(end_preparation_time.firstChild) {
        end_preparation_time.removeChild(end_preparation_time.firstChild)
      }
      appendOptions(hours_array, end_preparation_time)
    }
  });  
  
  // start_cooking_time_unit change
  $("#start_cooking_time_unit").change(function(){
    var selected_value = start_cooking_time_unit.options[start_cooking_time_unit.selectedIndex].value
    if(selected_value == minutes) {
      $("#end_cooking_time_unit").val(selected_value);
      while(start_cooking_time.firstChild) {
        start_cooking_time.removeChild(start_cooking_time.firstChild)
      }
      appendOptions(minutes_array, start_cooking_time)
      while(end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild)
      }
      appendOptions(minutes_array, end_cooking_time)
    }
    if(selected_value == hours) {
      $("#end_cooking_time_unit").val(selected_value);
      while(start_cooking_time.firstChild) {
        start_cooking_time.removeChild(start_cooking_time.firstChild)
      }
      appendOptions(hours_array, start_cooking_time)
      while(end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild)
      }
      appendOptions(hours_array, end_cooking_time)
    }
  });  
  
  // end_cooking_time_unit change
  $("#end_cooking_time_unit").change(function(){
    var selected_value = end_cooking_time_unit.options[end_cooking_time_unit.selectedIndex].value
    if(selected_value == minutes) {
      $("#start_cooking_time_unit").val(selected_value);    
      while(end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild)
      }
      appendOptions(minutes_array, end_cooking_time)
      while(start_cooking_time.firstChild) {
        start_cooking_time.removeChild(start_cooking_time.firstChild)
      }
      appendOptions(minutes_array, start_cooking_time)
    }
    else if(selected_value == hours) {
      while(end_cooking_time.firstChild) {
        end_cooking_time.removeChild(end_cooking_time.firstChild)
      }
      appendOptions(hours_array, end_cooking_time)
    }
  });
  
  $("#recipe_name").focusout(function(){
    var val = $(this).val();
    if(val == '') {
      appendErrorLabel(this);
    } else {
      hideErrorLabel(this);    
    }
  });
  $("#recipe_name").focusin(function(){
    hideErrorLabel(this);    
  });
  $("#recipe_information").focusout(function(event){
    var val = $(this).val();
    if(val == '') {
      appendErrorLabel(this);
    } else {
      hideErrorLabel(this);
    }
  });
  $("#recipe_information").focusin(function(){
    hideErrorLabel(this);
  });
  $("#recipe_preparation_method").focusout(function(){
    var val = $(this).val();
    if(val == '') {
      appendErrorLabel(this);
    } else {
      hideErrorLabel(this);    
    }
  });
  $("#recipe_preparation_method").focusin(function(){
    hideErrorLabel(this);
  });
  $(document).click(function(){
    $("#recipe_information").off("focusout",false);
  });
  $("input[name='commit']").click(function(){
    $("#recipe_information").on("focusout", false);
  });
  $("#recipe_form").submit(function(event){
    $("#recipe_information").on("focusout", false);
  });
});
