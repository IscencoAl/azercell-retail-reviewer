function PhotoUploader(){function e(){self.$progress.fadeTo(0,1)}function r(e,r){var s=$(r.result);o(s),handleElements(s),self.$progress.fadeTo(1e3,0,function(){self.$galery_wrapper.removeClass("hidden"),self.$galery.append(s)})}function s(e,r){var s=parseInt(r.loaded/r.total*100,10);self.$progress_bar.css("width",s+"%").html(s+"%")}function o(e){e.find("a[data-deletephoto]").click(function(e){e.preventDefault();var r=$(this),s=r.attr("href");$.ajax({url:s,type:"DELETE",success:function(){var e=r.closest(".photo");e.remove(),$.trim(self.$galery.html()).length||self.$galery_wrapper.addClass("hidden")}})})}self=this,this.$form=$("#photoupload"),this.$progress=$(".progress"),this.$progress.fadeTo(0,0),this.$progress_bar=this.$progress.find(".progress-bar"),this.$galery_wrapper=$(".galery-wrapper"),this.$galery=$(".galery"),this.$form.fileupload({start:e,progress:s,done:r}),o($("body"))}$(document).ready(function(){new PhotoUploader});