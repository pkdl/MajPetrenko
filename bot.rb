#coding: utf-8
 
require "cinch"
require 'cinch/plugins/login'
require "pry"
require "geoip"

bot = Cinch::Bot.new do
  configure do |c|
	  c.server = "irc.freenode.org"
    c.channels = ["#s2ch"]
    c.port = 7000
    c.ssl.use = true
    c.nick = "Maj_Petrenko"	
    c.user = "FSB"
    c.realname = "Petrenko"
    c.plugins.plugins = [Cinch::Plugins::Login]
    password = File.read("password")
    c.plugins.options[Cinch::Plugins::Login] = { :password => password }
  end
	
	answer = Array.new
	File.open("because.txt", "r") do |f|
		f.each_line do |line|
		  answer << line
		end	
	end
	
	snail = Array.new
	File.open("snail.txt", "r") do |f|
		f.each_line do |line|
		  snail << line
		end	
	end
	
	limericks = Array.new
	limerick = Array.new
	File.open("limericks.txt", "r") do |f|
		f.each_line do |line|
		  if line.include? "---"
		    limericks << limerick
		    limerick = Array.new
		  else
		    limerick << line
		  end
		end	
	end
	
	on :message, /((\b|[^а-я])ц​*п(\b|[^а-я]))|((\b|[^а-я])цоп[еэ](\b|[^а-я]))|(\bi2p\b)|(\btor\b)|(\bспайс)|(наркотик(и|ами*|ов))|(веществ)|(\bтрав(а|ка|ы|у|е|ой)\b)|(\bкосяк)|(\bамф)|(\bспид(ы|ов|ами|ах))/i do |m|
    return if m.user.to_s == "arrowdodger"
    case m.user.to_s
      when "Skoroxod32"
        m.reply("#{m.user.to_s}, взял вас за карандаш")
      else
        if m.user.realname == " :(){ :|:& };:"
          m.reply("#{m.user.to_s}, взял вас за анус")
        else
          m.reply("#{m.user.to_s}, взял вас на карандаш")
        end
    end  
  end 
  
  on :message, /де[ц,т]*(и|ей|ям|ок|очек|с*к(ое|ий|ай))|д[и,е]тя|\bлол(и|ей|я(ми)*|ю)\b/i do |m|
    return if m.user.to_s == "arrowdodger"
    if /порн|прон|пор[е,и]во|секс|трах|еб(у|ать|[е,ё]т)|дроч|фап|минет|сос(ать|[е,ё]т)|анал|анус/i.match m.message()
      case m.user.to_s
      when "Skoroxod32"
        m.reply("#{m.user.to_s}, взял вас за карандаш")
      else
        if m.user.realname == " :(){ :|:& };:"
          m.reply("#{m.user.to_s}, взял вас за анус")
        else
          m.reply("#{m.user.to_s}, взял вас на карандаш")
        end
      end
    end  
  end
	
	on :message, /пойду|ушел|нака(чу|тил|тыва(ет|ю))/i do |m|
	  return if m.user.to_s == "arrowdodger"
	  if /пойду|ушел/i.match m.message()
      
      if /нака(чу|тил|тить|тыва(ет|ю|ть))/i.match m.message()
	      m.reply("#{m.user.to_s}, заходите к нам в отдел, вместе накатим")
	    else
	      
	      if /спать|сплю/i.match m.message()
	        m.reply("#{m.user.to_s}, спокойной ночи")
	      else
	        return
          #m.reply("#{m.user.to_s}, заходите к нам в отдел, поговорим")
        end
        
      end
      
    else
  	  m.action_reply("накатил вместе с #{m.user.to_s}")
    end
      
  end
  
  on :action, /доложил/i do |m|
    return if m.user.to_s == "arrowdodger"
    m.action_reply("#{m.user.to_s}, вот когда убьют, тогда и докладывайте")
  end
 
  on :message, /\A>>/ do |m|
    if (m.user.to_s == "tkdl" || m.user.to_s == "tkdlc") && !m.channel?
      bot.Channel(bot.channels[0]).send(m.message[2..-1])
    end
  end
  
  on :message, /\Aact>>/ do |m|
    if (m.user.to_s == "tkdl" || m.user.to_s == "tkdlc") && !m.channel?
      bot.Channel(bot.channels[0]).action(m.message[5..-1])
    end
  end
	
	#on :message, /Товарищ майор, почему (.+)\?/ do |m|
	on :message, /Майор, почему/i do |m|
	  if !(m.message.include? "Sosnitsky") && m.user.to_s != "Sosnitsky"
		  m.reply("Потому что " + answer[rand(0..(answer.size - 1))])
	  end
	end
	
	on :message, /почему/i do |m|
	  if !(m.message.include? "Sosnitsky") && m.user.to_s != "Sosnitsky" && rand(100) < 15
		  m.reply("Потому что " + answer[rand(0..(answer.size - 1))])
	  end
	end
	
	on :message, /Майор, улиточку!/i do |m|
	  return if m.user.to_s == "jaki"
	  if !(m.message.include? "Sosnitsky") && m.user.to_s != "Sosnitsky"
		  snail.each{ |x| m.reply(x) }
	  end
	end
	
	on :message, /майор, найди /i do |m|
   # binding.pry
      
      
      whatToFind = m.message[13..-1].strip
      
      if whatToFind == "anon404"
        m.reply("Анон не найден")
        return
      end
      
      user = m.target.bot.user_list.find(whatToFind)
      if user
        if user.host.include?("kiwiirc")
          host = user.host[35..-1]
        elsif user.host.include?("unaffiliated")
          m.reply("Спрятался под unaffiliated")
          return
        else
          host = user.host
        end
      else
        host = whatToFind
      end
      
      c = GeoIP.new('GeoLiteCity_wintooshock.dat').city(host)
      c1 = GeoIP.new('GeoLiteCity.dat').city(host)
      
      if c.city_name.empty?
        city_name = c1.city_name
      else
        city_name = c.city_name
      end
      if city_name.empty?
        if c.country_name.empty?
          m.reply("Не нашел")
        else
          m.reply("Нашел - #{c.country_name}, #{c.latitude}, #{c.longitude}")
        end  
      else
        m.reply("Нашел - #{city_name}")
      end   
	end
	
	on :message, /майор, частушку/i do |m|
	  #binding.pry
	  limericks[rand(limericks.size)].each { |l| m.reply(l) }
	end
	
	on :message, /мы лё*д/i do |m|
	  m.reply("под ногами майора!")
	end
	
	
#binding.pry
	
	
	
end
 

bot.start
