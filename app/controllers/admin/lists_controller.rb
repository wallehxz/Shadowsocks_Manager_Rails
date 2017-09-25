class Admin::ListsController < Admin::BaseController
  before_action :set_list, only:[:edit, :update, :destroy]

  def index
    @lists = List.ports.paginate(page:params[:page])
  end

  def new
    @list = List.new
    @list.total_bytes = 1 * 1024**3
    @list.used_bytes = 0
  end

  def create
    params[:list][:total_bytes] = List.size_to_number(params[:list][:total_bytes]) if params[:list][:total_bytes]
    @list = List.new(list_params)
    if @list.save
      redirect_to admin_lists_path, notice: '端口密码添加成功'
    else
      flash[:warn] = "#{params[:list][:server_port]}端口已经存在,请重新填写"
      render :new
    end
  end

  def edit
  end

  def update
    params[:list][:total_bytes] = List.size_to_number(params[:list][:total_bytes]) if params[:list][:total_bytes]
    if @list.update(list_params)
      redirect_to admin_lists_path, notice: '端口密码更新成功'
    else
      flash[:warn] = "#{params[:list][:server_port]}端口已经存在,请重新填写"
      render :edit
    end
  end

  def destroy
    @list.destroy
    flash[:notice] = "端口密码删除成功"
    redirect_to :back
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:label, :password, :server_port, :total_bytes, :used_bytes)
    end
end
