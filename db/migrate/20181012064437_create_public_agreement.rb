# frozen_string_literal: true

class CreatePublicAgreement < ActiveRecord::Migration[5.2]
  def change
    Page.create(
      title: 'Публічний договір',
      url:   'public-agreement',
      body:  File.read('db/seed/pages/public_agreement.md')
    )
  end
end
