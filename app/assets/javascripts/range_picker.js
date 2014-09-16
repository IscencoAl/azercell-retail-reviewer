function RangePicker($control, $from, $to){
  self = this;

  this.initial_value = 0;
  this.$initial_btn = $control.find('span.btn[data-value="0"]');

  this.from = 0;
  this.to = 0;

  $control.find('span.btn').mousedown(function(){
    var $btn = $(this),
        value = $btn.data('value');

    $control.find('span.btn.active').removeClass('active');
    $btn.addClass('active');
    
    self.$initial_btn = $btn;
    self.initial_value = value;

    $from.val(value);
    this.from = value;

    $to.val(value);
    this.to = value;

    $control.find('span.btn').bind('mouseenter', function(){
      var $btn = $(this),
          value = $btn.data('value');

      $control.find('span.btn.active').removeClass('active');

      if (value > self.initial_value){
        self.$initial_btn.nextUntil($btn).andSelf().addClass('active');
        $from.val(self.initial_value);
        $to.val(value);
      }
      else if (value < self.initial_value){
        self.$initial_btn.prevUntil($btn).andSelf().addClass('active');
        $from.val(value);
        $to.val(self.initial_value);
      }
      else{
        $from.val(value);
        $to.val(value); 
      }

      $btn.addClass('active');
    })
  })

  $(document).mouseup(function(){
    $control.find('span.btn').unbind('mouseenter');
  })

}