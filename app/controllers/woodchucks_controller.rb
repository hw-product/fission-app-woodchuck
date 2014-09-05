class WoodchucksController < ApplicationController

  before_filter :setup
  before_filter :apply_filter
  before_filter :format_data

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def apply_filter
    if(@log)
      @entries = LogEntry.where(:log_id => @log.id)
    else
      @entries = LogEntry.where(:log_id => @logs.map(&:id))
    end
    if(params[:search])
      if(terms = params[:search][:terms])
        @current_terms = terms
        @entries = @entries.full_text_search(:entry, terms)
      end
    end
    @entries = @entries.order(:entry_time.desc)
  end

  def format_data
    @logs = {}.tap do |logs|
      @logs.each do |log|
        logs[log.source] ||= []
        logs[log.source].push(log)
      end
    end
    @entries = {}.tap do |entries|
      @paged_entries = @entries.paginate(params.fetch(:page, 1).to_i, 10)
      @paged_entries.each do |entry|
        time = Time.at(entry.entry_time)
        date = time.strftime('%Y-%m-%d')
        entries[date] ||= []
        entries[date] << entry
      end
    end
  end

  def setup
    if(params[:account_id])
      @account = current_user.accounts.detect{|a| a.id == params[:account_id].to_i}
    else
      @account = current_user.accounts.first
    end
    @logs = @account.logs_dataset
    if(params[:id])
      @log = @logs.where(:id => params[:id]).first
    end
  end

end
