function ChartHelper(container_id){
  this.$container = $(container_id);
  this.$box = this.$container.parent();
  this.source = this.$container.data('source');
  this.params = this.$container.data('params');

  this.default_options = {
    titleTextStyle: { color: 'black', fontSize: 16 },

    fontSize: 10,
    fontName: "'Helvetica Neue', Helvetica, Arial, sans-serif",

    chartArea: {
      left: 60, top: 50, width: this.$container.width() - 120, height: this.$container.height() - 100
    }
  }

  this.drawChart(this.source, this.params);
}

ChartHelper.prototype.drawChart = function(){
  var self = this;

  $.ajax({
    url: self.source
    ,data: self.params
    ,beforeSend: function(){
      self.$container.empty().addClass("loading");
    }
    ,success: function(data){
      self.$container.removeClass("loading");
      self.renderChart(data);
    }
    ,dataType: 'json'
  })
}

ChartHelper.prototype.lineChart = function(data){
  var data_table = google.visualization.arrayToDataTable(data.table),
      chart = new google.visualization.LineChart(this.$container[0]);

  var options = $.extend(this.default_options, data.options,{
    pointSize: 5
  });

  chart.draw(data_table, options);
}

ChartHelper.prototype.columnChart = function(data){
  var data_table = google.visualization.arrayToDataTable(data.table),
      data_view = new google.visualization.DataView(data_table),
      chart = new google.visualization.ColumnChart(this.$container[0]);

  data_view.setColumns([0, 1, { calc: "stringify", sourceColumn: 1, type: "string", role: "annotation" }]);

  var options = $.extend(this.default_options, data.options);

  chart.draw(data_view, options);
}

ChartHelper.prototype.renderChart = function(data, position){
  switch (data["type"]){
    // [[<y_name>, <x_name>], [<y_val>, <x_val>], ...]
    // Ex.: [['Name', 'Quantity'], ['John Doe', 30], ['Jim Carey', 40]]
    case "line":
      this.lineChart(data, position);
    break;

    // [[<y_name>, <x_name>], [<y_val>, <x_val>], ...]
    // Ex.: [['Name', 'Quantity'], ['John Doe', 30], ['Jim Carey', 40]]
    case "column":
      this.columnChart(data, position);
    break;
    
    default : console.log("GraphType Error: Unsupported Graphtype:" + data.type);
  }
}