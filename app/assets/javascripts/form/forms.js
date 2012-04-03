$(document).ready(function(){
  $('.remove-founder').live("click",function(){
    $(this).parent().parent().remove();
  });
});
