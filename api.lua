local URL = require "socket.url"
local https = require "ssl.https"
local serpent = require "serpent"
local json = (loadfile "/home/Logan/INLINE/JSON.lua")()
local token = '386343615:AAEdTNZP025yDWqUhBAdb7vW9oHVCLewdSk' --token
local url = 'https://api.telegram.org/bot' .. token
local offset = 0
local redis = require('redis')
local redis = redis.connect('127.0.0.1', 6379)
local SUDO = 261764158
function is_mod(chat,user)
sudo = {261764158}
  local var = false
  for v,_user in pairs(sudo) do
    if _user == user then
      var = true
    end
  end
 local hash = redis:sismember(SUDO..'owners:'..chat,user)
 if hash then
 var = true
 end
  local hash = redis:sismember(SUDO..'helpsudo:',user)
 if hash then
 var = true
 end
 local hash2 = redis:sismember(SUDO..'mods:'..chat,user)
 if hash2 then
 var = true
 end
 return var
 end
local function getUpdates()
  local response = {}
  local success, code, headers, status  = https.request{
    url = url .. '/getUpdates?timeout=20&limit=1&offset=' .. offset,
    method = "POST",
    sink = ltn12.sink.table(response),
  }

  local body = table.concat(response or {"no response"})
  if (success == 1) then
    return json:decode(body)
  else
    return nil, "Request Error"
  end
end

function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function sendmsg(chat,text,keyboard)
if keyboard then
urlk = url .. '/sendMessage?chat_id=' ..chat.. '&text='..URL.escape(text)..'&parse_mode=html&reply_markup='..URL.escape(json:encode(keyboard))
else
urlk = url .. '/sendMessage?chat_id=' ..chat.. '&text=' ..URL.escape(text)..'&parse_mode=html'
end
https.request(urlk)
end
 function edit( message_id, text, keyboard)
  local urlk = url .. '/editMessageText?&inline_message_id='..message_id..'&text=' .. URL.escape(text)
    urlk = urlk .. '&parse_mode=Markdown'
  if keyboard then
    urlk = urlk..'&reply_markup='..URL.escape(json:encode(keyboard))
  end
    return https.request(urlk)
  end
function Canswer(callback_query_id, text, show_alert)
	local urlk = url .. '/answerCallbackQuery?callback_query_id=' .. callback_query_id .. '&text=' .. URL.escape(text)
	if show_alert then
		urlk = urlk..'&show_alert=true'
	end
  https.request(urlk)
	end
  function answer(inline_query_id, query_id , title , description , text , keyboard)
  local results = {{}}
         results[1].id = query_id
         results[1].type = 'article'
         results[1].description = description
         results[1].title = title
         results[1].message_text = text
  urlk = url .. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(json:encode(results))..'&parse_mode=Markdown&cache_time=' .. 1
  if keyboard then
   results[1].reply_markup = keyboard
  urlk = url .. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(json:encode(results))..'&parse_mode=Markdown&cache_time=' .. 1
  end
    https.request(urlk)
  end
function settings(chat,value)
local hash = SUDO..'settings:'..chat..':'..value
  if value == 'file' then
      text = 'İ?áÊÑ İÇ?á'
   elseif value == 'keyboard' then
    text = 'İ?áÊÑÏÑæä ÎØ?(˜?ÈÑÏ Ô?Ôå Ç?)'
  elseif value == 'link' then
    text = 'Şİá ÇÑÓÇá á?ä˜(ÊÈá?ÛÇÊ)'
  elseif value == 'game' then
    text = 'İ?áÊÑ ÇäÌÇã ÈÇÒ? åÇ?(inline)'
    elseif value == 'username' then
    text = 'Şİá ÇÑÓÇá ?æÒÑä?ã(@)'
   elseif value == 'pin' then
    text = 'Şİá ?ä ˜ÑÏä(?Çã)'
    elseif value == 'photo' then
    text = 'İ?áÊÑ ÊÕÇæ?Ñ'
    elseif value == 'gif' then
    text = 'İ?áÊÑ ÊÕÇæ?Ñ ãÊÍÑ˜'
    elseif value == 'video' then
    text = 'İ?áÊÑ æ?ÏÆæ'
    elseif value == 'audio' then
    text = 'İ?áÊÑ ÕÏÇ(audio-voice)'
    elseif value == 'music' then
    text = 'İ?áÊÑ Âåä(MP3)'
    elseif value == 'text' then
    text = 'İ?áÊÑ ãÊä'
    elseif value == 'sticker' then
    text = 'Şİá ÇÑÓÇá ÈÑÓÈ'
    elseif value == 'contact' then
    text = 'İ?áÊÑ ãÎÇØÈ?ä'
    elseif value == 'forward' then
    text = 'İ?áÊÑ İæÑæÇÑÏ'
    elseif value == 'persian' then
    text = 'İ?áÊÑ İÊãÇä(İÇÑÓ?)'
    elseif value == 'english' then
    text = 'İ?áÊÑ İÊãÇä(Çäá?Ó?)'
    elseif value == 'bot' then
    text = 'Şİá æÑæÏ ÑÈÇÊ(API)'
    elseif value == 'tgservice' then
    text = 'İ?áÊÑ ?ÛÇã æÑæÏ¡ÎÑæÌ ÇİÑÇÏ'
	elseif value == 'groupadds' then
    text = 'ÊÈá?ÛÇÊ'
    end
		if not text then
		return ''
		end
	if redis:get(hash) then
  redis:del(hash)
return text..'  Û?ÑİÚÇá ÔÏ.'
		else
		redis:set(hash,true)
return text..'  İÚÇá ÔÏ.'
end
    end
function fwd(chat_id, from_chat_id, message_id)
  local urlk = url.. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id
  local res, code, desc = https.request(urlk)
  if not res and code then --if the request failed and a code is returned (not 403 and 429)
  end
  return res, code
end
function sleep(n)
os.execute("sleep " .. tonumber(n))
end
local day = 86400
local function run()
  while true do
    local updates = getUpdates()
    vardump(updates)
    if(updates) then
      if (updates.result) then
        for i=1, #updates.result do
          local msg = updates.result[i]
          offset = msg.update_id + 1
          if msg.inline_query then
            local q = msg.inline_query
						if q.from.id == 370725344 or q.from.id == 261764158 then
            if q.query:match('%d+') then
              local chat = '-'..q.query:match('%d+')
							local function is_lock(chat,value)
