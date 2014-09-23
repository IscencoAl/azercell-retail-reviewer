$(document).ready(function(){

  handleElements($('body'));

});

function handleElements($elem){

  // Convert all selects to select2
  $elem.find('select').each(function(index, elem){
    var $select = $(elem);

    if ($select.data('convert') != 'no'){
      $select.select2();
    }
  })

  // Datepickers
  $elem.find('input[data-datepicker="yes"]').each(function(index, elem){
    var $input = $(elem),
        $group = $('<div class="input-group">'),
        $clear = $('<span class="input-group-btn">')
          .append('<a class="btn btn-default"><i class="glyphicon glyphicon-remove-circle"/></a>')
          .click(function(){ $input.val('') });

    if ($input.hasClass('input-sm'))
      $group.addClass('input-group-sm')
    else if ($input.hasClass('input-lg'))
      $group.addClass('input-group-lg')

    $input.attr('readonly', 'readonly')
      .wrap($group)
      .after($clear);

    $input.datepicker({
      dateFormat: "dd M yy"
    });
  })

  // Rangepickers
  $elem.find('.input-group[data-rangepicker="yes"]').each(function(index, elem){
    var $group = $(elem)
        $clear = $('<span class="input-group-btn">')
          .append('<a class="btn btn-default"><i class="glyphicon glyphicon-remove-circle"/></a>')
          .click(function(){ $group.find('input').val('') });

    $group.append($clear);

    $group.find('input').attr('readonly', 'readonly').datepicker({
      dateFormat: "dd M yy"
    });
  })

  // Tooltips
  $elem.find('[data-toggle="tooltip"]').each(function(index, elem){
    $(elem).tooltip();
  })

}