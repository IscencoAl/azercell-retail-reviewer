# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += 
  %w(
    photo_uploader.js range_picker.js chart_helper.js user_form.js
    report_structure.js report_structure.css
    jquery.fileupload.js jquery.fileupload-ui.css
    maps/shop_edit.js maps/dealer_show.js maps/shop_show.js maps/report_show.js
    shops.css
    chart_helper.js
  )
