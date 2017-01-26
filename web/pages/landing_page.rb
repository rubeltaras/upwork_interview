class LandingPage < Howitzer::Web::Page
  path '/'

  validate :title, /^Upwork - Hire Freelancers & Get Freelance Jobs Online$/
  validate :url, /^https?:\/\/[^\/]+\/?$/

  section :header
end