local hash = SUDO..'settings:'..chat..':'..value
 if redis:get(hash) then
    return true
    else
    return false
    end
  end
              local keyboard = {}
							keyboard.inline_keyboard = {
								{
                 {text = '?ÊäÙ?ãÇÊ??', callback_data = 'groupsettings:'..chat} --,{text = '??Sales??', callback_data = 'aboute:'..chat}
                },{
				 --{text = '??Support??', callback_data = 'supportbot:'..chat} --,{text = '??Your Adds??', callback_data = 'youradds:'..chat}
				 -- },{
				 {text = '??ÇØáÇÚÇÊ Ñæå??', callback_data = 'groupinfo:'..chat} --,{text = '??Help??', callback_data = 'helpbot:'..chat}
				},{
				{text = '??ÑÇåäãÇ??', callback_data = 'helptext:'..chat}
				},{
				{text = '??ÈÓÊä äá??', callback_data = 'close:'..chat}
				}
							}
            answer(q.id,'panel','Group settings',chat,'?? ãäæ? ÇÕá? :',keyboard)
            end
            end
						end
          if msg.callback_query then
            local q = msg.callback_query
						local chat = ('-'..q.data:match('(%d+)') or '')
						if is_mod(chat,q.from.id) then
             if q.data:match('_') and not (q.data:match('next_page') or q.data:match('left_page')) then
                Canswer(q.id,"@LockerTeam :D",true)
					elseif q.data:match('lock') then
							local lock = q.data:match('lock (.*)')			
				TIME_MAX = (redis:hget("flooding:settings:"..chat,"floodtime") or 3)
              MSG_MAX = (redis:hget("flooding:settings:"..chat,"floodmax") or 5)
			                WARN_MAX = (redis:hget("warn:settings:"..chat,"warnmax") or 3)
							local result = settings(chat,lock)
							if lock == 'photo' or lock == 'audio' or lock == 'video' or lock == 'gif' or lock == 'music' or lock == 'file' or lock == 'link' or lock == 'sticker' or lock == 'text' or lock == 'pin' or lock == 'username' or lock == 'hashtag' or lock == 'contact' then
							q.data = 'left_page:'..chat
							elseif lock == 'muteall' then
								if redis:get(SUDO..'muteall'..chat) then
								redis:del(SUDO..'muteall'..chat)
									result = "İ?áÊÑ ÊãÇã? İÊæ åÇ Û?ÑİÚÇá ÑÏ?Ï."
								else
								redis:set(SUDO..'muteall'..chat,true)
									result = "İ?áÊÑ ÊãÇã? İÊæ åÇ İÚÇá ÑÏ?Ï!"
							end
						 q.data = 'next_page:'..chat
							elseif lock == 'spam' then
							local hash = redis:hget("flooding:settings:"..chat, "flood")
						if hash then
            if redis:hget("flooding:settings:"..chat, "flood") == 'kick' then
         			spam_status = 'ãÓÏæÏ ÓÇÒ?(˜ÇÑÈÑ)'
							redis:hset("flooding:settings:"..chat, "flood",'ban')
              elseif redis:hget("flooding:settings:"..chat, "flood") == 'ban' then
              spam_status = 'Ó˜æÊ(˜ÇÑÈÑ)'
							redis:hset("flooding:settings:"..chat, "flood",'mute')
              elseif redis:hget("flooding:settings:"..chat, "flood") == 'mute' then
              spam_status = '??'
							redis:hdel("flooding:settings:"..chat, "flood")
              end
          else
          spam_status = 'ÇÎÑÇÌ ÓÇÒ?(˜ÇÑÈÑ)'
					redis:hset("flooding:settings:"..chat, "flood",'kick')
          end
								result = 'Úãá˜ÑÏ Şİá ÇÑÓÇá åÑÒäÇãå : '..spam_status
								
								
								
			 q.data = 'next_page:'..chat
							elseif lock == 'warn' then
							local hash = redis:hget("warn:settings:"..chat, "swarn")
						if hash then
            if redis:hget("warn:settings:"..chat, "swarn") == 'kick' then
         			warn_status = 'ãÓÏæÏ ÓÇÒ?(˜ÇÑÈÑ)'
							redis:hset("warn:settings:"..chat, "swarn",'ban')
              elseif redis:hget("warn:settings:"..chat, "swarn") == 'ban' then
              warn_status = 'Ó˜æÊ(˜ÇÑÈÑ)'
							redis:hset("warn:settings:"..chat, "swarn",'mute')
              elseif redis:hget("warn:settings:"..chat, "swarn") == 'mute' then
              warn_status = '??'
							redis:hdel("warn:settings:"..chat, "swarn")
              end
          else
          warn_status = 'ÇÎÑÇÌ ÓÇÒ?(˜ÇÑÈÑ)'
					redis:hset("warn:settings:"..chat, "swarn",'kick')
          end
								result = 'Úãá˜ÑÏ Şİá ÇÑÓÇá åÑÒäÇãå : '..warn_status

								q.data = 'next_page:'..chat
								elseif lock == 'MSGMAXup' then
								if tonumber(MSG_MAX) == 20 then
									Canswer(q.id,'ÍÏÇ˜ËÑ ÚÏÏ ÇäÊÎÇÈ? ÈÑÇ? Ç?ä ŞÇÈá?Ê [20] ã?ÈÇÔÏ!',true)
									else
								MSG_MAX = tonumber(MSG_MAX) + 1
								redis:hset("flooding:settings:"..chat,"floodmax",MSG_MAX)
								q.data = 'next_page:'..chat
							  result = MSG_MAX
								end
								elseif lock == 'MSGMAXdown' then
								if tonumber(MSG_MAX) == 2 then
									Canswer(q.id,'ÍÏÇŞá ÚÏÏ ÇäÊÎÇÈ? ãÌÇÒ  ÈÑÇ? Ç?ä ŞÇÈá?Ê [2] ã?ÈÇÔÏ!',true)
									else
								MSG_MAX = tonumber(MSG_MAX) - 1
								redis:hset("flooding:settings:"..chat,"floodmax",MSG_MAX)
								q.data = 'next_page:'..chat
								result = MSG_MAX
							end
								elseif lock == 'TIMEMAXup' then
								if tonumber(TIME_MAX) == 10 then
								Canswer(q.id,'ÍÏÇ˜ËÑ ÚÏÏ ÇäÊÎÇÈ? ÈÑÇ? Ç?ä ŞÇÈá?Ê [10] ã?ÈÇÔÏ!',true)
									else
								TIME_MAX = tonumber(TIME_MAX) + 1
								redis:hset("flooding:settings:"..chat ,"floodtime" ,TIME_MAX)
								q.data = 'next_page:'..chat
								result = TIME_MAX
									end
								elseif lock == 'TIMEMAXdown' then
								if tonumber(TIME_MAX) == 2 then
									Canswer(q.id,'ÍÏÇŞá ÚÏÏ ÇäÊÎÇÈ? ãÌÇÒ  ÈÑÇ? Ç?ä ŞÇÈá?Ê [2] ã?ÈÇÔÏ!',true)
									else
								TIME_MAX = tonumber(TIME_MAX) - 1
								redis:hset("flooding:settings:"..chat ,"floodtime" ,TIME_MAX)
								q.data = 'next_page:'..chat
								result = TIME_MAX
									end
									
							    elseif lock == 'WARNMAXup' then
								if tonumber(WARN_MAX) == 20 then
									Canswer(q.id,'ÍÏÇ˜ËÑ ÚÏÏ ÇäÊÎÇÈ? ÈÑÇ? Ç?ä ŞÇÈá?Ê [20] ã?ÈÇÔÏ!',true)
									else
								WARN_MAX = tonumber(MSG_MAX) + 1
								redis:hset("warn:settings:"..chat,"warnmax",MSG_MAX)
								q.data = 'next_page:'..chat
							  result = WARN_MAX
								end
								elseif lock == 'WARNMAXdown' then
								if tonumber(WARN_MAX) == 2 then
									Canswer(q.id,'ÍÏÇŞá ÚÏÏ ÇäÊÎÇÈ? ãÌÇÒ  ÈÑÇ? Ç?ä ŞÇÈá?Ê [2] ã?ÈÇÔÏ!',true)
									else
								WARN_MAX = tonumber(WARN_MAX) - 1
								redis:hset("warn:settings:"..chat,"warnmax",WARN_MAX)
								q.data = 'next_page:'..chat
								result = WARN_MAX
							end
									
								elseif lock == 'welcome' then
								local h = redis:get(SUDO..'status:welcome:'..chat)
								if h == 'disable' or not h then
								redis:set(SUDO..'status:welcome:'..chat,'enable')
         result = 'ÇÑÓÇá ?Çã ÎæÔ ÂãÏæ?? İÚÇá ÑÏ?Ï.'
								q.data = 'next_page:'..chat
          else
          redis:set(SUDO..'status:welcome:'..chat,'disable')
          result = 'ÇÑÓÇá ?Çã ÎæÔ ÂãÏæ?? Û?ÑİÚÇá ÑÏ?Ï!'
								q.data = 'next_page:'..chat
									end
								else
								q.data = 'next_page:'..chat
								end
							Canswer(q.id,result)
							end
							-------------------------------------------------------------------------
							if q.data:match('firstmenu') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
