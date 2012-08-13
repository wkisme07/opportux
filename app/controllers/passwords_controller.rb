class PasswordsController < Devise::PasswordsController
  before_filter :select_layout

  # GET /resource/password/new
  def new
    build_resource({})
    render :layout => @layout
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      respond_with({}) do |format|
        flash.now[:notice] = "Email instruction has been sent to your email."

        format.html{ redirect_to after_sending_reset_password_instructions_path_for(resource_name) }
        format.js{
          @xhr = true
          @temp = 'devise/sessions/new.html'
          render '/layouts/facebox-reprocess', :layout => false
        }
      end
    else
      flash.now[:alert] = resource.errors.try(:full_messages).try(:join, '<br />')

      respond_with(resource) do |format|
        format.html{}
        format.js{
          @xhr = true
          @temp = 'devise/passwords/new.html'
          render '/layouts/facebox-reprocess', :layout => false
        }
      end
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      flash.now[:notice] = flash_message if is_navigational_format?

      sign_in(resource_name, resource)
      respond_with(resource) do |format|
        format.html{ redirect_to after_sign_in_path_for(resource) }
        format.js{
          @redirect_url = after_sign_in_path_for(resource)
          render '/layouts/facebox-redirect', :layout => false
        }
      end
    else
      flash.now[:alert] = resource.errors.try(:full_messages).try(:join, '<br />')
      respond_with(resource) do |format|
        format.html{}
        format.js
      end
    end
  end

  protected

    # select layout
    def select_layout
      @layout = request.xhr? || request.format == 'text/javascript' ? false : 'application'
    end
end
