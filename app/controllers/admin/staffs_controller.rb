class Admin::StaffsController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @staffs = Staff.page(params[:page])
  end

  def new
    @staff = Staff.new
    @menus = Menu.all
  end

  def create
    @staff = Staff.new staff_params
    if @staff.save
      rtn = []
      for i in params[:menu]
        rtn.push({:menu_id => i, :staff_id => @current_admin.id})
      end
      Staffmenuship.create(rtn)
      redirect_to action:'index'
    else
      @menus = Menu.all
      render 'new'
    end
  end

  def edit
    @staff = Staff.find params[:id]
    @menus = Menu.all
    mymenuObject = Staffmenuship.where(:staff_id => params[:id])
    @mymenus = []
    mymenuObject.each do |m|
     @mymenus.push(m.menu_id)
    end
  end

  def update
    if  Staff.find(params[:id]).update(staff_params)
      Staffmenuship.destroy_all(:staff_id => params[:id])
      rtn = []
      for i in params[:menu]
        rtn.push({:menu_id => i, :staff_id => @current_admin.id})
      end
      Staffmenuship.create(rtn)
      redirect_to action:'index'
    else
      @menus = Menu.all
      render edit_admin_staff_path
    end
  end

  def update_status
    @staff = Staff.find params[:id]
    if @staff.status == 0
      status = 1
    else
      status = 0
    end
    @staff.update_attribute(:status, status)
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  private
  def staff_params
    params.require(:staff).permit(:login, :name, :phone, :password, :password_confirmation)
  end

end
