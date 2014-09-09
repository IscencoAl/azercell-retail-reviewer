$(document).ready(function(){

  handleElements($('body'));

});

function handleElements($elem){

  //Convert all selects to select2
  $elem.find('select').each(function(index, elem){
    var $select = $(elem);

    if ($select.data('convert') != 'no'){
      $select.select2();
    }
  })

}