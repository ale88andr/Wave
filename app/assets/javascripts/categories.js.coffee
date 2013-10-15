# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){
  $('#per_page_selector').on('change', function(){
  	href = $('#per_page_link').attr('href')
    $('#per_page_link').attr('href', href + '/limit/' + this.value);
  });
});