local hash = SUDO..'settings:'..chat..':'..value
 if redis:get(hash) then
    return true
    else
    return false
    end
  end
              local keyboard = {}
							keyboard.inline_keyboard = {
								{
                 {text = '?ÊäÙ?ãÇÊ??', callback_data = 'groupsettings:'..chat} --,{text = '??Sales??', callback_data = 'aboute:'..chat}
                },{
				 --{text = '??Support??', callback_data = 'supportbot:'..chat} --,{text = '??Your Adds??', callback_data = 'youradds:'..chat}
				 -- },{
				 {text = '??ÇØáÇÚÇÊ Ñæå??', callback_data = 'groupinfo:'..chat} --,{text = '??Help??', callback_data = 'helpbot:'..chat}
				},{
				{text = '??ÑÇåäãÇ??', callback_data = 'helptext:'..chat}
				},{
				{text = '??ÈÓÊä äá??', callback_data = 'close:'..chat}
							}
							}
            edit(q.inline_message_id,'?? ÈÑÔÊ?ã Èå ãäæ? ÇÕá? :',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('supportbot') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                  {text = '??Technical Team??', callback_data = 'teamfani:'..chat},{text = '??Offer??', callback_data = 'enteqadvapishnehad:'..chat}
                },{
				 {text = '??Report a problem??', callback_data = 'reportproblem:'..chat},{text = '?Frequently Questions?', callback_data = 'soalatmotadavel:'..chat}
				 },{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'`Welcome To` *Support??*\n`Select From` *Menu*??',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('teamfani') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '??Back', callback_data = 'supportbot:'..chat}
				}
							}
              edit(q.inline_message_id,'[??Send Your Msg??](https://telegram.me/LockerTeamBot)',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('reportproblem') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '??Back', callback_data = 'supportbot:'..chat}
				}
							}
              edit(q.inline_message_id,'[??Send Your Problem??](https://telegram.me/LockerTeamBot)',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('fahedsale') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
								{text = 'ÊãÏ?Ï ÓÑæ?Ó ÇäÊÎÇÈ?', callback_data = 'tamdidservice:'..chat},{text = 'ÎÑ?Ï ØÑÍ ÌÏ?Ï', callback_data = 'salegroup:'..chat}

                },{
				{text = 'ÒÇÑÔÇÊ ãÇá?', callback_data = 'reportmony:'..chat}

                },{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '??Back', callback_data = 'supportbot:'..chat}
				}
							}
              edit(q.inline_message_id,'`Èå ÈÎÔ ÎÑ?Ï Ñæå¡ÊãÏ?Ï ÓÑæ?Ó¡ÒÇÑÔ ãÇá? ÎæÔ ÂãÏ?Ï.`\n`ÇÒ ãäæ? Ò?Ñ ÇäÊÎÇÈ ˜ä?Ï:`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('tamdidservice') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '??Back', callback_data = 'fahedsale:'..chat}
				}
							}
              edit(q.inline_message_id,'`ØÑÍ ÇäÊÎÇÈ? [ÔãÇ ÏÇÆã?/ãÇÏÇã ÇáÚãÑ(äÇãÍÏæÏ ÑæÒ)] ã?ÈÇÔÏ æ ä?ÇÒ Èå ÊãÏ?Ï ØÑÍ äÏÇÑ?Ï!`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('reportmony') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'fahedsale:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, unfortunately the system is disabled until further notice??`',keyboard)
            end
			------------------------------------------------------------------------
							if q.data:match('enteqadvapishnehad') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'supportbot:'..chat}
				}
							}
              edit(q.inline_message_id,'[??Send Your Offer??](https://telegram.me/LockerTeamBot)',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('soalatmotadavel') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'supportbot:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, unfortunately the system is disabled until further notice??`',keyboard)
            end
							------------------------------------------------------------------------
						if q.data:match('close') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = '?Î?Ñ?', callback_data = 'firstmenu:'..chat},{text = '?Èáå?', callback_data = 'closepanel:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Ç?Ç ÇÒ ÈÓÊä äá ãØã?ä åÓÊ?Ï¿',keyboard)
            end
			-----------------------------------------------------
						if q.data:match('closepanel') then
                           local chat = '-'..q.data:match('(%d+)$')
			edit(q.inline_message_id,'`??äá ÈÇ ãæİŞ?Ê ÈÓÊå ÔÏ?`')
           end
							------------------------------------------------------------------------
							--[[if q.data:match('groupinfo') thens
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Sorry, unfortunately the system is disabled until further notice??',keyboard)
            end]]
							------------------------------------------------------------------------
							if q.data:match('helpbot') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                  {text = '??Text Help??', callback_data = 'helptext:'..chat}
                },{
				 {text = '??Voice Help??', callback_data = 'voicehelp:'..chat},{text = '??Photo Help??', callback_data = 'videohelp:'..chat}
                },{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'`WelCome To` _Help??_\n Select From *Menu??*',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('helptext') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'>[ÑÇåäãÇ? ãÇá˜?ä Ñæå(ÇÕá?-İÑÚ?)](https://telegram.me/LockerTeam)\n*[/#!]options* --ÏÑ?ÇİÊ ÊäÙ?ãÇÊ Ñæå Èå ÕæÑÊ Ç?äáÇ?ä\n*[/#!]setrules text* --ÊäÙ?ã ŞæÇä?ä Ñæå\n*[/#!]modset* @username|reply|user-id --ÊäÙ?ã ãÇá˜ İÑÚ? ÌÏ?Ï ÈÑÇ? Ñæå ÈÇ ?æÒÑä?ã|Ñ?á?|ÔäÇÓå -İÑÏ\n*[/#!]moddem* @username|reply|user-id --ÍĞİ ãÇá˜ İÑÚ? ÇÒ Ñæå ÈÇ ?æÒÑä?ã|Ñ?á?|ÔäÇÓå -İÑÏ\n*[/#!]ownerlist* --ÏÑ?ÇİÊ á?ÓÊ ãÏ?ÑÇä ÇÕá?\n*[/#!]managers* --ÏÑ?ÇİÊ á?ÓÊ ãÏ?ÑÇä İÑÚ? Ñæå\n*[/#!]setlink link* {á?ä˜-Ñæå} --ÊäÙ?ã á?ä˜ Ñæå\n*[/#!]link* ÏÑ?ÇİÊ á?ä˜ Ñæå\n*[/#!]kick* @username|reply|user-id ÇÎÑÇÌ ˜ÇÑÈÑ ÈÇ Ñ?á?|?æÒÑä?ã|ÔäÇÓå\n*_______________________*\n>[ÑÇåäãÇ? ÈÎÔ ÍĞİ åÇ](https://telegram.me/LockerTeam)\n*[/#!]delete managers* {ÍĞİ ÊãÇã? ãÏ?ÑÇä İÑÚ? ÊäÙ?ã ÔÏå ÈÑÇ? Ñæå}\n*[/#!]delete welcome* {ÍĞİ ?ÛÇã ÎæÔ ÂãÏæ?? ÊäÙ?ã ÔÏå ÈÑÇ? Ñæå}\n*[/#!]delete bots* {ÍĞİ ÊãÇã? ÑÈÇÊ åÇ? ãæÌæÏ ÏÑ ÇÈÑÑæå}\n*[/#!]delete silentlist* {ÍĞİ á?ÓÊ Ó˜æÊ ˜ÇÑÈÑÇä}\n*[/#!]delete filterlist* {ÍĞİ á?ÓÊ ˜áãÇÊ İ?áÊÑ ÔÏå ÏÑ Ñæå}\n*_______________________*\n>[ÑÇåäãÇ? ÈÎÔ ÎæÔ ÂãÏæ??](https://telegram.me/LockerTeam)\n*[/#!]welcome enable* --(İÚÇá ˜ÑÏä ?ÛÇã ÎæÔ ÂãÏæ?? ÏÑ Ñæå)\n*[/#!]welcome disable* --(Û?ÑİÚÇá ˜ÑÏä ?ÛÇã ÎæÔ ÂãÏæ?? ÏÑ Ñæå)\n*[/#!]setwelcome text* --(ÊäÙ?ã ?ÛÇã ÎæÔ ÂãÏæ?? ÌÏ?Ï ÏÑ Ñæå)\n*_______________________*\n>[ÑÇåäãÇ? ÈÎÔ İ?áÊÑÑæå](https://telegram.me/LockerTeam)\n*[/#!]mutechat* --İÚÇá ˜ÑÏä İ?áÊÑ ÊãÇã? İÊæ åÇ\n*[/#!]unmutechat* --Û?ÑİÚÇá ˜ÑÏä İ?áÊÑ ÊãÇã? İÊæ åÇ\n*[/#!]mutechat number(h|m|s)* --İ?áÊÑ ÊãÇã? İÊæ åÇ ÈÑ ÍÓÈ ÒãÇä[ÓÇÚÊ|ÏŞ?Şå|ËÇä?å]\n*_______________________*\n>[ÑÇåäãÇ? ÏÓÊæÑÇÊ ÍÇáÊ Ó˜æÊ ˜ÇÑÈÑÇä](https://telegram.me/LockerTeam)\n*[/#!]silentuser* @username|reply|user-id --ÇİÒæÏä ˜ÇÑÈÑ Èå á?ÓÊ Ó˜æÊ ÈÇ ?æÒÑä?ã|Ñ?á?|ÔäÇÓå -İÑÏ\n*[/#!]unsilentuser* @username|reply|user-id --ÇİÒæÏä ˜ÇÑÈÑ Èå á?ÓÊ Ó˜æÊ ÈÇ ?æÒÑä?ã|Ñ?á?|ÔäÇÓå -İÑÏ\n*[/#!]silentlist* --ÏÑ?ÇİÊ á?ÓÊ ˜ÇÑÈÑÇä ÍÇáÊ Ó˜æÊ\n*_______________________*\n>[ÑÇåäãÇ? ÈÎÔ İ?áÊÑ-˜áãÇÊ](https://telegram.me/LockerTeam)\n*[/#!]filter word --ÇİÒæÏä ÚÈÇÑÊ ÌÏ?Ï Èå á?ÓÊ ˜áãÇÊ İ?áÊÑ ÔÏå\n[/#!]unfilter word* --ÍĞİ ÚÈÇÑÊ ÌÏ?Ï ÇÒ á?ÓÊ ˜áãÇÊ İ?áÊÑ ÔÏå\n*[/#!]filterlist* --ÏÑ?ÇİÊ á?ÓÊ ˜áãÇÊ İ?áÊÑ ÔÏå\n*_______________________*\n>[ÑÇåäãÇ? ÈÎÔ ÊäÙ?ã ?ÛÇã ã˜ÑÑ](https://telegram.me/LockerTeam)\n*[/#!]floodmax number* --ÊäÙ?ã ÍÓÇÓ?Ê äÓÈÊ Èå ÇÑÓÇá ?Çã ã˜ÑÑ\n*[/#!]floodtime* --ÊäÙ?ã ÍÓÇÓ?Ê äÓÈÊ Èå ÇÑÓÇá ?Çã ã˜ÑÑ ÈÑÍÓÈ ÒãÇä',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('videohelp') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'helpbot:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, currently the system of choice is disabled??`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('voicehelp') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'helpbot:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, currently the system of choice is disabled??`',keyboard)
            end
							------------------------------------------------------------------------
							------------------------------------------------------------------------
							if q.data:match('groupinfo') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                  {text = '??ÕÇÍÈÇä Ñæå??', callback_data = 'ownerlist:'..chat}
                },{
				{text = '????ãÏ?ÑÇä Ñæå????', callback_data = 'managerlist:'..chat}
                },{
				 {text = '?ŞæÇä?ä Ñæå?', callback_data = 'showrules:'..chat}
				 },{
				 {text = '??á?ä˜ Ñæå??', callback_data = 'linkgroup:'..chat}
				 },{
				 {text = '??á?ÓÊ ˜ÇÑÈÑÇä ãÓÏæÏ??', callback_data = 'banlist:'..chat}
				  },{
				  {text = '??á?ÓÊ ˜áãÇÊ İ?áÊÑ??', callback_data = 'filterlistword:'..chat}
				  },{
				 {text = '??á?ÓÊ ˜ÇÑÈÑÇä ã?æÊ??', callback_data = 'silentlistusers:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'©ÇØáÇÚÇÊ Ñæå :',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('managerlist') then
                           local chat = '-'..q.data:match('(%d+)$')
						   local list = redis:smembers(SUDO..'mods:'..chat)
          local t = '*????ãÏ?ÑÇä Ñæå??* \n\n'
          for k,v in pairs(list) do
          t = t..k.." - `"..v.."`\n"
          end
          t = t..'\nÈÑÇ? ãÔÇåÏå ˜ÇÑÈÑ ÇÒ ÏÓÊæÑ Ò?Ñ ÇÓÊİÇÏå ˜ä?Ï ??\n/whois [Â?Ï? ˜ÇÑÈÑ]\nãËÇá ??\n /whois 234458457'
          if #list == 0 then
          t = '*????å? ãÏ?Ñ? ÏÑ Ñæå æÌæÏ äÏÇÑÏ?*'
          end
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '????Ç˜ ÓÇÒ? ãÏ?ÑÇä??', callback_data = 'removemanagers:'..chat}
				   },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'groupinfo:'..chat}
				}
							}
              edit(q.inline_message_id, ''..t..'',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('showmanagers') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'managerlist:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, currently the system of choice is disabled??`',keyboard)
            end
							------------------------------------------------------------------------
							------------------------------------------------------------------------
							if q.data:match('ownerlist') then
                           local chat = '-'..q.data:match('(%d+)$')
						   local list = redis:smembers(SUDO..'owners:'..chat)
          local t = '*??á?ÓÊ ÕÇÍÈÇä Ñæå??* \n\n'
          for k,v in pairs(list) do
          t = t..k.." - `"..v.."`\n"
          end
          t = t..'\nÈÑÇ? ãÔÇåÏå ˜ÇÑÈÑ ÇÒ ÏÓÊæÑ Ò?Ñ ÇÓÊİÇÏå ˜ä?Ï ??\n/whois [Â?Ï? ˜ÇÑÈÑ]\nãËÇá ??\n /whois 234458457'
          if #list == 0 then
          t = '??Ç?ä Ñæå å? ÕÇÍÈ? äÏÇÑÏ?'
          end
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                  {text = '??Ç˜ ÓÇÒ? ÕÇÍÈÇä Ñæå?', callback_data = 'removeowners:'..chat}
				   },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'groupinfo:'..chat}
				}
							}
              edit(q.inline_message_id, ''..t..'',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('showowners') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'ownerlist:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, currently the system of choice is disabled??`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('showrules') then
                           local chat = '-'..q.data:match('(%d+)$')
						   local rules = redis:get(SUDO..'grouprules'..chat)
          if not rules then
          rules = '?ŞæÇä?ä? æÌæÏ äÏÇÑÏ?'
          end
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
							{text = '?Ç˜ ÓÇÒ? ŞæÇä?ä?', callback_data = 'removerules:'..chat}
				   },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'groupinfo:'..chat}
				}
							}
              edit(q.inline_message_id, '?ŞæÇä?ä Ñæå??\n\n `'..rules..'`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('linkgroup') then
                           local chat = '-'..q.data:match('(%d+)$')
						   local links = redis:get(SUDO..'grouplink'..chat)
          if not links then
          links = '??á?ä˜? æÌæÏ äÏÇÑÏ?'
          end
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
								{text = '??ÍĞİ á?ä˜?', callback_data = 'removegrouplink:'..chat}
				   },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'groupinfo:'..chat}
				}
							}
              edit(q.inline_message_id, '??á?ä˜ Ñæå??\n '..links..'',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('banlist') then
                           local chat = '-'..q.data:match('(%d+)$')
						  local list = redis:smembers(SUDO..'banned'..chat)
          local t = '*??á?ÓÊ ãÓÏæÏ ÔÏÇä??*\n\n'
          for k,v in pairs(list) do
          t = t..k.." - _"..v.."_\n"
          end
          t = t..'\nÈÑÇ? ãÔÇåÏå ˜ÇÑÈÑ ÇÒ ÏÓÊæÑ Ò?Ñ ÇÓÊİÇÏå ˜ä?Ï ??\n/whois [Â?Ï? ˜ÇÑÈÑ]\nãËÇá ??\n /whois 234458457'
          if #list == 0 then
          t = '*??å? ˜ÇÑÈÑ ãÓÏæÏ? ÏÑ Ç?ä Ñæå æÌæÏ äÏÇÑÏ?*'
          end
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '??Ç˜ÓÇÒ? ˜ÇÑÈÑÇä ãÓÏæÏ?', callback_data = 'removebanlist:'..chat}
				   },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'groupinfo:'..chat}
				}
							}
              edit(q.inline_message_id, ''..t..'',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('showusers') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'banlist:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, currently the system of choice is disabled??`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('silentlistusers') then
                           local chat = '-'..q.data:match('(%d+)$')
						  local list = redis:smembers(SUDO..'mutes'..chat)
          local t = '??á?ÓÊ ˜ÇÑÈÑÇä Ó˜æÊ ÔÏå?? \n\n'
          for k,v in pairs(list) do
          t = t..k.." - _"..v.."_\n"
          end
          t = t..'\nÈÑÇ? ãÔÇåÏå ˜ÇÑÈÑ ÇÒ ÏÓÊæÑ Ò?Ñ ÇÓÊİÇÏå ˜ä?Ï ??\n/whois [Â?Ï? ˜ÇÑÈÑ]\nãËÇá ??\n /whois 234458457'
          if #list == 0 then
          t = '??å? ˜ÇÑÈÑ? ÏÑ á?ÓÊ Ó˜æÊ æÌæÏ äÏÇÑÏ?'
          end
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '??Ç˜ÓÇÒ? á?ÓÊ Ó˜æÊ?', callback_data = 'removesilentlist:'..chat}
				   },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'groupinfo:'..chat}
				}
							}
              edit(q.inline_message_id, ''..t..'',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('showusersmutelist') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'silentlistusers:'..chat}
				}
							}
              edit(q.inline_message_id,'`??Sorry, currently the system of choice is disabled??`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('filterlistword') then
                           local chat = '-'..q.data:match('(%d+)$')
						   local list = redis:smembers(SUDO..'filters:'..chat)
          local t = '??˜áãÇÊ İ?áÊÑ ÔÏå?? \n\n'
          for k,v in pairs(list) do
          t = t..k.." - _"..v.."_\n"
          end
          if #list == 0 then
          t = '??á?ÓÊ ˜áãÇÊ İ?áÊÑ ÔÏå ÎÇá? ÇÓÊ?'
          end
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '??Ç˜ÓÇÒ? İ?áÊÑ á?ÓÊ?', callback_data = 'removefilterword:'..chat}
				   },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'groupinfo:'..chat}
				}
							}
              edit(q.inline_message_id, ''..t..'',keyboard)
            end
							--########################################################################--
							if q.data:match('removemanagers') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = '?Î?Ñ?', callback_data = 'bgdbdfddhdfhdyumrurmtu:'..chat},{text = '?Èáå?', callback_data = 'hjwebrjb53j5bjh3:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'managerlist:'..chat}
				}
							}
              edit(q.inline_message_id,'??Â?Ç ÇÒ ÇäÌÇã Ç?ä Úãá?ÇÊ ãØã?ä åÓÊ?Ï?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('hjwebrjb53j5bjh3') then
                           local chat = '-'..q.data:match('(%d+)$')
						   redis:del(SUDO..'mods:'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ ÈÇ ãæİŞ?Ê ÇäÌÇã ÔÏ?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('bgdbdfddhdfhdyumrurmtu') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ áÛæ ÔÏ??',keyboard)
            end
						--########################################################################--
						if q.data:match('removeowners') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = '?Î?Ñ?', callback_data = 'ncxvnfhfherietjbriurti:'..chat},{text = '?Èáå?', callback_data = 'ewwerwerwer4334b5343:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'ownerlist:'..chat}
				}
							}
              edit(q.inline_message_id,'??Â?Ç ÇÒ ÇäÌÇã Ç?ä Úãá?ÇÊ ãØã?ä åÓÊ?Ï?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('ewwerwerwer4334b5343') then
                           local chat = '-'..q.data:match('(%d+)$')
						  redis:del(SUDO..'owners:'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ ÈÇ ãæİŞ?Ê ÇäÌÇã ÔÏ?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('ncxvnfhfherietjbriurti') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ áÛæ ÔÏ??',keyboard)
            end
							--########################################################################--
							if q.data:match('removerules') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = '?Î?Ñ?', callback_data = 'as12310fklfkmgfvm:'..chat},{text = '?Èáå?', callback_data = '3kj5g34ky6g34uy:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'showrules:'..chat}
				}
							}
              edit(q.inline_message_id,'??Â?Ç ÇÒ ÇäÌÇã Ç?ä Úãá?ÇÊ ãØã?ä åÓÊ?Ï?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('3kj5g34ky6g34uy') then
                           local chat = '-'..q.data:match('(%d+)$')
						  redis:del(SUDO..'grouprules'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ ÈÇ ãæİŞ?Ê ÇäÌÇã ÔÏ?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('as12310fklfkmgfvm') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ áÛæ ÔÏ??',keyboard)
            end
							--########################################################################--
							if q.data:match('removegrouplink') then
                           local chat = '-'..q.data:match('(%d+)$')
						   redis:del(SUDO..'grouplink'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'linkgroup:'..chat}
				}
							}
              edit(q.inline_message_id,'??á?ä˜ Ñæå ÈÇ ãæİŞ?Ê ÍĞİ ÔÏ?',keyboard)
            end
							--########################################################################--
								if q.data:match('removebanlist') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = '?Î?Ñ?', callback_data = 'sudfewbhwebr9983243:'..chat},{text = '?Èáå?', callback_data = 'erwetrrefgfhfdhretre:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'banlist:'..chat}
				}
							}
              edit(q.inline_message_id,'??Â?Ç ÇÒ ÇäÌÇã Ç?ä Úãá?ÇÊ ãØã?ä åÓÊ?Ï?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('erwetrrefgfhfdhretre') then
                           local chat = '-'..q.data:match('(%d+)$')
						  redis:del(SUDO..'banned'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ ÈÇ ãæİŞ?Ê ÇäÌÇã ÔÏ?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('sudfewbhwebr9983243') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ áÛæ ÔÏ??',keyboard)
            end
							--########################################################################--
								if q.data:match('removesilentlist') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = '?Î?Ñ?', callback_data = 'sadopqwejjbkvw90892:'..chat},{text = '?Èáå?', callback_data = 'ncnvdifeqrhbksdgfid47:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'silentlistusers:'..chat}
				}
							}
              edit(q.inline_message_id,'??Â?Ç ÇÒ ÇäÌÇã Ç?ä Úãá?ÇÊ ãØã?ä åÓÊ?Ï?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('ncnvdifeqrhbksdgfid47') then
                           local chat = '-'..q.data:match('(%d+)$')
						  redis:del(SUDO..'mutes'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ ÈÇ ãæİŞ?Ê ÇäÌÇã ÔÏ?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('sadopqwejjbkvw90892') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ áÛæ ÔÏ??',keyboard)
            end
							--########################################################################--
							if q.data:match('removefilterword') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = '?Î?Ñ?', callback_data = 'ncxvbcusxsokd9374uid:'..chat},{text = '?Èáå?', callback_data = 'erewigfuwebiebfjdskfbdsugf:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'filterlistword:'..chat}
				}
							}
              edit(q.inline_message_id,'??Â?Ç ÇÒ ÇäÌÇã Ç?ä Úãá?ÇÊ ãØã?ä åÓÊ?Ï?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('erewigfuwebiebfjdskfbdsugf') then
                           local chat = '-'..q.data:match('(%d+)$')
						  redis:del(SUDO..'filters:'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ ÈÇ ãæİŞ?Ê ÇäÌÇã ÔÏ?',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('ncxvbcusxsokd9374uid') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
				}
							}
              edit(q.inline_message_id,'??Úãá?ÇÊ áÛæ ÔÏ??',keyboard)
            end
							--########################################################################--
							--#####################################################################--
							if q.data:match('salegroup') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
				 {text = 'ãÏ?Ñ?Ê ãÚãæá? Ñæå', callback_data = 'normalmanage:'..chat}
                },{
				{text = 'ãÏ?Ñ?Ê ?ÔÑİÊå Ñæå', callback_data = 'promanage:'..chat}
                },{
				{text = 'ãÏ?Ñ?Ê ÍÑİå Ç? Ñæå', callback_data = 'herfeiimanage:'..chat}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '?? ÈÑÔÊ Èå ãäæ? ŞÈá???', callback_data = 'fahedsale:'..chat}
				}
							}
              edit(q.inline_message_id,'`ÏÑ Ç?ä ÈÎÔ ÔãÇ ã?ÊæÇä?Ï äÓÈÊ Èå ÎÑ?Ï ÓÑæ?Ó/ØÑÍ ÌÏ?Ï ÇŞÏÇã ˜ä?Ï.`\n`ÓÑæ?Ó ãæÑÏ äÙÑ ÎæÏ ÑÇ ÇäÊÎÇÈ ˜ä?Ï:`',keyboard)
            end
			------------------------------------------------------------------------
							if q.data:match('normalmanage') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
								{text = 'ØÑÍ åÇ æ ÊÚÑİå åÇ', callback_data = 'tarhvatarefe:'..chat},{text = 'ÈÑÑÓ? ŞÇÈá?Ê åÇ', callback_data = 'baresiqabeliyat:'..chat}
                },{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'salegroup:'..chat}
				}
							}
              edit(q.inline_message_id,'`>ÓÑæ?Ó ÇäÊÎÇÈ? ÔãÇ: [ãÏ?Ñ?Ê ãÚãæá? Ñæå].`\n`ÇÒ ãäæ? Ò?Ñ ÇäÊÎÇÈ ˜ä?Ï:`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('promanage') then
                           local chat = '-'..q.data:match('(%d+)$')
						  --redis:del(SUDO..'filters:'..chat)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
								{text = 'ØÑÍ åÇ æ ÊÚÑİå åÇ', callback_data = 'tarhpro:'..chat},{text = 'ÈÑÑÓ? ŞÇÈá?Ê åÇ', callback_data = 'pishrafteberesi:'..chat}
                },{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'salegroup:'..chat}
				}
							}
              edit(q.inline_message_id,'`>ÓÑæ?Ó ÇäÊÎÇÈ? ÔãÇ: [ãÏ?Ñ?Ê ?ÔÑİÊå Ñæå].`\n`ÇÒ ãäæ? Ò?Ñ ÇäÊÎÇÈ ˜ä?Ï:`',keyboard)
            end
							------------------------------------------------------------------------
							if q.data:match('herfeiimanage') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
								{text = 'ØÑÍ åÇ æ ÊÚÑİå åÇ', callback_data = 'herfetarh:'..chat},{text = 'ÈÑÑÓ? ŞÇÈá?Ê åÇ', callback_data = 'qabeliyarherfeii:'..chat}
                },{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'salegroup:'..chat}
				}
							}
              edit(q.inline_message_id,'`>ÓÑæ?Ó ÇäÊÎÇÈ? ÔãÇ: [ãÏ?Ñ?Ê ÍÑİå Ç? Ñæå].`\n`ÇÒ ãäæ? Ò?Ñ ÇäÊÎÇÈ ˜ä?Ï:`',keyboard)
            end
							--********************************************************************--
							if q.data:match('tarhpro') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'promanage:'..chat}
				}
							}
              edit(q.inline_message_id,'`Ş?ãÊ ØÑÍ åÇ? ãÑÈæØ Èå Ç?ä ÑÈÇÊ:`\n`ãÇåÇäå(30 Çá? 31 ÑæÒ ˜Çãá)` >  *14900*\n`ÓÇáÇäå(365 ÑæÒ ˜Çãá)` > *34000*\n`ÏÇÆã?/ãÇÏÇã ÇáÚãÑ(äÇãÍÏæÏ ÑæÒ)` > *45000*\n`ÊãÇã? Ş?ãÊ åÇ Èå` ÊæãÇä `ã?ÈÇÔÏ.`',keyboard)
            end
			------------@@@@@@@@@@@@@@@@@@@@@@@@@@------------------
			if q.data:match('tarhvatarefe') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'normalmanage:'..chat}
				}
							}
              edit(q.inline_message_id,'`Ş?ãÊ ØÑÍ åÇ? ãÑÈæØ Èå Ç?ä ÑÈÇÊ:`\n`ãÇåÇäå(30 Çá? 31 ÑæÒ ˜Çãá)` >  *9900*\n`ÓÇáÇäå(365 ÑæÒ ˜Çãá)` > *23000*\n`ÏÇÆã?/ãÇÏÇã ÇáÚãÑ(äÇãÍÏæÏ ÑæÒ)` > *35000*\n`ÊãÇã? Ş?ãÊ åÇ Èå` ÊæãÇä `ã?ÈÇÔÏ.`',keyboard)
            end
			------------@@@@@@@@@@@@@@@@@@@@@@@@@@------------------
			if q.data:match('herfetarh') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'herfeiimanage:'..chat}
				}
							}
              edit(q.inline_message_id,'`Ş?ãÊ ØÑÍ åÇ? ãÑÈæØ Èå Ç?ä ÑÈÇÊ:`\n`ãÇåÇäå(30 Çá? 31 ÑæÒ ˜Çãá)` >  *16900*\n`ÓÇáÇäå(365 ÑæÒ ˜Çãá)` > *37500*\n`ÏÇÆã?/ãÇÏÇã ÇáÚãÑ(äÇãÍÏæÏ ÑæÒ)` > *49000*\n`ÊãÇã? Ş?ãÊ åÇ Èå` ÊæãÇä `ã?ÈÇÔÏ.`',keyboard)
            end
							----------------------------------ÈÑÑÓ? ŞÇÈá?Ê åÇ--------------------------------------
							if q.data:match('pishrafteberesi') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'promanage:'..chat}
				}
							}
              edit(q.inline_message_id,'`ÈÑÑÓ? ŞÇÈá?Ê åÇ? Ç?ä ÓÑæ?Ó:`\nÔÑÍ ŞÇÈá?Ê åÇ: (ÓÑÚÊ ÈÇáÇ ÏÑ ÇäÌÇã ÏÓÊæÑÇÊ æ ãæÇÑÏ ÊäÙ?ã ÔÏå ÈÑÇ? Ñæå ÎæÏ--ÏŞÊ ÏÑ ÇäÌÇã ÏÓÊæÑÇÊ ÏÇÏå ÔÏå: 100%--ÑÇÈØ ˜ÇÑÈÑ? İæŞ ÇáÚÇÏå æ ÏÇÑÇ? ŞÇÈá?Ê æ ãÊæÏ åÇ? ÌÏ?Ï ÊáÑÇã(ÊæÖ?ÍÇÊ È?ÔÊÑ ÏÑ ÓÊ åÇ? ÈÇáÇ ãæÌæÏ ã?ÈÇÔÏ.))',keyboard)
            end
							--********************************************************************--
							if q.data:match('baresiqabeliyat') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '?? Back', callback_data = 'normalmanage:'..chat}
				}
							}
              edit(q.inline_message_id,'`ÈÑÑÓ? ŞÇÈá?Ê åÇ? Ç?ä ÓÑæ?Ó:`\nÔÑÍ ŞÇÈá?Ê åÇ: (ÓÑÚÊ Ç??ä ÊÑ äÓÈÊ Èå ÑÈÇÊ ÈÇáÇ(Èå Ïá?á Ò?ÇÏ ÔÏä ÂãÇÑ Ñæå åÇ? İÚÇá ÑÈÇÊ--ÚãÑ ÑÈÇÊ: 26 ãÇå)--ÏŞÊ ÏÑ ÇäÌÇã ÏÓÊæÑÇÊ ÏÇÏå ÔÏå: 96%--ÑÇÈØ ˜ÇÑÈÑ? İæŞ ÇáÚÇÏå æ ÏÇÑÇ? ŞÇÈá?Ê åÇ? ?ÔÑİÊå æ äÓÈÊÇ ÌÏ?Ï)',keyboard)
            end
							--********************************************************************--
							if q.data:match('qabeliyarherfeii') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '?? Back To Menu', callback_data = 'firstmenu:'..chat},{text = '??Back', callback_data = 'herfeiimanage:'..chat}
				}
							}
              edit(q.inline_message_id,'`ÈÑÑÓ? ŞÇÈá?Ê åÇ? Ç?ä ÓÑæ?Ó:`\nÔÑÍ ŞÇÈá?Ê åÇ: (ÓÑÚÊ ÈÇáÇ ÏÑ ÇäÌÇã ÏÓÊæÑÇÊ æ ãæÇÑÏ ÊäÙ?ã ÔÏå ÈÑÇ? Ñæå ÎæÏ--ÏŞÊ ÏÑ ÇäÌÇã ÏÓÊæÑÇÊ ÏÇÏå ÔÏå: 100%--ÑÇÈØ ˜ÇÑÈÑ? İæŞ ÇáÚÇÏå æ ÏÇÑÇ? ŞÇÈá?Ê æ ãÊæÏ åÇ? ÌÏ?Ï ÊáÑÇã(ÊæÖ?ÍÇÊ È?ÔÊÑ ÏÑ ÓÊ åÇ? ÈÇáÇ ãæÌæÏ + ãÏ?Ñ?Ê ÍÑİå Ç?(ÏÇÑÇ? äá ãÏ?Ñ?Ê? ÎæÏ˜ÇÑ æ ÈÏæä ä?ÇÒ Èå ÇÑÓÇá ÏÓÊæÑ!)',keyboard)
            end
							--********************************************************************--
							--********************************************************************--
							--********************************************************************--
							------------------------------------------------------------------------
							if q.data:match('groupsettings') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
