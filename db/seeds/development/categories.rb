puts "Generating Categories & Subjects..."


subjects = [
  "reit-investment",
  "the-indicator-master",
  "fibonacci-trading-price-time-analysis",
  "google-adwords-for-business",
  "CEO-guide-to-digital-marketing",
  "Social-Media-Marketing-101",
  "web-programming-for-beginner",
  "html5-css3-13hours",
  "laravel-4-tutorial"
]
s_index = 0
["finance-investment", "marketing", "computer"].each_with_index do |name, index|
  category = Category.create(name: name.underscore.humanize)
  (s_index..s_index+2).each do |i|
    subject = Subject.new(name: subjects[i].underscore.humanize)
    category.add_subject(subject)
    s_index+=1
  end
end
