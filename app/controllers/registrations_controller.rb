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

  # GET /resource/edit
  def edit
    render :edit, :layout => @layout
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(resource_params)
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      flash.now[:alert] = resource.errors.try(:full_messages).try(:join, '<br />')
      respond_with(resource) do |format|
        format.html{ render :edit, :layout => @layout }
        format.js{
          @template = 'devise/registrations/new.html'
          render '/layouts/facebox-reprocess', :layout => false
        }
      end

    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
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
