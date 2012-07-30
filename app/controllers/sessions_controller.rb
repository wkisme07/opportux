class SessionsController < Devise::SessionsController
  before_filter :select_layout
  layout false

  def new
    resource = build_resource
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource)) do |format|
      format.html{
        render :layout => @layout
      }
      format.js{
        @template = 'devise/sessions/new.html'
        render '/layouts/facebox-reprocess', :layout => false
      }
    end
  end

  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    respond_with(resource) do |format|
      format.html{ redirect_to after_sign_in_path_for(resource) }
      format.js{
        flash[:notice] = 'Sign in successfully'
        @redirect_url = after_sign_in_path_for(resource)
        render '/layouts/facebox-redirect'
      }
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    redirect_url = stored_location_for(scope)

    respond_to do |format|
      format.js do
        sign_in(scope, resource) unless warden.user(scope) == resource
        if redirect_url.present?
          redirect_url = "#{redirect_url}.js" unless redirect_url[-3..-1] == '.js'
          redirect_url += redirect_url.match(/\?/) ? '&' : '?'
          redirect_url += "after_authentication=true"
          redirect_to redirect_url
        else
          render(:update) do |page|
            @template = 'devise/sessions/new.html'
            page << render('/layouts/facebox-reprocess')
          end
        end
      end
      
      format.html { super }
    end
  end

  protected

    # select layout
    def select_layout
      @xhr = request.xhr? ? true : false
      @layout = request.xhr? || request.format == 'text/javascript' ? false : 'application'
    end
end
