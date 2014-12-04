class WoodchuckDashboardCell < DashboardCell

  def show(args)
    super
    #fetch log metadata
    log_data = LogEntry.eager_graph(:log => :account).where(:account_id => current_user.run_state.current_account.id).
      where{log_entries__created_at >= 4.hours.ago.to_time}.group_and_count{
      date_trunc('hour', log_entries__created_at)
    }.order_by(:date_trunc).to_a
    @categories = log_data.map{|l| l[:date_trunc].strftime('%H:%M')}
    @logs = [log_data.map{|l| l[:count]}.unshift('data')]
    render
  end

end
