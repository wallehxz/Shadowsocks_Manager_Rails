class WelcomeController < ApplicationController
  layout 'web'

  def index
  end

  def sync_amount
    List.all.map {|x| x.sync_used_bytes }
    render json:{code:200}
  end
end
