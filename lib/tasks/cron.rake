task cron: :environment do
  TNW::Google.update_token!
end
