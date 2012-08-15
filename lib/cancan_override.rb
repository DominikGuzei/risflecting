module CancanOverride
  def current_ability
    @current_ability ||= Ability.new(current_intern_user)
  end
end
