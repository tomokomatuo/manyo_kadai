module TasksHelper
  def button_text
    if action_name == "new"
      t('helpers.submit.create')
    elsif action_name == "edit"
      t('helpers.submit.update')
    end
  end
end
