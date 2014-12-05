$(document).ready(function(){

  $('a[data-newcategory]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        url = $btn.attr('href');

    $.ajax({
      url: url,
      success: function(data){
        var $data = $(data);

        $('#report-structure').append($data);
        handleReportElements($data);
      }
    });
  });

  $.ajax({
    url: '/settings/review_associated_shops',
    success: function(data){
      var setting = data;

      if (setting.value == 'yes'){
        $('#review-associated-shops').prop('checked', true);
      }

      $('#review-associated-shops').change(function(){
        var $checkbox = $(this),
          checked = $checkbox.is(":checked"),
          value = checked ? 'yes' : 'no';

        $.ajax({
          url: '/settings/review_associated_shops',
          type: 'PUT',
          data: {value: value}
        });
      });
    }
  });

  handleReportElements($('body'));

});

function handleReportElements($elem){

  handleElements($elem);

  $elem.find('a[data-savecategory]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $form = $btn.closest('form'),
        url = $form.attr('action'),
        type = $form.attr('method');

    $.ajax({
      url: url,
      type: type,
      data: $form.serialize(),
      success: function(data){
        var $data = $(data);
        $form.replaceWith($data);
        handleReportElements($data);
      }
    })
  });

  $elem.find('a[data-showcategory]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $form = $btn.closest('form'),
        url = $btn.attr('href');

    if (url == ""){
      $btn.closest('.category-container').remove();
    }else{
      $.ajax({
        url: url,
        success: function(data){
          var $data = $(data);
          $form.replaceWith($data);
          handleReportElements($data);
        }
      })
    }
  })

  $elem.find('a[data-editcategory]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $elem = $btn.closest('.category-header'),
        url = $btn.attr('href');

    $.ajax({
      url: url,
      success: function(data){
        var $data = $(data);
        $elem.html($data);
        handleReportElements($data);
      }
    })
  })

  $elem.find('a[data-deletecategory]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $elem = $btn.closest('.category-container'),
        url = $btn.attr('href'),
        confirmation = $btn.data('confirmation');

    confirm_delete = confirmation ? confirm(confirmation) : true;

    if (confirm_delete){
      $.ajax({
        url: url,
        type: 'delete',
        success: function(){
          $elem.remove();
        }
      })
    }
  })

  $elem.find('a[data-newelement]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $elem = $btn.closest('.category-container').find('.element-list'),
        url = $btn.attr('href');

    $.ajax({
      url: url,
      success: function(data){
        var $data = $(data)
        $elem.append($data);
        handleReportElements($data);
      }
    })
  })

  $elem.find('a[data-editelement]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $elem = $btn.closest('.element'),
        url = $btn.attr('href');

    $.ajax({
      url: url,
      success: function(data){
        var $data = $(data);
        $elem.replaceWith($data);
        handleReportElements($data);
      }
    })
  })

  $elem.find('a[data-saveelement]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $form = $btn.closest('form'),
        $elem = $btn.closest('.element'),
        url = $form.attr('action'),
        type = $form.attr('method');

    $.ajax({
      url: url,
      type: type,
      data: $form.serialize(),
      success: function(data){
        var $data = $(data);
        $elem.replaceWith($data);
        handleReportElements($data);
      }
    })
  })

  $elem.find('a[data-showelement]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $form = $btn.closest('form'),
        $elem = $btn.closest('.element'),
        url = $btn.attr('href');

    if (url == ""){
      $elem.remove();
    }else{
      $.ajax({
        url: url,
        success: function(data){
          var $data = $(data);
          $elem.replaceWith($data);
          handleReportElements($data);
        }
      })
    }
  })

  $elem.find('a[data-deleteelement]').click(function(e){
    e.preventDefault();

    var $btn = $(this),
        $elem = $btn.closest('.element'),
        url = $btn.attr('href'),
        confirmation = $btn.data('confirmation');

    confirm_delete = confirmation ? confirm(confirmation) : true;

    if (confirm_delete){
      $.ajax({
        url: url,
        type: 'delete',
        success: function(){
          $elem.remove();
        }
      })
    }
  })

  // report_structure_element[shop_types]
  $elem.find('.shoptypes-control').on('click', 'a.btn', function(e){
    var $btn = $(this),
        $input = $btn.siblings('input'),
        value = $input.val(),
        abbr = $btn.attr('href'),
        active = $btn.hasClass('active');

    value = active ? value.replace(abbr, '') : value + abbr;

    $input.val(value);
  })

}