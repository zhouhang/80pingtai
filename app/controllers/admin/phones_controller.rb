class Admin::PhonesController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    if params[:phone]
      @phones = Phone.where("DATE(created_at) >= ? and DATE(created_at) <= ?",params[:phone][:start],
                            params[:phone][:end]).page(params[:page])
    else
      @phones = Phone.page(params[:page])
    end
    #@charges = Charge.page(params[:page])
  end

  def query

  end

  def getByCondition

    if params[:condition] == 'user'
      @phones = ActiveRecord::Base.connection.select_rows("select u.name,count(t.id) count,sum(total) total,unix_timestamp(t.updated_at) -unix_timestamp(t.created_at)/count(t.id) avg,sum(case when t.status='completed' then t.total end) s_total,sum(case when t.status='completed' then 1 end) s_count,sum(case when t.status='failed' then t.total end) f_total,sum(case when t.status='failed' then 1 end) s_count from users u join transactions t on u.id = t.user_id")
      render 'user'
    elsif params[:condition] == 'workid'
      @phones = ActiveRecord::Base.connection.select_rows("select w.name,count(t.id) count,sum(total) total,unix_timestamp(t.updated_at) -unix_timestamp(t.created_at)/count(t.id) avg,sum(case when t.status='completed' then t.total end) s_total,sum(case when t.status='completed' then 1 end) s_count,sum(case when t.status='failed' then t.total end) f_total,sum(case when t.status='failed' then 1 end) s_count from workids w join transactions t on w.id = t.workid_id")
      render 'workid'
    elsif params[:condition] == 'channel'
      @phones = ActiveRecord::Base.connection.select_rows("select c.name,count(t.id) count,sum(total) total,unix_timestamp(t.updated_at) -unix_timestamp(t.created_at)/count(t.id) avg,sum(case when t.status='completed' then t.total end) s_total,sum(case when t.status='completed' then 1 end) s_count,sum(case when t.status='failed' then t.total end) f_total,sum(case when t.status='failed' then 1 end) s_count from channels c join transactions t on c.id = t.channel_id")
      render 'channel'
    end
  end
end