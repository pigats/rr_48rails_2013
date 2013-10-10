require 'mechanize'
require 'open-uri'

agent = Mechanize.new

# # Homepage, do login
# page = agent.get('https://facebook.com/')
# form = page.form_with(id: 'login_form')
# form.email = 'mailz'
# form.pass = 'pwdz'
# page = form.submit
# if page.body.include?('Accedi a Facebook')
#   puts 'Invalid username or password!'
#   exit
# end

# Get album page
page = agent.get('https://www.facebook.com/media/set/?set=oa.233021253493147')
links = page.body.scan(/(https:\/\/www\.facebook\.com\/photo\.php\?fbid=.*?\.jpg)/).map{|m| m[0].to_s.gsub(/type=\d&amp;/, '')}.uniq

# Downlaod images and gen thumbs
outdir = '48rails2012'
thumbs_dir = File.join(outdir, 'thumbs')
Dir.mkdir(outdir) unless File.exist?(outdir)
Dir.mkdir(thumbs_dir) unless File.exist?(thumbs_dir)
links.each_with_index do |link, i|
  page = agent.get(link)
  page.body.scan(/(https:\/\/fbcdn-sphotos.*?s720x720.*?\.jpg)/).each do |m|
    File.open(File.join(outdir, "#{i}.jpg"), 'w') do |f|
      open(m[0]) { |stream| f << stream.read }
    end
    `convert '#{File.join(outdir, "#{i}.jpg")}' -background none -resize 80x80 -gravity center -extent 80x80 -format png '#{File.join(thumbs_dir, "#{i}.png")}'`
    break
  end
end

# Fuckup API