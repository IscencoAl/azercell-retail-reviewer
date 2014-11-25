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

  // Handle links in modal window
  $elem.find('a[data-modal="true"]').click(function(e) {
    var $element = $(this),
        $modal_container = $('#mainmodal'),
        $body = $modal_container.find('.modal-body'),
        url = $element.data('source'),
        type = $element.data('type') ? $element.data('type') : 'get';

    $.ajax({
      url : url,
      type: type,
      success:function(data){
        var $data = $(data) 
        $body.html($data)
        handleElements($data) 
      }
    })
    
    $modal_container.modal();
    e.preventDefault();
  })

  // Handle forms submit in modal window
  $("body").find('form[data-modal="form"]').submit(function(e){
    var $modal_container = $('#mainmodal'),
        $body = $modal_container.find('.modal-body'),
        $form = $(this),
        data = $form.serialize(),
        url = $form.attr("action"),
        type = $form.attr("method");

    $.ajax({
      url : url,
      type: type,
      data : data,
      success:function(data) 
      {
        var $data = $(data) 
        $body.html($data)
        handleElements($data)
      }
    });

    e.preventDefault();
  })

  // Handle photo preview in modal window
  $elem.find('a[data-preview ="modal"]').click(function(e){
    e.preventDefault();

    var $photo = $(this),
        $modal = $('#mainmodal'),
        $modal_content = $modal.find('.modal-body'),
        $img = $photo.find('img').clone();
    
    $modal_content.empty();
    $modal_content.append($img);
    $modal.modal();
  });

}
 