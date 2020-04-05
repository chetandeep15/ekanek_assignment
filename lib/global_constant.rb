module GlobalConstant
  if Rails.env.production?
    env_constants = YAML.load_file(Rails.root.to_s + '/config/prod_constants.yml')['constants']
  else
    env_constants = YAML.load_file(Rails.root.to_s + '/config/constants.yml')['constants']
  end


  APP_URL = env_constants['app']['url']
end