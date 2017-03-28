module Slackistrano
  class CustomMessaging < Messaging::Base
    def payload_for_updating
      {
        attachments: [{
          color: 'warning',
          title: 'Deploy starting.',
          fields: [{
            title: 'Project',
            value: app_name,
            short: true
          }, {
            title: 'Environment',
            value: stage,
            short: true
          }, {
            title: 'Deployer',
            value: deployer,
            short: true
          }, {
            title: 'Branch',
            value: branch,
            short: true
          }, {
            title: 'Commit',
            value: last_commit,
            short: true
          }],
          fallback: super[:text]
        }]
      }
    end

    def payload_for_updated
      {
        attachments: [{
          color: 'good',
          title: 'Deploy successfuly finished.',
          fields: [{
            title: 'Project',
            value: app_name,
            short: true
          }, {
            title: 'Environment',
            value: stage,
            short: true
          }, {
            title: 'Deployer',
            value: deployer,
            short: true
          }, {
            title: 'Branch',
            value: branch,
            short: true
          }, {
            title: 'Commit',
            value: last_commit,
            short: true
          }, {
            title: 'Time',
            value: elapsed_time,
            short: true
          }],
          fallback: super[:text]
        }]
      }
    end

    def payload_for_failed
      payload = super
      payload[:text] = "OMG :fire: #{payload[:text]}"
      payload
    end

    def last_commit
      @last_commit ||= `git rev-parse origin/#{branch}`.strip.slice(0, 20)
    end

    def app_name
      @app_name ||= application.split('_').first
    end
  end
end
