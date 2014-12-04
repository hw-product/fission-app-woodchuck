class WoodchuckDashboardCell < Cell::Rails

  def show(args)
    #fetch log metadata
    log_data = LogEntry.eager_graph(:log => :account).where(:account_id => 1).
      where{log_entries__created_at >= (1.day.ago)}.group_and_count{
      date_trunc('hour', log_entries__created_at)
    }.order_by(:date_trunc).to_a
    @logs = [log_data.map{|l| l[:date_trunc].strftime("%Y-%m-%d %H")}.unshift('x'), log_data.map{|l| l[:count]}.unshift('data')]
    render
  end

end
