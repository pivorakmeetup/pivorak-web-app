# frozen_string_literal: true

class RenameVisitRequestEmailTemplate < ActiveRecord::Migration[5.0]
  def change
    template = EmailTemplate.find_by(title: 'VisitRequestMailer#unverified_attendee')
    template&.update(title: 'VisitRequestMailer#notify_admin_about_unverified_attendee')
  end
end
