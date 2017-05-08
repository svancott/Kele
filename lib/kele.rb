require 'httparty'
require_relative 'roadmap.rb'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    base_url = 'https://www.bloc.io/api/v1'
    response = self.class.post('https://www.bloc.io/api/v1/sessions', body: {email: email, password: password})
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
    @my_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

  def get_messages
    response = self.class.get("https://www.bloc.io/api/v1/message_threads", headers: {"authorization" => @auth_token })
    @messages = JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, message)
    response = self.class.post("https://www.bloc.io/api/v1/messages", body: { "recipient_id": recipient_id, "subject": subject, "stripped-text": message }, headers: { "authorization" => @auth_token })
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", body: { "checkpoint_id": checkpoint_id, "assignment_branch": assignment_branch, "assignment_commit_link": assignment_commit_link, "comment": comment, "enrollment_id": 24628 }, headers: { "authorization" => @auth_token })
  end
end
