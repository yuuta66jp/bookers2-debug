class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception

  protected
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :postcode, :prefecture_code, :address_city, :address_street, :latitude, :longitude])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end
    def correct_user?(user)
      if current_user.nil?
        return false
      else
        user.id.equal?(current_user.id)
      end
    end
end
