class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
      #nameのストロングパラメーター
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      #プロフィール編集時にnameと自己紹介、アイコン画像のストロングパラメーター
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduce, :image_name])
    end
end
