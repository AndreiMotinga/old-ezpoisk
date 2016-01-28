class RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "Если Вы человек, пожалуйста поставьте галочу в графе \"I'm not a robot\". Если же ты бездушная машина - 01000110010000010100001101001011 010011110100011001000110... Ваше восстание перенесли на 2049-й"
      flash.delete :recaptcha_error
      render :new
    end
  end
end
