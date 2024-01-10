class ApplicationController < ActionController::Base
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    around_action :switch_locale

    private

    # app/controllers/application_controller.rb
    def default_url_options
        { locale: I18n.locale }
    end
  

    def switch_locale(&action)
        locale = params[:locale] || I18n.default_locale
        I18n.with_locale(locale, &action)
    end

    def user_not_authorized(exception) #aula 26 8min
        policy_name = exception.policy.class.to_s.underscore
     
        flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
        redirect_back(fallback_location: root_path)
    end
end
