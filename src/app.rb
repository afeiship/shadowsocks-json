require "json"
require "uri"
require "net/http"
require 'nokogiri'
require "logger"


# 输出到指定文件
logger = Logger.new("/Users/feizheng/github/shadowsocks-json/logs/export.log")
logger.level = Logger::INFO
logger.datetime_format = "%Y-%m-%d %H:%M:%S"


uri = URI('https://d.ishadowx.com/')

# http:
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

# request:
req = Net::HTTP::Get.new(uri)

# template export:
template_export = JSON.parse File.read(__dir__ + '/export_tmpl.json')
template_ss_config = JSON.parse File.read(__dir__ + '/ss_config.json')
config_item = JSON.parse File.read(__dir__ + '/config.json')

info_list = ['server', 'server_port', 'password', 'method']
configs = []

# send request:
res = http.request(req)
doc = Nokogiri::HTML(res.body)


doc.css('.portfolio-item').each do |item|
  config = config_item.clone
  item.css('.hover-text h4').each_with_index do |item2, index|
    matched = item2.text.strip.split(":")[1]
    unless matched.nil?
      key = info_list[index]
      config[key] = matched
    end
  end
  configs << config
end


template_export['configs'] = configs
template_ss_config.merge!(configs.first)

# Save
File.write('./export.json',JSON.pretty_generate(template_export))
File.write('./ss-local.config.json',JSON.pretty_generate(template_ss_config))

logger.info configs.size
