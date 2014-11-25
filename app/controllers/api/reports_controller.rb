class Api::ReportsController < Api::ApiController

  # GET /reports/structure
  def structure
    begin
      @categories = ReportStructureCategory.all
    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

  # POST /reports
  def create
    begin
      treated_params = treat_report_params(params[:report])

      @report = Report.new(treated_params)
      unless @report.save
        raise Exception.new(@report.errors.full_messages.join('; '))
      end

    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

  # POST /reports/1/photo
  def photo
    begin
      params[:photo].each do |index, photo|
        @report_photo = ReportPhoto.new(
          { :report_id => params[:id], :photo => photo[:file], :comment => photo[:comment] }
        )

        unless @report_photo.save
          raise Exception.new(@report_photo.errors.full_messages.join('; '))
        end
      end

    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

  # Helper methods

  def treat_report_params(report_params)
    begin
      score = 0.0
      max_score = 0.0

      geoloc = report_params[:geolocation].split(' ')
      treated_params = {
        latitude: geoloc[0], longitude: geoloc[1],
        shop_id: report_params[:shop_id], user_id: current_user.id,
        created_at: Time.now,
        elements_attributes: []
      }

      report_params[:categories].each do |category|
        category[:elements].each do |element|
          treated_params[:elements_attributes] << {
            name: element[:name], value: element[:value], report_structure_category_id: category[:id],
            report_structure_element_type_id: ReportStructureElementType.find_by_name(element[:type]).id
          }

          element_mark = 0
          element_weight = element[:weight] ? element[:weight].to_i : 0
          case element[:type]
          when 'mark'
            element_mark = element[:value].to_i if element[:value]
          when 'check'
            element_mark = Report::MAX_SCORE if element[:value] == 'yes'
          else
            element_weight = 0
          end
          score += element_mark * element_weight
          max_score += Report::MAX_SCORE * element_weight
        end
      end

      treated_params[:score] = score / max_score * Report::MAX_SCORE

      return treated_params

    rescue Exception => ex
      raise Exception.new("Wrong report format: #{ex.message}")
    end
  end

end