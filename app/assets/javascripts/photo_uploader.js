function PhotoUploader(){
  self = this;

  // To upload photos there is neccessary to make a form with id "photoupload".
  // This form must contain all necessary inputs to create object (not only type="file").
  this.$form = $('#photoupload');

  // Form can contain progress bar to reflect image upload progress.
  this.$progress = $('.progress');
  this.$progress.fadeTo(0, 0);
  this.$progress_bar = this.$progress.find('.progress-bar');

  // Also there can be a photo galery.
  this.$galery_wrapper = $('.galery-wrapper')
  this.$galery = $('.galery');

  this.$form.fileupload({
    start: uploadStart,
    progress: uploadProgress,
    done: uploadEnd
  });

  handlePhotoControls($('body'));

  function uploadStart(e){
    self.$progress.fadeTo(0, 1);
  }

  function uploadEnd(e, data){
    var $photo = $(data.result);

    handlePhotoControls($photo);

    self.$progress.fadeTo(1000, 0, function(){
      self.$galery_wrapper.removeClass('hidden');
      self.$galery.append($photo);
    });
  }

  function uploadProgress(e, data){
    var progress = parseInt(data.loaded / data.total * 100, 10);

    self.$progress_bar.css('width', progress + '%').html(progress + '%');
  }

  function handlePhotoControls($elem){
    // Controls to delete photo must containt attribute "data-deletephoto" and
    // link to delete in "href" attribute.
    $elem.find('a[data-deletephoto]').click(function(e){
      e.preventDefault();

      var $btn = $(this),
          delete_link = $btn.attr('href');

      $.ajax({
        url: delete_link,
        type: 'DELETE',
        success: function(data){
          var $photo = $btn.closest('.photo');

          $photo.remove();

          if (!$.trim(self.$galery.html()).length)
            self.$galery_wrapper.addClass('hidden');
        }
      })
    });

    $elem.find('a.thumbnail').click(function(e){
      e.preventDefault();

      var $photo = $(this),
          $modal = $('#mainmodal'),
          $modal_content = $modal.find('.modal-body'),
          $img = $photo.find('img').clone();
          console.log($photo)
    

      $modal.modal();
    });
  }
}

$(document).ready(function(){
  var pu = new PhotoUploader();
});