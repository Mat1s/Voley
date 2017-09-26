Rails.application.config.middleware.use OmniAuth::Builder do
    
    OAUTH_CREDENTIALS = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env]
    
    provider :facebook, OAUTH_CREDENTIALS[:facebook][:app_id], 
                          OAUTH_CREDENTIALS[:facebook][:app_secret]
 
    provider :vkontakte, OAUTH_CREDENTIALS[:vk][:api_id], 
                          OAUTH_CREDENTIALS[:vk][:api_secret]
                          
    provider :amazon, OAUTH_CREDENTIALS[:amazon][:api_id], 
                          OAUTH_CREDENTIALS[:amazon][:api_secret],
                          {
                              :scope => 'profile postal_code' # default scope
                          }
    provider :twitter, OAUTH_CREDENTIALS[:twitter][:api_id], 
                          OAUTH_CREDENTIALS[:twitter][:api_secret]
end