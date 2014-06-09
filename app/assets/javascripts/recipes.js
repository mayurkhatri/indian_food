$(document).ready(function(){
  var hours_array = [];
  for(var i=0;i<=10;i++) {
    hours_array.push(i);
  }
  
  $("#start_preparation_time_unit").change(function(){
    var hours = "hours"
    var minutes = "minutes"
    var start_preparation_time_unit = document.getElementById("start_preparation_time_unit");
    var end_preparation_time_unit = document.getElementById("end_preparation_time_unit");
    var end_preparation_time = document.getElementById("end_preparation_time");
    var start_preparation_time = document.getElementById("start_preparation_time");
    var selected_value = start_preparation_time_unit.options[start_preparation_time_unit.selectedIndex].value
    $("#end_preparation_time_unit").val(selected_value);
    while (end_preparation_time.firstChild) {
      end_preparation_time.removeChild(end_preparation_time.firstChild);
    }
    while(start_preparation_time.firstChild) {
      start_preparation_time.removeChild(start_preparation_time.firstChild);
    }
    if(selected_value == hours) {
      for(var i=0;i<hours_array.length;i++) {
        var option = document.createElement('option');
        option.innerHTML = hours_array[i];
        option.value = hours_array[i];
        end_preparation_time.appendChild(option);
//        start_preparation_time.appendChild(option);
      }
      for(var i=0;i<hours_array.length;i++) {
        var option = document.createElement('option');
        option.innerHTML = hours_array[i];
        option.value = hours_array[i];
//        end_preparation_time.appendChild(option);
        start_preparation_time.appendChild(option);
      }
    }
  });
  
  $("#end_preparation_time_unit").change(function(){
    var minutes = "minutes";
    var end_preparation_time_unit = document.getElementById("end_preparation_time_unit");
    var selected_value = end_preparation_time_unit.options[end_preparation_time_unit.selectedIndex].value
    if(selected_value == minutes) {
      $("#start_preparation_time_unit").val(selected_value);
    }
  });
  
  $("#start_cooking_time_unit").change(function(){
    var start_cooking_time_unit = document.getElementById("start_cooking_time_unit");
    var selected_value = start_cooking_time_unit.options[start_cooking_time_unit.selectedIndex].value
    $("#end_cooking_time_unit").val(selected_value);
  });
  
  $("#end_cooking_time_unit").change(function(){
    var minutes = "minutes";
    var end_cooking_time_unit = document.getElementById("end_cooking_time_unit");
    var selected_value = end_cooking_time_unit.options[end_cooking_time_unit.selectedIndex].value
    if(selected_value == minutes) {
      $("#start_cooking_time_unit").val(selected_value);    
    }
  });
}); 
