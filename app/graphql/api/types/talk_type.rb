# frozen_string_literal: true

module Api
  module Types
    class TalkType < BaseType
      description 'Pivorak talk info'

      field :id,           ID,                'Talk ID',              null: false
      field :title,        String,            'Talk title',           null: false
      field :description,  String,            'Talk description',     null: false
      field :video_url,    String,            'Talk video url',       null: true
      field :slides_url,   String,            'Talk slides url',      null: true
      field :speaker,      Types::MemberType, 'Talk speaker profile', null: false
    end
  end
end
