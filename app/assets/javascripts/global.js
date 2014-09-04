$(document).ready(function(){

  //Convert all selects to select2
  $('select').each(function(index, elem){
    var $select = $(elem);

    if ($select.data('convert') != 'no'){
      $select.select2();
    }
  })
});