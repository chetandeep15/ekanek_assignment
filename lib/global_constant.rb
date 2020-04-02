module GlobalConstant
  env_constants = YAML.load_file(Rails.root.to_s + '/config/constants.yml')['constants']

  APP_URL = env_constants['app']['url']
end