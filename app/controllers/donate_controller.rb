# frozen_string_literal: true

class DonateController < ApplicationController
  # Disabled because of tax thing.
  # Ask at Slack #core-team if it can be enabled.
  before_action :redirect_home
  helper_method :form, :locale
  layout 'devise'

  def show
    render locals: { form: DonateForm.new }
  end

  def create
    form = DonateForm.new(params[:donate_form].to_unsafe_hash)

    valid = form.valid?
    flash.now[:alert] = t('pages.donate.failure', locale: locale) unless valid

    render :show, locals: { form: form }
  end

  private

  def redirect_home
    redirect_to root_path
  end

  def locale
    # hardcoded for now
    :ua
  end
end
