class RegistrationsController < Devise::RegistrationsController
  before_filter :select_layout
  layout false

  # GET /resource/sign_up
  def new
    resource = build_resource({})
    respond_with(resource) do |format|
      format.html{ render :layout => @layout }
      format.js{
        render :layout => false
      }
    end
  end

  # POST /resource
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with(resource) do |format|
          format.html{ redirect_to after_sign_up_path_for(resource) }
          format.js{
            @redirect_url = root_path
            render '/layouts/facebox-redirect'
          }
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with(resource) do |format|
          format.html{ redirect_to after_inactive_sign_up_path_for(resource) }
          format.js{
            @redirect_url = root_path
            render '/layouts/facebox-redirect'
          }
       end
      end
    else
      clean_up_passwords resource
      flash.now[:error] = resource.errors.full_messages.try(:join, '<br />')
      respond_with(resource) do |format|
        format.html
        format.js{
          @template = 'devise/registrations/new.html'
          render '/layouts/facebox-reprocess', :layout => false
        }
      end
    end
  end

  def cancel
    expire_session_data_after_sign_in!
    redirect_to root_path || new_registration_path(resource_name)
  end

  protected

    # select layout
    def select_layout
      @xhr = request.xhr? ? true : false
      @layout = request.xhr? || request.format == 'text/javascript' ? false : 'application'
    end
end
