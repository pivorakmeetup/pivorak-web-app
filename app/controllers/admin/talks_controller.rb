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

      respond_for talk.save
    end

    def update
      respond_for talk.update(talks_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_talk_path(talk)
    end

    def talk
      @talk ||= Talk.friendly.find(params[:id])
    end

    def talks
      @talks ||= Talk.includes(:event, :speaker, :group, :taggings)
    end

    def talks_params
      params.require(:talk).permit(
        :title, :description, :event_id, :speaker_id,
        :video_url, :slides_url, :group_id, :tag_list, :published
      )
    end
  end
end
