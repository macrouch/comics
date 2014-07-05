namespace :subscriptions do
  task :check => :environment do
		Subscription.pull_subscriptions
	end
end
