# frozen_string_literal: true

module Admin
  class TalksController < BaseController
    helper_method :talk, :talks
    add_breadcrumb 'talks.plural', :admin_talks_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @talk = Talk.new
      render_form
    end

    def create
      @talk = Talk.new(talks_params)

      react_to Talk::Create.call(talk)
    end

    def update
      react_to Talk::Update.call(talk, talks_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_talk_path(talk)
    end

    def talk
      @talk ||= Talk.friendly.find(params[:id])
    end

    def talks
      @talks ||= search_against(Talk)
                 .includes(:tags, :event, :speaker, :group)
                 .page(params[:page]).sorted_by_date
    end

    def talks_params
      params.require(:talk).permit(
        :cover, :description, :event_id, :group_id,
        :title, :speaker_id, :video_url, :slides_url, :tag_list, :published
      )
    end
  end
end
