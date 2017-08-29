class Admin::ShadowSocksController < Admin::BaseController
  before_action :set_sock, only:[:edit, :update, :destroy]

  def index
    @socks = ShadowSock.all
  end

  def new
    @sock = ShadowSock.new
  end

  def create
    @sock = ShadowSock.new(shadow_sock_params)
    if @sock.save
      redirect_to admin_shadow_socks_path, notice: '新配置添加成功'
    else
      flash[:warn] = "请完善表单信息"
      render :new
    end
  end


  def edit
  end

  def update
    if @sock.update(shadow_sock_params)
      redirect_to admin_shadow_socks_path, notice: '基础配置更新成功'
    else
      flash[:warn] = "请完善表单信息"
      render :edit
    end
  end

  def destroy
    @sock.destroy
    flash[:notice] = "配置删除成功"
    redirect_to :back
  end

  private
    def set_sock
      @sock = ShadowSock.find(params[:id])
    end

    def shadow_sock_params
      params.require(:shadow_sock).permit(:local_path,:server,:timeout,:method,:fast_open,:workers)
    end
end
