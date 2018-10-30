class DonateController < ApplicationController
  helper_method :form, :locale
  layout 'devise'

  def show
    render locals: {form: DonateForm.new}
  end

  def create
    form = DonateForm.new(params[:donate_form].to_unsafe_hash)

    valid = form.valid?
    flash.now[:alert] = t('pages.donate.failure', locale: locale) unless valid

    render :show, locals: {form: form}
  end

  private

  def locale
    # hardcoded for now
    :ua
  end
end
