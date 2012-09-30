class AppMailer < ActionMailer::Base
  include Resque::Mailer
  layout 'email'

  add_template_helper(ApplicationHelper)
  default from: "no-reply@opportux.com"

  def send_advertise_invoice(adv_id, viewed, amount)
    prepare_advertise(adv_id)
    @viewed = viewed
    @amount = amount
    mail(
      to: @adv.contact_email,
      subject: "[opportux] Advertise Invoice (#{@today.strftime('%Y-%m')})"
    )
  end

  private

    def prepare_advertise(adv_id)
      @today = Date.today
      @adv = Advertise.find(adv_id)
    end
end
