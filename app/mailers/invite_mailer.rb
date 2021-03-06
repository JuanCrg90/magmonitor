# frozen_string_literal: true

class InviteMailer < ApplicationMailer
  default from: 'magmonitor@magmalabs.io'

  def create_invite(invite, url)
    @invite = invite
    @url = url
    mail(to: @invite.email, subject: 'Invitation')
  end
end