local hash = SUDO..'settings:'..chat..':'..value
 if redis:get(hash) then
    return true
    else
    return false
    end
  end

local function getsettings(value)
       if value == "charge" then
	   local exp = tonumber(redis:get('bot:charge:'..chat))
                if exp == 0 then
				exp_dat = 'Unlimited'
				        return exp_dat
				else
			local now = tonumber(os.time())
      if not now then 
      now = 0 
      end
      if not exp then
      exp = 0
      end
			exp_dat = (math.floor((tonumber(exp) - tonumber(now)) / 86400) + 1)   
        return exp_dat.."Day"	
end
elseif value == 'muteall' then
				local h = redis:ttl(SUDO..'muteall'..chat)
          if h == -1 then
        return '?? Şİá ??'
				elseif h == -2 then
        return '?? ÂÒÇÏ ??'
       else
        return "ÊÇ ["..h.."] ËÇä?å Ï?Ñ İÚÇá ÇÓÊ"
       end
        elseif value == 'welcome' then
					local hash = redis:get(SUDO..'status:welcome:'..chat)
        if hash == 'enable' then
         return 'İÚÇá'
          else
          return 'Û?ÑİÚÇá'
          end
        elseif value == 'spam' then
       local hash = redis:get(SUDO..'settings:flood'..chat)
        if hash then
            if redis:get(SUDO..'settings:flood'..chat) == 'kick' then
         return '?ÇÎÑÇÌ?'
             elseif redis:get(SUDO..'settings:flood'..chat) == 'ban' then
              return '?ãÓÏæÏ?'
               elseif redis:get(SUDO..'settings:flood'..chat) == 'mute' then
              return '??Ó˜æÊ??'
              end
          else
          return '?? ÂÒÇÏ ??'
          end
		  
		          elseif value == 'warn' then
       local hash = redis:hget("warn:settings:"..chat ,"swarn")
        if hash then
            if redis:hget("warn:settings:"..chat ,"swarn") == 'kick' then
         return '?ÇÎÑÇÌ?'
             elseif redis:hget("warn:settings:"..chat ,"swarn") == 'ban' then
              return '?ãÓÏæÏ?'
               elseif redis:hget("warn:settings:"..chat ,"swarn") == 'mute' then
              return '??Ó˜æÊ??'
              end
          else
          return '?? ÂÒÇÏ ??'
          end
        elseif is_lock(chat,value) then
          return '?? Şİá ??'
          else
          return '?? ÂÒÇÏ ??'
          end
        end
              local keyboard = {}
            	keyboard.inline_keyboard = {
	            	{
                {text=getsettings('photo'),callback_data=chat..':lock photo'}, {text = '?? ÊÕÇæ?Ñ ??', callback_data = chat..'_photo'}
                },{
                 {text=getsettings('video'),callback_data=chat..':lock video'}, {text = '?? İ?áã ??', callback_data = chat..'_video'}
                },{
                 {text=getsettings('audio'),callback_data=chat..':lock audio'}, {text = '??  ÕÏÇ ??', callback_data = chat..'_audio'}
                },{
                 {text=getsettings('gif'),callback_data=chat..':lock gif'}, {text = '?? ?İ ??', callback_data = chat..'_gif'}
                },{
                 {text=getsettings('music'),callback_data=chat..':lock music'}, {text = '?? ãæÒ?˜ ??', callback_data = chat..'_music'}
                },{
                  {text=getsettings('file'),callback_data=chat..':lock file'},{text = '?? İÇ?á ??', callback_data = chat..'_file'}
                },{
                  {text=getsettings('link'),callback_data=chat..':lock link'},{text = '?? á?ä˜ ??', callback_data = chat..'_link'}
                },{
                 {text=getsettings('sticker'),callback_data=chat..':lock sticker'}, {text = '?? ÇÓÊ?˜Ñ ??', callback_data = chat..'_sticker'}
                },{
                  {text=getsettings('text'),callback_data=chat..':lock text'},{text = '?? ãÊä ??', callback_data = chat..'_text'}
                },{
                  {text=getsettings('pin'),callback_data=chat..':lock pin'},{text = '?? ?ä ??', callback_data = chat..'_pin'}
                },{
                 {text=getsettings('username'),callback_data=chat..':lock username'}, {text = '?? ?æÒä?ã ??', callback_data = chat..'_username'}
                },{
                  {text=getsettings('contact'),callback_data=chat..':lock contact'},{text = '?? ãÎÇØÈ ??', callback_data = chat..'_contact'}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '2??ÕİÍå Ïæã ??', callback_data = 'next_page:'..chat}
                }
              }
            edit(q.inline_message_id,'_?? ÊäÙ?ãÇÊ ??_\n`??ÕİÍå Çæá 1??`\n@Lockerteam',keyboard)
            end
			------------------------------------------------------------------------
            if q.data:match('left_page') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
