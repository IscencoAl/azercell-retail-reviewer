$(document).ready(function(){

  $('select#user_role').change(function(){
    var $role = $(this),
        enable_dealer = $role.data('enable-dealer'),
        value = $role.find('option:selected').val()
        $dealer = $('select#user_dealer');

    if (enable_dealer == value)
      $dealer.prop('disabled', false)
    else
      $dealer.prop('disabled', true)
  })

});