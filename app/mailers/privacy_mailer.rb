class PrivacyMailer < ActionMailer::Base
  default from: "no-reply@thesurveys.org"

  def deactivation_mail(organization, users)
    @organization_name = organization.name
    headers({ 'X-SMTPAPI' => { "category" => EY::Config.get('base', 'domain_name') } })
    mail(:bcc => users.map(&:email),
         :subject => I18n.t("privacy_mailer.deactivation_mail.subject", :organization_name => @organization_name))
  end
end