local hash = SUDO..'settings:'..chat..':'..value
 if redis:get(hash) then
    return true
    else
    return false
    end
 end
local function getsettings(value)
       if value == "charge" then
	   local exp = tonumber(redis:get('bot:charge:'..chat))
                if exp == 0 then
				exp_dat = 'Unlimited'
				        return exp_dat
				else
			local now = tonumber(os.time())
      if not now then 
      now = 0 
      end
      if not exp then
      exp = 0
      end
			exp_dat = (math.floor((tonumber(exp) - tonumber(now)) / 86400) + 1)   
        return exp_dat.."Day"	
end
        elseif value == 'spam' then
       local hash = redis:get(SUDO..'settings:flood'..chat)
        if hash then
            if redis:get(SUDO..'settings:flood'..chat) == 'kick' then
         return '?ÇÎÑÇÌ?'
             elseif redis:get(SUDO..'settings:flood'..chat) == 'ban' then
              return '?ãÓÏæÏ?'
               elseif redis:get(SUDO..'settings:flood'..chat) == 'mute' then
              return '??Ó˜æÊ??'
              end
          else
          return '?? ÂÒÇÏ ??'
          end
		  
		          elseif value == 'warn' then
       local hash = redis:hget("warn:settings:"..chat ,"swarn")
        if hash then
            if redis:hget("warn:settings:"..chat ,"swarn") == 'kick' then
         return '?ÇÎÑÇÌ?'
             elseif redis:hget("warn:settings:"..chat ,"swarn") == 'ban' then
              return '?ãÓÏæÏ?'
               elseif redis:hget("warn:settings:"..chat ,"swarn") == 'mute' then
              return '??Ó˜æÊ??'
              end
          else
          return '?? ÂÒÇÏ ??'
          end
        elseif is_lock(chat,value) then
          return '?? Şİá ??'
          else
          return '?? ÂÒÇÏ ??'
          end
        end
							local keyboard = {}
							keyboard.inline_keyboard = {
									{
                  {text=getsettings('photo'),callback_data=chat..':lock photo'}, {text = '?? ÊÕÇæ?Ñ ??', callback_data = chat..'_photo'}
                },{
                 {text=getsettings('video'),callback_data=chat..':lock video'}, {text = '?? İ?áã ??', callback_data = chat..'_video'}
                },{
                 {text=getsettings('audio'),callback_data=chat..':lock audio'}, {text = '??  ÕÏÇ ??', callback_data = chat..'_audio'}
                },{
                 {text=getsettings('gif'),callback_data=chat..':lock gif'}, {text = '?? ?İ ??', callback_data = chat..'_gif'}
                },{
                 {text=getsettings('music'),callback_data=chat..':lock music'}, {text = '?? ãæÒ?˜ ??', callback_data = chat..'_music'}
                },{
                  {text=getsettings('file'),callback_data=chat..':lock file'},{text = '?? İÇ?á ??', callback_data = chat..'_file'}
                },{
                  {text=getsettings('link'),callback_data=chat..':lock link'},{text = '?? á?ä˜ ??', callback_data = chat..'_link'}
                },{
                 {text=getsettings('sticker'),callback_data=chat..':lock sticker'}, {text = '?? ÇÓÊ?˜Ñ ??', callback_data = chat..'_sticker'}
                },{
                  {text=getsettings('text'),callback_data=chat..':lock text'},{text = '?? ãÊä ??', callback_data = chat..'_text'}
                },{
                  {text=getsettings('pin'),callback_data=chat..':lock pin'},{text = '?? ?ä ??', callback_data = chat..'_pin'}
                },{
                 {text=getsettings('username'),callback_data=chat..':lock username'}, {text = '?? ?æÒä?ã ??', callback_data = chat..'_username'}
                },{
                  {text=getsettings('contact'),callback_data=chat..':lock contact'},{text = '?? ãÎÇØÈ ??', callback_data = chat..'_contact'}
                },{
                   {text = '?? ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat},{text = '2??ÕİÍå Ïæã ??', callback_data = 'next_page:'..chat}
                }
              }
            edit(q.inline_message_id,'_?? ÊäÙ?ãÇÊ ??_\n`?? ÈÑÔÊ?ã Èå ÕİÍå Çæá 1 ??`\nLockerTeam',keyboard)
            end
						if q.data:match('next_page') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
local hash = SUDO..'settings:'..chat..':'..value
 if redis:get(hash) then
    return true
    else
    return false
    end
  end
local function getsettings(value)
        if value == "charge" then
	   local exp = tonumber(redis:get('bot:charge:'..chat))
                if exp == 0 then
				exp_dat = 'Unlimited'
				        return exp_dat
				else
			local now = tonumber(os.time())
      if not now then 
      now = 0 
      end
      if not exp then
      exp = 0
      end
			exp_dat = (math.floor((tonumber(exp) - tonumber(now)) / 86400) + 1)   
        return exp_dat.."Day"
end
        elseif value == 'muteall' then
        local h = redis:ttl(SUDO..'muteall'..chat)
       if h == -1 then
        return '?? Şİá ??'
    elseif h == -2 then
     return '?? ÂÒÇÏ ??'
       else
        return "ÊÇ ["..h.."] ËÇä?å Ï?Ñ İÚÇá ÇÓÊ"
       end
        elseif value == 'welcome' then
        local hash = redis:get(SUDO..'status:welcome:'..chat)
        if hash == 'enable' then
         return '?İÚÇá?'
          else
          return '?Û?Ñ İÚÇá?'
          end
        elseif value == 'spam' then
       local hash = redis:hget("flooding:settings:"..chat, "flood")
        if hash then
           if redis:hget("flooding:settings:"..chat, "flood") == 'kick' then
         return '?ÇÎÑÇÌ?'
             elseif redis:hget("flooding:settings:"..chat, "flood") == 'ban' then
              return '?ãÓÏæÏ?'
              elseif redis:hget("flooding:settings:"..chat, "flood") == 'mute' then
              return '??Ó˜æÊ??'
              end
          else
          return '?? ÂÒÇÏ ??'
          end
            elseif value == 'warn' then
       local hash = redis:hget("warn:settings:"..chat, "swarn")
        if hash then
           if redis:hget("warn:settings:"..chat, "swarn") == 'kick' then
         return '?ÇÎÑÇÌ?'
             elseif redis:hget("warn:settings:"..chat, "swarn") == 'ban' then
              return '?ãÓÏæÏ?'
              elseif redis:hget("warn:settings:"..chat, "swarn") == 'mute' then
              return '??Ó˜æÊ??'
              end
          else
          return '?? ÂÒÇÏ ??'
          end
    
        elseif is_lock(chat,value) then
          return '?? Şİá ??'
          else
          return '?? ÂÒÇÏ ??'
          end
        end
									local MSG_MAX = (redis:hget("flooding:settings:"..chat,"floodmax") or 5)
									local WARN_MAX = (redis:hget("warn:settings:"..chat,"warnmax") or 3)
								local TIME_MAX = (redis:hget("flooding:settings:"..chat,"floodtime") or 3)
         		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                  {text=getsettings('forward'),callback_data=chat..':lock forward'},{text = '?? İÑæÇÑÏ ??', callback_data = chat..'_forward'}
                },{
                  {text=getsettings('bot'),callback_data=chat..':lock bot'},{text = '?? ÈÇÊ ??', callback_data = chat..'_bot'}
                },{
                  {text=getsettings('game'),callback_data=chat..':lock game'},{text = '?? ÈÇÒ? ??', callback_data = chat..'_game'}
                },{
                  {text=getsettings('persian'),callback_data=chat..':lock persian'},{text = '?? İÇÑÓ? ????', callback_data = chat..'_persian'}
                },{
                  {text=getsettings('english'),callback_data=chat..':lock english'},{text = '?? Çäá?Ó? ????', callback_data = chat..'_english'}
                },{
                  {text=getsettings('keyboard'),callback_data=chat..':lock keyboard'},{text = '?? Ç?äáÇ?ä ??', callback_data = chat..'_keyboard'}
                },{
                  {text=getsettings('tgservice'),callback_data=chat..':lock tgservice'},{text = '?? ?ÛÇã æÑæÏ æ ÎÑæÌ ??', callback_data = chat..'_tgservice'}
                },{
                 {text=getsettings('muteall'),callback_data=chat..':lock muteall'}, {text = '?? Ê ??', callback_data = chat..'_muteall'}
                },{
                 {text=getsettings('welcome'),callback_data=chat..':lock welcome'}, {text = '?? ÎæÔ ÂãÏæ?? ??', callback_data = chat..'_welcome'}
                },{
         {text=getsettings('warn'),callback_data=chat..':lock warn'}, {text = '?? Úãá˜ÑÏ ÇÎØÇÑ ??', callback_data = chat..'_warn'}
        },{
          {text = '??ÍÏÇ˜ËÑ ÊÚÏÇÏ ÇÎØÇÑ?? : '..tostring(WARN_MAX)..' wrn', callback_data = chat..'_WARN_MAX'}
                },{
          {text='??',callback_data=chat..':lock WARNMAXdown'},{text='??',callback_data=chat..':lock WARNMAXup'}
                },{
                 {text=getsettings('spam'),callback_data=chat..':lock spam'}, {text = '?? Úãá˜ÑÏ ÇÓã ??', callback_data = chat..'_spam'}
                },{
                 {text = '??ÍÏÇ˜ËÑ ÒãÇä ÇÓã?? : '..tostring(TIME_MAX)..' Sec', callback_data = chat..'_TIME_MAX'}
                },{
                  {text='??',callback_data=chat..':lock TIMEMAXdown'},{text='??',callback_data=chat..':lock TIMEMAXup'}
                  },{
                 {text = '??ÍÏÇ˜ËÑ ÊÚÏÇÏ ÇÓã?? : '..tostring(MSG_MAX)..' Msg', callback_data = chat..'_MSG_MAX'}
                },{
                  {text='??',callback_data=chat..':lock MSGMAXdown'},{text='??',callback_data=chat..':lock MSGMAXup'}
                  },{
                  {text='?ÔÇÑ Ñæå? : '..getsettings('charge'),callback_data=chat..'_charge'}
                },{
                  {text = '??ÈÑÔÊ Èå ÕİÍå Çæá1??', callback_data = 'left_page:'..chat},{text = '??ÈÑÔÊ Èå ãäæ? ÇÕá???', callback_data = 'firstmenu:'..chat}
                }
              }
              edit(q.inline_message_id,'_?? ÊäÙ?ãÇÊ ??_\n`??ÕİÍå Ïæã 2 ??`\n@LockerTeam',keyboard)
            end
            else Canswer(q.id,'??Your Not Admin??\n @LockerTeam',true)
						end
						end
          if msg.message and msg.message.date > (os.time() - 5) and msg.message.text then
     end
      end
    end
  end
    end
	end

return run()
