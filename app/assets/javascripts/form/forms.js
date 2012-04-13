$(document).ready(function(){
  $('.remove-field').live("click",function(e){
    $(this).parent().parent().remove();
    e.preventDefault();
  });
  $('.removetag').live("click",function(e){
    $(this).parent().remove();
    if($('.tag').size() == 0){
      $('.notags').show();
    }
    e.preventDefault();
  });
  $('.taginput').keypress(function(e){
    if(e.which == 13){
      $('.'+$(this).attr('id')).click();
      e.preventDefault();
    }
  });
  if($('.tag').size() > 0){
    $('.notags').hide();
  }
});
