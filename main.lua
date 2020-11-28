require("TSLib")
require("BaseClass")
require("tigerMec")
require("PointLib")

local AppName="com.xique.UndergroundWarriors";
local width,height=getScreenSize();
--local touch = touch() 
function _UserSetting()

-- body
	setAssistiveTouchEnable(false)

	UINew(1,"地下城高爆版","运行","退出","xma",1,300,height,width,"255,255,255","255,255,255","","number",1)
	UILabel(1,"调试【开启将降低运行效率】",18,"center","255,0,0")
	UIRadio(1,"ts","开启,关闭","0")
	UIRadio(1,"mode","起号,练级","0")
	UICheck("check1,check4,check5,check6","福利,套装,邮件,成就")

	UICheck("check11,check12,check13,check14,check15","骑宠,神器,锻造,境界,符文")

	UICheck("check23,check24,check26","神谕BOSS,万魔塔,高手约战")

	UICheck("check31,check32,check33,check34,check35,check36,check37,check38","主线任务,资源找回,经验丹,转职,补挂机卡,吞噬,设置,活跃")
	UICheck("check41,check42,check43,check44,check45,check46,check47","赏金任务,星空秘境,诛仙血阵,守护圣灵,神仆扫荡,竞技场,深海宝库")
	UIShow();

	if ts == "开启" then
		_DebugSwitch = true;
	else
		_DebugSwitch = false;
	end
end

--初始化屏幕
function _InitScreenSize()

	if width==750 and height ==1334 then
		toast("屏幕初始化成功",1);
		_Feature()

		setBacklightLevel(0.5);
		toast("亮度调整完成",1)
	else
		dialog("不支持您的手机型号", 0);
		lua_exit();

	end

end
--初始化
function  _Init()
	-- body
	init(AppName,1);
	_InitScreenSize();
	_UserSetting();
	_GameData();
	_TaskDate()
end

function _GameData()
	游戏参数 = 
	{
		["当前区"] = 1,
		["当前角色"] = 1,
	}
end

function _checkBox()
	-- body
	if(check37=="设置")then
		任务参数.设置=任务类型.未开始
	end
	if(check34=="转职")then
		任务参数.转职=任务类型.未开始
	end
	if (check32=="资源找回") then
		任务参数.资源找回=任务类型.未开始
	end

	if(check26=="高手约战") then
		任务参数.高手约战=任务类型.未开始
	end

	if (check25=="万魔塔") then
		任务参数.万魔塔=任务类型.未开始
	end
	if (check31=="主线任务") then
		任务参数.主线任务=任务类型.未开始
	end
	if(check33=="经验丹") then
		任务参数.经验丹=任务类型.未开始
	end
	if (check4=="套装") then
		任务参数.套装=任务类型.未开始
	end
	if(check14=="境界") then
		任务参数.境界=任务类型.未开始
	end
	if(check12=="神器") then
		任务参数.神器=任务类型.未开始
	end
	if(check15=="符文") then
		任务参数.符文=任务类型.未开始
	end
	if (check11=="骑宠") then
		任务参数.骑宠=任务类型.未开始
	end
	if (check13=="锻造") then
		任务参数.锻造=任务类型.未开始
	end
	if(check36=="吞噬") then
		任务参数.吞噬=任务类型.未开始
	end
	if (check1=="福利") then
		任务参数.福利=任务类型.未开始
	end
	if (check38=="活跃") then
		任务参数.活跃=任务类型.未开始
	end
	if (check6=="成就") then
		任务参数.成就=任务类型.未开始
	end
	if (check35=="补挂机卡") then
		任务参数.补挂机卡=任务类型.未开始
	end

end



opentag=0;
--游戏主流程
function  _GameFlow()
	-- body

	_checkBox()
	_timebreakup()

	while(true) do
		_运行(AppName);
--		_调试("角色选择1");
		_RoleFlow();
--		_调试("角色选择2");

		_表找色点击(Point_t,Point_d);
		_AccTab()

		_unsyn()
		--_realname()
--_DailyActivity()
--_hangup()

		if mode=="练级" then

			if(settingtime==0 and check37=="设置")then
				_setting()
			end

			if (sourbacktime<3 and check32=="资源找回" and 任务参数.设置==任务类型.已完成) then
				_sourceback()
			end

			if(challengetime<3 and check26=="高手约战") then
				_challenge()
			end

			if (thoutowntime<3 and check25=="万魔塔") then
				_thousandtown()
			end
			if (careeruptime<=3 and check34=="转职") then
				_careerUp()
			end
			if (check31=="主线任务" and 任务参数.转职==任务类型.已完成 and 任务参数.主线任务==任务类型.未开始) then
				_mainTask()
			end
			if(expertime<2 and check33=="经验丹" and 任务参数.主线任务==任务类型.已完成) then
				_expereat()
			end
			if (suituptime==0 and check4=="套装" and 任务参数.经验丹==任务类型.已完成) then
				_suitUp()
			end
			if(roleuptime==0 and check14=="境界" and 任务参数.套装==任务类型.已完成) then
				_roleUp()
			end
			if(guntime==0 and check12=="神器" and 任务参数.境界==任务类型.已完成) then
				_gunUp()
			end
			if(wordsuptime<2 and check15=="符文" and 任务参数.神器==任务类型.已完成) then
				_wordsUp()
			end
			if (petuptime==0 and check11=="骑宠" and 任务参数.符文==任务类型.已完成) then
				_petUp()
			end
			if (stuptime<2 and check13=="锻造" and 任务参数.骑宠==任务类型.已完成) then
				_strengthUp()
			end
			if(swuptime==0 and check36=="吞噬" and 任务参数.锻造==任务类型.已完成) then
				_swallowup()
			end
			if (weltime<2 and check1=="福利" and 任务参数.吞噬==任务类型.已完成) then
				_welfare()
			end
			if (dailyrewtime<2 and check38=="活跃" and 任务参数.福利==任务类型.已完成) then
				_dailyreward()
			end
			if (agcount==0 and check6=="成就" and 任务参数.活跃==任务类型.已完成) then
				_achieveGet()
			end
			if (hanguptime<2 and check35=="补挂机卡" and 任务参数.成就==任务类型.已完成) then
				_hangup()
			end
			if _找色(Task_daily.点击解锁) or _找色(Task_daily.设置取消) or 任务参数.补挂机卡==任务类型.已完成 or opentag>50 or getNetTime()-time>60*1000*10 then
				_timeOut()
			end
		else
			if (check31=="主线任务" and 任务参数.转职==任务类型.已完成 and 任务参数.主线任务==任务类型.未开始) then
				_mainTask()
			end
			if (weltime<2 and check1=="福利" and 任务参数.主线任务==任务类型.已完成) then
				_welfare()
			end
			if (dailyrewtime<2 and check38=="活跃" and 任务参数.福利==任务类型.已完成) then
				_dailyreward()
			end
			if (agcount==0 and check6=="成就" and 任务参数.活跃==任务类型.已完成) then
				_achieveGet()
			end
			if (hanguptime<2 and check35=="补挂机卡" and 任务参数.成就==任务类型.已完成) then
				_hangup()
			end
			if _找色(Task_daily.点击解锁) or _找色(Task_daily.设置取消) or 任务参数.补挂机卡==任务类型.已完成 or opentag>50 or getNetTime()-time>60*1000*10 then
				_timeOut()
			end
		end


		_teamUp()
		if check5=="邮件" then
			_MailAward()
		end
		_card()
		_acplan()
		_inspire()
		_rewards()
		if (_找色(career.转职)==false and _找色(career.收拢)==true and godChangetime==0 and check23=="神谕BOSS") or (careeruptime>3 and godChangetime==0  and check23=="神谕BOSS")then
			_godChange();
		end

		_battleStep()
		_godStep()
		_tiger()
		_godrelease()
		mSleep(1000);
		if(settingtime>0 and check37=="设置")then
			任务参数.设置=任务类型.已完成
		end
		if (careeruptime>3 and check34=="转职") then
			任务参数.转职=任务类型.已完成
		end
		if (sourbacktime>=3 and check32=="资源找回") then
			任务参数.资源找回=任务类型.已完成
		end

		if(challengetime>=3 and check26=="高手约战") then
			任务参数.高手约战=任务类型.已完成
		end
		if(expertime>=2 and check33=="经验丹") then
			任务参数.经验丹=任务类型.已完成
		end
		if (suituptime>0 and check4=="套装") then
			任务参数.套装=任务类型.已完成
		end
		if(roleuptime>0 and check14=="境界") then
			任务参数.境界=任务类型.已完成
		end
		if(guntime>0 and check12=="神器") then
			任务参数.神器=任务类型.已完成
		end
		if(wordsuptime>=2 and check15=="符文") then
			任务参数.符文=任务类型.已完成
		end
		if (petuptime>0 and check11=="骑宠") then
			任务参数.骑宠=任务类型.已完成
		end
		if (stuptime>=2 and check13=="锻造") then
			任务参数.锻造=任务类型.已完成
		end
		if(swuptime>0 and check36=="吞噬") then
			任务参数.吞噬=任务类型.已完成
		end
		if (weltime>=2 and check1=="福利") then
			任务参数.福利=任务类型.已完成
		end
		if (dailyrewtime>=2 and check38=="活跃") then
			任务参数.活跃=任务类型.已完成
		end
		if (agcount>0 and check6=="成就") then
			任务参数.成就=任务类型.已完成
		end
		if (hanguptime>=2 and check35=="补挂机卡") then
			任务参数.补挂机卡=任务类型.已完成
		end


	end
end

function _timebreakup()
	-- body
	time=getNetTime()
	while time==0 do
		time=getNetTime()
	end
end


function _TaskDate()
	任务类型 = 
	{
		["未开始"]="未开始",
		["已完成"]="已完成",
	}
	任务参数 = 
	{
		["神谕禁地"] = 任务类型.已完成;
		["日常任务"] = 任务类型.已完成;
		["主线任务"] = 任务类型.已完成;
		["成就"]=任务类型.已完成;
		["设置"] = 任务类型.已完成;
		["资源找回"] = 任务类型.已完成;
		["高手约战"] = 任务类型.已完成;
		["万魔塔"]=任务类型.已完成;
		["经验丹"] = 任务类型.已完成;
		["套装"] = 任务类型.已完成;
		["境界"] = 任务类型.已完成;
		["神器"]=任务类型.已完成;
		["符文"] = 任务类型.已完成;
		["骑宠"] = 任务类型.已完成;
		["锻造"] = 任务类型.已完成;
		["成就"]=任务类型.已完成;
		["吞噬"] = 任务类型.已完成;
		["福利"] = 任务类型.已完成;
		["活跃"] = 任务类型.已完成;
		["补挂机卡"]=任务类型.已完成;
		["转职"]=任务类型.已完成;
	}

end
dailyrewtime=0
function _dailyreward()
	-- body
	_timebreakup()
	local result,x,y;
	result,x,y = _多点找色(Task_daily.日常活动,Scope.日常,70);
	local results,xs,ys;
	results,xs,ys = _多点找色(Task_daily.日常活动2,Scope.日常,70);
	if(results==true) then
		result=results
		x=xs
		y=ys
	end
	if (result==true) then 
		_调试("日常活跃度奖励");
		mSleep(1000)
		--if _找色(Task_daily.日常活动) then
		_点击({x,y})


		mSleep(1000);
		_调试("限时活动");
		_找色点击(dailyreward.限时活动,dailyreward.限时活动[1])
		dailyrewtime=dailyrewtime+1
		mSleep(1000)
	end
	if _找色(dailyreward.限时活动选中) then
		mSleep(1000)
		_点击({  326,  676})
		mSleep(1000)
		_点击({  326,  676})
		mSleep(1000)
		_点击({   517,  677})
		mSleep(1000)
		_点击({   517,  677})
		mSleep(1000)
		_点击({  717,  682})
		mSleep(1000)
		_点击({  717,  682})
		mSleep(1000)
		_点击({  920,  678})
		mSleep(1000)
		_点击({  920,  678})
		mSleep(1000)
		_点击({ 1094,  676})
		mSleep(1000)
		_点击({ 1094,  676})
		_调试("退出")
		mSleep(1000)
		_点击({ 1290,   31})
		mSleep(1000)
	end
end
hanguptime=0
function _hangup()
	-- body
	if (_找色(StrengthUp.拓展)) then
		_点击(StrengthUp.拓展[1])
		mSleep(3000)
		opentag=opentag+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		_timebreakup()
		local result,x,y;
		result,x,y = _多点找色(setting.设置,Scope.设置,70);
		if result==false then
			result,x,y = _多点找色(setting.设置2,Scope.设置,70);
		end
		if result==false then
			result,x,y = _多点找色(setting.设置3,Scope.设置,70);
		end

		if (result==true) then 
			_调试("设置")
			mSleep(2000)
			_点击({x,y})
			mSleep(1000)
		end
	end
	if _找色(hangup.离线挂机时间按钮) then
		_调试("离线挂机")
		mSleep(1000)
		_找色点击(hangup.离线挂机时间按钮,hangup.离线挂机时间按钮[1])
		mSleep(1000)

		mSleep(1000)
	end
	if _找色(hangup.离线挂机卡批量使用) then
		_调试("离线挂机卡批量使用")
		hanguptime=hanguptime+1
		mSleep(1000)
		_找色点击(hangup.离线挂机卡批量使用,hangup.离线挂机卡批量使用[1])
		mSleep(1000)
		_点击({ 1301,   45})
		mSleep(1000)
	end
	mSleep(1000)
	if _找色(hangup.离线挂机卡2) then
		_调试("离线挂机卡2")
		_找色点击(hangup.离线挂机卡2,hangup.离线挂机卡2[1])
		hanguptime=hanguptime+1
		mSleep(1000)
		_点击({  591,  629})
		mSleep(1000)
		_点击({  807,  687})
		mSleep(1000)
		_点击({ 1205,   76})
		mSleep(1000)
	end
	mSleep(1000)
	if _找色(hangup.离线挂机卡) then
		_调试("离线挂机卡")
		_找色点击(hangup.离线挂机卡,hangup.离线挂机卡[1])
		hanguptime=hanguptime+1
		mSleep(1000)
		_点击({   819,  531})
		mSleep(1000)
		_点击({ 1034,  588})
		mSleep(1000)
		_点击({ 1205,   76})
		mSleep(1000)
	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
	--	if _找色(hangup.离线挂机卡2) then
	--		_找色点击(hangup.离线挂机卡2,hangup.离线挂机卡2[1])
	--		mSleep(1000)
	--		_点击({  591,  629})
	--		mSleep(1000)
	--		_点击({  807,  687})
	--	end
end

function _timeOut()
	-- body

	游戏参数.当前角色=游戏参数.当前角色+1;

	_调试("游戏参数.当前角色"..游戏参数.当前角色);
	closeApp(AppName);
	agcount=0
	godChangetime=0
	offcardtime=0
	godsteptime=0
	swuptime=0
	stuptime=0
	guntime=0
	petuptime=0
	roleuptime=0
	suituptime=0
	careeruptime=0
	thoutowntime=0
	wordsuptime=0
	challengetime=0
	expertime=0
	godChangetime=0
	hanguptime=0
	dailyrewtime=0
	sourbacktime=0
	weltime=0
	time=getNetTime()
	while time==0 do
		time=getNetTime()
	end
	settingtime=0
	opentag=0
	_timebreakup()
	_checkBox()


end


function _acplan()
	if (_找色(Point_t.任务完成)==true) then
		mSleep(1000)
		_调试("43任务")
		_点击(Point_d.任务完成)
	end
	-- body
end
sourbacktime=0
function _sourceback()
	-- body
sourbacktime=sourbacktime+1
	local result,x,y;
	result,x,y = _多点找色(Task_daily.日常活动,Scope.日常,70);
	local results,xs,ys;
	results,xs,ys = _多点找色(Task_daily.日常活动2,Scope.日常,70);
	if(results==true) then
		result=results
		x=xs
		y=ys
	end
	if (result==true) then 
		_调试("日常活动");
		mSleep(1000)
		--if _找色(Task_daily.日常活动) then
		_点击({x,y})

		_timebreakup()
		mSleep(1000);
		_调试("资源找回");
		_找色点击(sourceback.资源找回,sourceback.资源找回[1])
		sourbacktime=sourbacktime+1
	end
	mSleep(1000)
	if(_找色(sourceback.已找回)) then
		_调试("查看更多")
		mSleep(1000)
		touchDown(  999,  521)
		mSleep(30)
		touchMove(  989,  412)
		mSleep(30)
		touchMove( 1000,  267)
		mSleep(30)
		touchUp(  1000,  267)
	end
	if(_找色(sourceback.资源找回页)) then
		_调试("资源找回")
		_点击({  540,  153})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
		_点击({   1131,  151})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
		_点击({    533,  305})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
		_点击({  1125,  300})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
		_点击({   531,  445})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
		_点击({  1128,  451})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
		_点击({   527,  602})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
		_点击({   1125,  601})
		mSleep(1000)
		_点击({  790,  500})
		mSleep(1000)
		_点击({  879,  631})
		mSleep(1000)
	end
	if(_找色(sourceback.资源找回页)) then
		_调试("退出")
		_点击({ 1282,   31})
		mSleep(1000)
	end
end



expertime=0
function _expereat()
	-- body
expertime=expertime+1
	if(_找色(achievement.背包)==true) then 
		mSleep(1000)
		_调试("背包")
		_点击(achievement.背包[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
		expertime=expertime+1
	end
	if _找色(experienceeat.刷新) then
		_点击(experienceeat.刷新[1])
		mSleep(6000)
		_调试("寻找经验丹")
		_timebreakup()
	end
	local result,x,y;
	result,x,y = _多点找色(experienceeat.经验丹红,Scope.经验丹,70);
	if (result==true) then 
		_调试("经验丹")
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
		_点击({x+23,y+98})
		mSleep(1000)
	end
	result,x,y = _多点找色(experienceeat.经验丹黄,Scope.经验丹,70);
	if (result==true) then 
		_调试("经验丹")
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
		_点击({x+23,y+98})
		mSleep(1000)
	end
	result,x,y = _多点找色(experienceeat.经验丹蓝,Scope.经验丹,70);
	if (result==true) then 
		_调试("经验丹")
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
		_点击({x+23,y+98})
		mSleep(1000)
	end
	result,x,y = _多点找色(experienceeat.经验丹紫,Scope.经验丹,70);
	if (result==true) then 
		_调试("经验丹")
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
		_点击({x+23,y+98})
		mSleep(1000)
	end
	if(_找色(achievement.背包页)) then
		_调试("经验使用结束，退出")
		mSleep(1000)
		_点击({ 1292,   32})
		mSleep(1000)
	end


end

challengetime=0
function _challenge()
	-- body

	local result,x,y;
	result,x,y = _多点找色(challenge.高手约战,Scope.高手约战,70);
	if (result==true) then 
		_调试("高手约战")
		mSleep(2000)
		_点击({x,y})
		mSleep(1000)
		challengetime=challengetime+1
	end
	if (_找色(challenge.确认)) then
		_调试("确认")
		mSleep(1000)
		_点击(challenge.确认[1])
		mSleep(1000)
	end
	if (_找色(challenge.无约战)) then
		_调试("无约战")
		mSleep(1000)
		_点击({ 1200,  120})
		mSleep(1000)
	end
end
settingtime=0
function _setting()
	-- body
settingtime=settingtime+1
	if (_找色(StrengthUp.拓展)) then
		_点击(StrengthUp.拓展[1])
		mSleep(3000)
		opentag=opentag+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		local result,x,y;
		result,x,y = _多点找色(setting.设置,Scope.设置,70);
		if result==false then
			result,x,y = _多点找色(setting.设置2,Scope.设置,70);
		end
		if result==false then
			result,x,y = _多点找色(setting.设置3,Scope.设置,70);
		end
		if (result==true) then 
			_调试("设置")
			mSleep(2000)
			_点击({x,y})
			mSleep(1000)
			_timebreakup()
		end
		if(_找色(setting.挂机设置页)) then
			mSleep(1000)
			_找色点击(setting.自动弑神,setting.自动弑神[1])
			mSleep(1000)
			_找色点击(setting.自动暗器,setting.自动暗器[1])
			mSleep(1000)
			_找色点击(setting.基本设置按钮,setting.基本设置按钮[1])
			mSleep(1000)


		end
		if(_找色(setting.基本设置页)) then
			mSleep(1000)
			_找色点击(setting.屏蔽怪物,setting.屏蔽怪物[1])
			mSleep(1000)
			_找色点击(setting.屏蔽雪花,setting.屏蔽雪花[1])
			mSleep(1000)
			_找色点击(setting.屏蔽他人,setting.屏蔽他人[1])
			mSleep(1000)
			_找色点击(setting.关闭震屏,setting.关闭震屏[1])
			mSleep(1000)
			_找色点击(setting.屏蔽9朵花,setting.屏蔽9朵花[1])
			mSleep(1000)
			_找色点击(setting.屏蔽称号,setting.屏蔽称号[1])
			mSleep(1000)
			_找色点击(setting.静音,setting.静音[1])
			mSleep(1000)
			_调试("设置完成，退出")
			mSleep(1000)
			_点击({1300,   45})
			settingtime=settingtime+1
		end
	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
end


wordsuptime=0
function _wordsUp()
	-- body
wordsuptime=wordsuptime+1
	if (_找色(StrengthUp.拓展)) then
		_点击(StrengthUp.拓展[1])
		mSleep(3000)
		opentag=opentag+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		wordsuptime=wordsuptime+1
		local result,x,y;
		result,x,y = _多点找色(words.符文,Scope.符文,70);
		if (result==true) then 
			_调试("符文强化")
			mSleep(2000)
			_点击({x,y})
			mSleep(1000)
			_timebreakup()
		end
	end
	result,x,y = _多点找色(words.符文空位,Scope.符文空位,70);
	if (result==true) then 
		_调试("符文空位")
		mSleep(2000)
		_点击({x,y})
		mSleep(1000)
		_点击({  957,  139})
	end
	if (_找色(words.符文页) and result==false) then
		_点击({  434,  105})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])	
		mSleep(1000)
		_点击({  607,  183})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])	
		mSleep(1000)
		_点击({  681,  353})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])
		mSleep(1000)
		_点击({  613,  540})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])	
		mSleep(1000)
		_点击({  428,  614})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])	
		mSleep(1000)
		_点击({  254,  537})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])	
		mSleep(1000)
		_点击({  177,  355})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])	
		mSleep(1000)
		_点击({  253,  176})
		mSleep(1000)
		_找色点击(words.升级,words.升级[1])
		mSleep(1000)
		_点击({ 1287,   32})
	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
end

roleuptime=0
function _roleUp()
	-- body
roleuptime=roleuptime+1
	if (_找色(StrengthUp.拓展)) then
		_点击(StrengthUp.拓展[1])
		mSleep(3000)
		roleuptime=roleuptime+1
		opentag=opentag+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		local result,x,y;
		result,x,y = _多点找色(StrengthUp.角色,Scope.强化,70);
		if result ==false then
			result,x,y = _多点找色(StrengthUp.角色2,Scope.强化,70);
		end
		if (result==true) then 
			_调试("角色强化")
			mSleep(2000)
			_点击({x,y})
			mSleep(1000)
			_timebreakup()
		end
		if (_找色(StrengthUp.境界)) then
			_调试("境界")
			_点击(StrengthUp.境界[1])
			mSleep(1000)
			if (_找色(StrengthUp.境界提升)) then
				_调试("境界提升")
				_点击(StrengthUp.境界提升[1])
				mSleep(1000)
				_点击({ 1182,  108})
				_调试("退出角色界面")
				mSleep(1000)
				_点击({ 1285,   36})
			end
		else
			_调试("退出角色界面")
			mSleep(1000)
			_点击({ 1285,   36})
		end
		roleuptime=roleuptime+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
end
weltime=0
function _welfare()
	-- body
weltime=weltime+1
	local result,x,y;
	result,x,y = _多点找色(welfare.福利,Scope.福利,70);
	if (result==true) then 
		_调试("福利")
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
		weltime=weltime+1
		_timebreakup()
	end
	if _找色(welfare.领取) then
		_调试("领取")
		mSleep(1000)
		_点击(welfare.领取[1])
		mSleep(1000)
		_点击(welfare.领取[1])
	end
	if _找色(welfare.未达成) then
		_调试("领取完毕，准备退出")
		mSleep(1000)
		_点击({ 1301,   52})
		weltime=weltime+1
	end
	local result,x,y;
	result,x,y = _多点找色(welfare.可领取,Scope.签到,70);
	if (result==true) then 
		_调试("签到")
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
		_点击({ 1300,   61})
	end
	result,x,y = _多点找色(welfare.领取完毕,Scope.签到,70);
	if (result==true) then 
		_调试("签到完毕")
		mSleep(1000)
		_点击({ 1300,   61})
		weltime=weltime+1
	end
	if _找色(welfare.领取奖励) then
		_调试("领取奖励")
		mSleep(1000)
		_点击(welfare.领取奖励[1])
		mSleep(1000)
		_点击(welfare.领取奖励[1])

	end
	if _找色(welfare.冲级豪礼) then
		_调试("冲级豪礼")
		mSleep(1000)
		_点击({ 1180,  284})
		mSleep(1000)
		_点击({ 1180,  284})

	end
	if _找色(welfare.无可领取奖励) then
		_调试("无可领取奖励")
		mSleep(1000)
		_点击({ 1301,   52})
		weltime=weltime+1
	end
	if _找色(welfare.公告领取) then
		_调试("公告领取")
		mSleep(1000)

		touchDown( 1041,  501)
		mSleep(30)
		touchMove( 1033,  421)
		mSleep(30)
		touchMove( 1029,  335)
		mSleep(30)
		touchMove( 1033,  190)
		mSleep(30)
		touchMove( 1038,  130)
		mSleep(30)
		touchUp( 1038,  130)
		_点击(welfare.公告领取[1])
		mSleep(1000)
		_点击(welfare.公告领取[1])
		mSleep(1000)
	end
	if _找色(welfare.公告已领取) then
		_调试("公告奖励已领取")
		mSleep(1000)
		_点击({ 1303,   51})
		weltime=weltime+1
	end
	if _找色(welfare.VIP领取) then
		_调试("VIP领取")
		mSleep(1000)
		_点击(welfare.VIP领取[1])
		weltime=weltime+1
	end
	if _找色(welfare.VIP) then
		_调试("退出VIP福利页")
		mSleep(1000)
		_点击({ 1301,   51})
		weltime=weltime+1
	end
end



suituptime=0
function _suitUp()
	-- body
suituptime=1
	local result,x,y;
	result,x,y = _多点找色(suitUp.套装,Scope.套装,70);
	if (result==true) then 
		_调试("套装")
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
		_timebreakup()
	end
	if _找色(suitUp.立即激活) then
		_调试("立即激活")
		mSleep(1000)
		_点击(suitUp.立即激活[1])
		mSleep(1000)
		_点击(suitUp.立即激活[1])
		mSleep(1000)
		_点击(suitUp.立即激活[1])
		mSleep(1000)
		_点击(suitUp.立即激活[1])
		mSleep(1000)
		suituptime=1
		_点击({ 1295,   36})
	end
	if _找色(suitUp.无法激活) or _找色(suitUp.立即激活) then
		_调试("激活完毕，准备退出")
		mSleep(1000)
		_点击({ 1283,   30})
		suituptime=1
		mSleep(1000)
	end
end

stuptime=0
function _strengthUp()
	-- body
	_timebreakup()
	stuptime=stuptime+1
	if (_找色(StrengthUp.拓展)) then
		_点击(StrengthUp.拓展[1])
		mSleep(3000)
		opentag=opentag+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		local result,x,y;
		result,x,y = _多点找色(StrengthUp.锻造,Scope.强化,70);
		if (result==true) then 
			_调试("锻造强化")
			mSleep(2000)
			_点击({x,y})
			mSleep(1000)
			_timebreakup()
		end

		if _找色(StrengthUp.锻造强化) and _找色(StrengthUp.自动强化) then
			_调试("自动强化")
			mSleep(1000)

			_点击(StrengthUp.自动强化[1])
			mSleep(10000)
			_点击(StrengthUp.自动强化[1])
			mSleep(10000)
			_点击(StrengthUp.自动强化[1])
			mSleep(10000)
			_点击(StrengthUp.自动强化[1])
			mSleep(10000)

			_调试("四连强化完毕,准备退出")
			_点击({ 1288,   31})
			stuptime=stuptime+1
		else
			_调试("无强化，准备退出")
			mSleep(1000)
			_点击({ 1288,   31})
			stuptime=2
		end
	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
end

guntime=0
function _gunUp()
	-- body
guntime=guntime+1
	if (_找色(StrengthUp.拓展)) then
		_点击(StrengthUp.拓展[1])
		mSleep(3000)
		opentag=opentag+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		local result,x,y;
		result,x,y = _多点找色(StrengthUp.神器,Scope.强化,70);
		if result==false then
			result,x,y = _多点找色(StrengthUp.神器2,Scope.强化,70);
		end
		if (result==true) then 
			_调试("神器强化")
			mSleep(2000)
			_点击({x,y})
			mSleep(1000)
			guntime=guntime+1
			_timebreakup()
		end
	end
	if (_找色(StrengthUp.神翼) or _找色(StrengthUp.圣器) or _找色(StrengthUp.神兵)) then
		mSleep(1000)
		_点击({  602,  711})
		mSleep(1000)
		_点击({  695,  711})
		mSleep(1000)
		_点击({  788,  711})
		mSleep(1000)
		_点击({ 1163,  711})
		mSleep(1000)


		_点击({ 1306,  291})
		mSleep(1000)

		_点击({  602,  711})
		mSleep(1000)
		_点击({  695,  711})
		mSleep(1000)
		_点击({  788,  711})
		mSleep(1000)
		_点击({ 1163,  711})
		mSleep(1000)


		_点击({  1302,  412})
		mSleep(1000)

		_点击({  602,  711})
		mSleep(1000)
		_点击({  695,  711})
		mSleep(1000)
		_点击({  788,  711})
		mSleep(1000)
		_点击({ 1163,  711})
		mSleep(1000)
		_点击({ 1279,   29})
		mSleep(1000)

	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
end



petuptime=0
function _petUp()
	-- body
petuptime=petuptime+1
	if (_找色(StrengthUp.拓展)) then
		_点击(StrengthUp.拓展[1])
		mSleep(3000)
		opentag=opentag+1
	end
	if (_找色(StrengthUp.拓展打开)) then
		local result,x,y;
		result,x,y = _多点找色(StrengthUp.骑宠,Scope.强化,70);
		if (result==true) then 
			_调试("骑宠强化")
			mSleep(2000)
			_点击({x,y})
			mSleep(1000)
			petuptime=petuptime+1
			_timebreakup()
		end

	end
	if (_找色(StrengthUp.骑宠坐骑) or _找色(StrengthUp.骑宠精灵)) then
		mSleep(1000)
		_点击({  602,  711})
		mSleep(1000)
		_点击({  695,  711})
		mSleep(1000)
		_点击({  788,  711})
		mSleep(1000)
		_点击({ 1163,  711})

		mSleep(1000)
		_点击({ 1305,  284})
		mSleep(1000)
		_点击({  602,  711})
		mSleep(1000)
		_点击({  695,  711})
		mSleep(1000)
		_点击({  788,  711})
		mSleep(1000)
		_点击({ 1163,  711})
		mSleep(1000)
		_点击({ 1293,  410})
		mSleep(1000)
	end
	if (_找色(StrengthUp.骑宠神仆)) then
		mSleep(1000)
		_点击({  811,  178})
		mSleep(1000)
		_点击({ 1182,  711})
		mSleep(1000)
		_点击({ 1279,   29})
		mSleep(1000)
	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
end
godsteptime=0
function _godStep()
	-- body
	--	local result,x,y;
	--	result,x,y = _多点找色(Task_daily.神仆挑战,Scope.神仆挑战,70);
	--	if (result==true) then 
	--		_调试("找到神仆挑战"..x..","..y);
	--		mSleep(1000)
	--		_点击({x,y});
	--		mSleep(1000)
	--	else
	--		_调试("未找到神仆挑战");
	--	end
	mSleep(3000)
	if _找色(Task_daily.唤潮美鲛)then
		_点击({  187,  424})
		_点击({  364,  182})
		_点击({  679,  205})
		_点击({  506,  447})
		_点击({  821,  507})
		_点击({ 1164,  493})
		mSleep(1000)
	end
	mSleep(1000)
	if _找色(Task_daily.神仆挑战确认)then
		_点击({  684,  612})

		mSleep(1000)
	end

	if _找色(Task_daily.神仆副本) and godsteptime==0 then
		_调试("副本扫荡");
		mSleep(1000)
		_点击(Task_daily.神仆副本[1])
		godsteptime=godsteptime+1
		mSleep(1000)
	end
	if _找色(Task_daily.神仆免费) then
		_调试("开始神仆");
		mSleep(1000)
		_点击(Task_daily.神仆免费[1])
		godsteptime=godsteptime+1
		mSleep(2000)
		_点击({  500,  544})
		mSleep(2000)
		_点击({ 1167,   79})
		mSleep(2000)
		_点击({ 1277,   31})
	end
end
function _battleStep()
	-- body
	if _找色(Task_daily.挑战霸主) then
		_调试("挑战霸主");
		mSleep(1000)
		_点击({  861,  439})
		mSleep(1000)
		_点击({  861,  439})
	end
	if _找色(Task_daily.继续竞技) then
		_调试("继续挑战2");
		mSleep(1000)
		_点击({  748,  564})
	end
	if _找色(Task_daily.竞技结束) then
		_调试("竞技结束");
		mSleep(1000)
		_点击({ 1284,   33})
	end
end

function _MailAward()
	if _找色(Task_daily.邮件奖励) then
		_调试("邮件奖励");
		mSleep(1000)
		_点击(Task_daily.邮件奖励[1])
		mSleep(1000)
		_点击({  104,  669})
		mSleep(1000)
		_点击({ 1129,  671})
		mSleep(1000)
		_点击({1237,   52})
		mSleep(1000)
		_调试("邮件奖励完成");
		mSleep(1000)
	end


end
agcount=0
function _achieveGet()
agcount=agcount+1
	if(_找色(achievement.背包)==true) then 
		mSleep(1000)
		_调试("背包")
		_点击(achievement.背包[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
	end
	if(_找色(achievement.成就)==true) then 
		mSleep(1000)
		_调试("成就")
		_点击(achievement.成就[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})

	end

	if (_找色(achievement.背包页) and _找色(achievement.成就)==false) then
		_调试("无成就，准备退出")
		_点击({ 1282,   31})

		agcount=agcount+1

	end
	--	local result,x,y;
	--	result,x,y = _多点找色(achievement.领奖,Scope.领奖,70);
	--	if(result) then
	--		_调试("领奖")
	--		mSleep(1000)
	--		_点击({x,y})
	--		mSleep(1000)
	--		_点击({650,600})
	--		_点击({650,600})
	--		_点击({650,600})


	--	end
	while _找色(achievement.领奖) do
		_点击(achievement.领奖[1])
		mSleep(1000)
		_点击({650,600})
		mSleep(1000)
		_点击({ 1172,  457})
		mSleep(1000)
		_点击({650,600})
		mSleep(1000)
		_点击({ 1171,  575})
		mSleep(1000)
		_点击({650,600})
		mSleep(1000)
		_点击({ 1169,  705})
		mSleep(1000)
		_点击({650,600})
		mSleep(2000)
	end

	if(_找色(achievement.成就界面)) then
		_调试("退出")
		_点击({ 1282,   31})

		agcount=agcount+1
		mSleep(1000)

	end

	mSleep(1000)

end
thoutowntime=0
function _thousandtown()
	-- body
	local result,x,y;
	result,x,y = _多点找色(thousandtown.副本,Scope.套装,70);
	if(result) then 
		mSleep(1000)
		_调试("副本")
		_点击({x,y})
		mSleep(1000)

	end
	if(_找色(thousandtown.万魔塔)==true) then 
		mSleep(1000)
		_调试("万魔塔")
		_点击(thousandtown.万魔塔[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
	end
	if(_找色(thousandtown.挑战)==true) then 
		mSleep(1000)
		_调试("挑战")
		_点击(thousandtown.挑战[1])
		mSleep(1000)
		thoutowntime=thoutowntime+1
		--rewardtag=1
		--_点击({ 977,  174})
	end
	if(_找色(thousandtown.继续挑战)==true) then 
		mSleep(1000)
		_调试("继续挑战1")
		_点击(thousandtown.继续挑战[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
	end
	if(_找色(thousandtown.离开副本)==true) then 
		mSleep(1000)
		_调试("离开副本")
		_点击(thousandtown.离开副本[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
	end
end
careeruptime=0
function _careerUp()
	-- body
	careeruptime=careeruptime+1
	local result,x,y;
	result,x,y = _多点找色(career.转职,Scope.转职,70);
	if result==false then
		result,x,y = _多点找色(career.转职2,Scope.转职,70);
		end
	if(result) then 
		mSleep(1000)
		_调试("转职")
		_点击({x,y})
		mSleep(1000)
		careeruptime=careeruptime+1
	end

	if(_找色(career.立即前往)==true) then 
		mSleep(1000)
		_调试("立即前往")
		_点击(career.立即前往[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
	end
end
swuptime=0
function _swallowup()
	-- body
	swuptime=swuptime+1
	if(_找色(achievement.背包)==true) then 
		mSleep(1000)
		_调试("背包")
		_点击(achievement.背包[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
	end
	if(_找色(achievement.吞噬页)==true) then 
		mSleep(1000)
		_调试("吞噬页")
		_点击(achievement.吞噬页[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})

	end
	if(_找色(achievement.吞噬)==true) then 
		mSleep(1000)
		_调试("吞噬")
		_点击(achievement.吞噬[1])
		mSleep(1000)

	end
	if(_找色(achievement.装备吞噬)==true) then 
		if(_找色(achievement.橙色装备)==false) then 
			mSleep(1000)
			_调试("选中橙色装备")
			_点击({  308,  603})
			mSleep(1000)
			_点击({   292,  521})
			mSleep(1000)

		end
		if(_找色(achievement.选中一星)==false) then 
			mSleep(1000)

			_点击(achievement.选中一星[1])
			_调试("选中一星")
			mSleep(1000)
		end
	end

	if (_找色(achievement.橙色装备) and _找色(achievement.选中一星)) then
		mSleep(1000)
		_调试("确认吞噬")
		_点击(achievement.确认吞噬[1])
		mSleep(1000)
		_调试("吞噬结束，准备退出")
		_点击({ 1284,   36})
		mSleep(1000)
		swuptime=swuptime+1
	end
	if(_找色(achievement.无吞噬目标)) then 
		mSleep(1000)
		_调试("无吞噬目标，准备退出")
		_点击({ 1087,  123})
		mSleep(1000)
		_点击({ 1284,   36})
		mSleep(1000)
		swuptime=swuptime+1
	end
end

local count=0;
function _DailyActivity()
	-- body
	--_调试("tagtAGtag"..tag);
	mSleep(1000)
	if _找色(Task_daily.炼体神功) then
		count=count+1;
		_调试("炼体神功"..count);

		if(count>=3) then
			mSleep(1000);
			_点击(Task_daily.炼体神功退出[1])
			count=0;
		end;

	end
	if _找色(Task_daily.守护圣灵) then
		count=count+1;
		_调试("守护圣灵"..count);

		if(count>=3) then
			mSleep(1000);
			_点击(Task_daily.守护圣灵退出[1])
			count=0;
		end;
	end

	local result,x,y;
	result,x,y = _多点找色(Task_daily.日常活动,Scope.日常,70);
	local results,xs,ys;
	results,xs,ys = _多点找色(Task_daily.日常活动2,Scope.日常,70);
	if(results==true) then
		result=results
		x=xs
		y=ys
	end
	if (result==true) then 


		--if _找色(Task_daily.日常活动) then
		_点击({x,y})
		_调试("日常活动");

		mSleep(1000);
		if _找色(Task_daily.炼体升级) then
			_调试("可升级");
			mSleep(1000);
			_点击({  468,  710});

		end
		if (check41=="赏金任务") then
			local result,x,y;
			result,x,y = _多点找色(Task_daily.赏金任务,Scope.深海宝库,70);
			if (result==true) then 
				_调试("找到赏金任务");
				mSleep(1000);
				_点击({x,y});
				_调试("赏金任务");
				mSleep(60000);
			else 
				_调试("未找到赏金任务");
			end
		end
		if (check42=="星空秘境") then
			local result,x,y;
			result,x,y = _多点找色(Task_daily.星空秘境,Scope.深海宝库,70);
			if (result==true) then 
				_调试("找到星空秘境");
				_点击({x,y});
				_调试("星空秘境");
				mSleep(1000);
				_card()
				--_找色点击(Task_daily.星空秘境单人进入,Task_daily.星空秘境单人进入[1]);
				--mSleep(60000);
			else 
				_调试("未找到星空秘境");
			end
		end
		if (check43=="诛仙血阵") then
			local result,x,y;
			result,x,y = _多点找色(Task_daily.诛仙血阵,Scope.深海宝库,70);
			if (result==true) then 
				_调试("找到诛仙血阵"..x..","..y);
				mSleep(1000)
				_点击({x,y});
				mSleep(1000)
				_找色点击(Task_daily.诛仙血阵队伍进入,Task_daily.诛仙血阵队伍进入[1]);
				mSleep(1000)
				_teamUp()
			else
				_调试("未找到诛仙血阵");
			end
		end
		if (check44=="守护圣灵") then
			local result,x,y;
			result,x,y = _多点找色(Task_daily.守护圣灵,Scope.深海宝库,65);
			if result==false then
				result,x,y = _多点找色(Task_daily.守护圣灵2,Scope.深海宝库,65);
			end
			if (result==true) then 
				_调试("找到守护圣灵"..x..","..y);
				mSleep(1000)
				_点击({x,y});
				mSleep(1000)
				_找色点击(Task_daily.守护圣灵单人进入,Task_daily.守护圣灵单人进入[1]);
				mSleep(1000)
			else
				_调试("未找到守护圣灵");
			end
		end
		if (check45=="神仆扫荡") then
			local result,x,y;
			result,x,y = _多点找色(Task_daily.神仆扫荡,Scope.深海宝库,70);
			if (result==true and godsteptime==0) then 
				_调试("找到神仆扫荡"..x..","..y);
				mSleep(1000)
				_点击({x,y});
				mSleep(1000)
				_godStep()
			else
				_调试("未找到神仆扫荡");
			end
		end
		if (check47=="深海宝库") then
			_deepSea()
		end
		if (check46=="竞技场") then
			local result,x,y;
			result,x,y = _多点找色(Task_daily.竞技场,Scope.深海宝库,70);
			if (result==true) then 
				_调试("找到竞技场"..x..","..y);
				mSleep(1000)
				_点击({x,y});
				mSleep(1000)
				_battleStep()
			else
				_调试("未找到竞技场");
			end
		end
		if(_找色(Task_daily.赏金任务)==false and _找色(Task_daily.星空秘境)==false and _找色(Task_daily.守护圣灵)==false and _找色(Task_daily.深海宝库)==false and _找色(Task_daily.炼体神功页标)==true) then
			--tag=1;
			_调试("日常已完成");
			mSleep(1000)
			_点击({1287,   29})
			mSleep(1000)
			--_Monster();
			任务参数.主线任务=任务类型.已完成
		end

	end


end
offcardtime=0
function _offcard()
	-- body
	local result,x,y;
	result,x,y = _多点找色(Task_daily.商城,Scope.商城,70);
	if(result) then
		mSleep(1000)
		_点击({x,y})
		mSleep(1000)
	end

	if(_找色(Task_daily.绑钻商城)==true) then
		_调试("绑钻商城")
		_点击(Task_daily.绑钻商城[1])
	end
	mSleep(1000)
	local result,x,y;
	result,x,y = _多点找色(Task_daily.离线挂机卡,Scope.离线挂机卡,70);
	if(result) then
		_调试("离线挂机卡")
		_点击(Task_daily.离线挂机卡[1])
		mSleep(1000)
		_找色点击(Task_daily.添加数量,Task_daily.添加数量[1])
		mSleep(1000)
		_找色点击(Task_daily.购买挂机卡,Task_daily.购买挂机卡[1])
		mSleep(1000)
		_点击({954,  446})
		mSleep(1000)
		_点击({1206,   76})
		offcardtime=offcardtime+1
		mSleep(1000)
	else
		if(_找色(achievement.商城页)) then
			mSleep(1000)
			_点击({1206,   76})
		end
	end


end
function _mainTask()
	-- body
	if _找色(Task_daily.主线任务) or _找色(Task_daily.主线任务2) or _找色(Task_daily.主线任务3) then
		_点击(Task_daily.主线任务[1])
		mSleep(1000)
		_调试("主线任务");
		mSleep(1000)

		if(_找色(Task_daily.主线立即前往)==true) then

			_找色点击(Task_daily.主线立即前往,Task_daily.主线立即前往[1]);
			_调试("开始主线任务");
			mSleep(30000);
		else

			_点击({ 1299,   51});
			_调试("结束主线任务");
			mSleep(1000);
			_DailyActivity()
			mSleep(1000)
		end
	end
	--_找色点击(Task_daily.主线任务,Task_daily.主线任务[1]);


end
starteamtime=0
function _unsyn()
	-- body,脚本为同步
	if _找色(Task_daily.任务页) then
		_调试("脚本指令未同步1")
		mSleep(1000)
		_点击({ 1300,   48})
	end
	if _找色(Task_daily.卡点页)  then

		if _找色(Task_daily.竞技场页) or _找色(Task_daily.守护圣灵页) or _找色(Task_daily.诛仙血阵页) or _找色(achievement.领奖)then
			mSleep(1000)
		else
			_调试("脚本指令未同步2")
			mSleep(1000)
			_点击({ 1283,   31})
			mSleep(1000)
		end
	end

	--	if (_找色(Task_daily.卡点页) and _找色(Task_daily.守护圣灵页)==false) then
	--		_调试("脚本指令未同步2.5")
	--		mSleep(1000)
	--		_点击({ 1283,   31})
	--		mSleep(1000)
	--	end
	--	if (_找色(Task_daily.卡点页) and _找色(Task_daily.诛仙血阵页)==false) then
	--		_调试("脚本指令未同步2.6")
	--		mSleep(1000)
	--		_点击({ 1283,   31})
	--		mSleep(1000)
	--	end
	if _找色(Task_daily.卡点页2) then
		_调试("脚本指令未同步3")
		mSleep(1000)
		_点击({1297,   44})
	end
	if _找色(Task_daily.卡点页3) then
		_调试("脚本指令未同步4")
		mSleep(1000)
		_点击({1266,   46})
	end
	if _找色(Task_daily.卡点页4) then
		_调试("脚本指令未同步5")
		mSleep(1000)
		_点击({  1241,   68})
	end
	if _找色(Task_daily.卡点页5) then
		if _找色(welfare.领取) then
			mSleep(1000)
		else
			_调试("脚本指令未同步6")
			mSleep(1000)
			_点击({ 1301,   51})
		end
	end
	if _找色(Task_daily.聊天卡点) then
		_调试("聊天卡点")
		mSleep(1000)
		_点击({  439,  554})
	end
	if _找色(Task_daily.设置卡点) then
		_调试("设置卡点")
		mSleep(1000)
		_点击({ 1303,   45})
	end
	if _找色(Task_daily.精灵页) then
		_调试("脚本指令未同步7")
		mSleep(1000)
		_点击({ 1290,   31})
	end
	if _找色(Task_daily.主宰神殿) then
		_调试("脚本指令未同步8")
		mSleep(1000)
		_点击({ 1300,   48})
	end
	if _找色(Task_daily.合成页) then
		_调试("脚本指令未同步9")
		mSleep(1000)
		_点击({ 1244,   48})
	end
	if _找色(Task_daily.充值页) then
		_调试("脚本指令未同步10")
		mSleep(1000)
		_点击({ 1209,   56})
	end
	if _找色(Task_daily.角色属性页) then
		_调试("脚本指令未同步11")
		mSleep(1000)
		_点击({ 1300,   48})
	end
	if _找色(Task_daily.图鉴页) then
		_调试("脚本指令未同步12")
		mSleep(1000)
		_点击({ 1300,   48})
	end
	if _找色(Task_daily.转职页) then
		_调试("脚本指令未同步13")
		mSleep(1000)
		_点击({ 1222,   50})
	end
	if _找色(Task_daily.副本页) then
		_调试("脚本指令未同步14")
		mSleep(1000)
		_点击({ 1300,   48})
	end
	if _找色(Task_daily.装备吞噬) then
		_调试("脚本指令未同步15")
		mSleep(1000)
		_点击({ 1086,  123})
	end
	if _找色(Task_daily.战天魔) then
		_调试("脚本指令未同步16")
		mSleep(1000)
		_点击({ 1300,   48})
	end
	if _找色(Task_daily.领主页) then
		_调试("脚本指令未同步17")
		mSleep(1000)
		_点击({ 1286,   31})
	end

	if _找色(Task_daily.日常页) then
		_调试("脚本指令未同步18")
		mSleep(1000)
		_点击({ 1286,   31})
	end

	if _找色(Task_daily.星空组队页) then
		starteamtime=starteamtime+1
		if (starteamtime>5) then
			_调试("脚本指令未同步19")
			mSleep(1000)
			_点击({ 1286,   31})
			starteamtime=0
		end
	end
	if _找色(Task_daily.诛仙页) then
		_调试("脚本指令未同步20")
		mSleep(1000)
		_点击({ 1286,   31})
	end
	if _找色(Task_daily.神仆页) then
		_调试("脚本指令未同步21")
		mSleep(1000)
		_点击({ 1286,   31})
	end
	if _找色(words.符文页) then
		_调试("脚本指令未同步22")
		mSleep(1000)
		_点击({ 1287,   32})
	end
	if (_找色(StrengthUp.拓展打开)) then
		_找色点击(StrengthUp.拓展打开,StrengthUp.拓展打开[1])
	end
end
godChangetime=0
function _godChange()
	-- body
	if(_找色(Task_daily.世界BOSS)) then
		_调试("世界BOSS");
		_点击(Task_daily.世界BOSS[1]);
		mSleep(5000)

		if(_找色(Task_daily.神谕禁地)) then
			_调试("神谕禁地");
			_点击(Task_daily.神谕禁地[1]);
			mSleep(5000)
			_调试("刺客之主");
			_点击({  171,  241});
			mSleep(5000)
			if(_找色(Task_daily.神谕禁地立即进入) and _找色(Task_daily.剩余次数)==false and _找色(Task_daily.神谕禁地页) and godChangetime==0) then
				_调试("神谕禁地立即进入");
				_点击(Task_daily.神谕禁地立即进入[1]);
				mSleep(5000)

				if(_找色(Task_daily.神谕禁地进入确认)) then
					_调试("神谕禁地进入确认");
					_点击(Task_daily.神谕禁地进入确认[1]);
					mSleep(5000)
				end
			else
				_调试("等级/次数限制，退出");
				godChangetime=godChangetime+1
				_点击({ 1276,   34});
				mSleep(1000)
				_mainTask();
			end
		end
	else
		mSleep(1000)
		_mainTask();

	end

end


pricetag=0
function _card()
	-- body
	if (_找色(reward.星空副本次数)==true) then
		_调试("无副本次数")
		mSleep(1000)
		_点击({ 1291,   33})
		mSleep(1000)
	end

	if (_找色(priceCard.无星空通行证)==true) then 
		mSleep(1000)
		_点击(priceCard.无星空通行证[1])
		mSleep(1000)

		if(_找色(priceCard.合成星空通行证)==true) then 
			_调试("合成星空通行证")
			mSleep(1000)
			_点击(priceCard.合成星空通行证[1])
			mSleep(1000)


		end
		if(_找色(priceCard.星空通行证一键合成)==true) then 
			mSleep(1000)
			_点击(priceCard.星空通行证一键合成[1])
			mSleep(1000)
			if(_找色(priceCard.星空提示))then
				mSleep(1000)
				_点击({  588,  399})
				mSleep(1000)
				_点击(priceCard.星空提示[1])
				mSleep(1000)
				_点击({  893,  248})
				mSleep(1000)
			end
			_点击({ 1244,   48})
		else

			_点击({ 1244,   48})
			pricetag=1
			mSleep(1000)
			_点击({  239,  711})
			mSleep(1000)
			_调试("购买")
			if(_找色(Task_daily.购买星空)==true) then
				_调试("购买星空")
				_点击(Task_daily.购买星空[1])
			end
			mSleep(1000)
			if(_找色(Task_daily.绑钻商城)==true) then
				_调试("绑钻商城")
				_点击(Task_daily.绑钻商城[1])
			end
			mSleep(1000)
			if(_找色(Task_daily.商城星通证)==true) then
				_调试("商城星通证")
				_点击(Task_daily.商城星通证[1])
			end
			mSleep(1000)
			if(_找色(Task_daily.商星购买)==true) then
				_调试("商星购买")
				_点击(Task_daily.商星购买[1])
				mSleep(1000)
				_点击({ 1203,   75})
			end
			mSleep(1000)
			if (_找色(Task_daily.星空秘境页)) then
				_调试("星空组队")
				_找色点击(Task_daily.星空队伍,Task_daily.星空队伍[1])
				mSleep(1000)
			end

		end

	else

		mSleep(1000)
		if (_找色(Task_daily.星空秘境页)) then
			_调试("星空组队")
			_找色点击(Task_daily.星空队伍,Task_daily.星空队伍[1])
			mSleep(1000)
		end

	end

end

function _teamUp()
	-- body
	if(_找色(Task_daily.诛仙结束)) then
		_调试("诛仙结束")
		mSleep(1000)
		_点击({ 1285,   31})
	end
	if(_找色(Task_daily.创建队伍)) then
		_调试("创建队伍222")
		mSleep(1000)
		_点击(Task_daily.创建队伍[1])
		mSleep(1000)
	end
	if(_找色(Task_daily.世界喊话)) then
		_调试("世界喊话")
		mSleep(1000)
		_点击(Task_daily.世界喊话[1])
		mSleep(10000)
	end
	if(_找色(Task_daily.组队成功)) then
		_调试("组队成功")
		mSleep(1000)
		_点击(Task_daily.进入星空副本[1])
		--mSleep(10000)
		mSleep(1000)
		rewardtag=0
		inspiretag=0
		inspiretime=0
		mSleep(10000)
		_找色点击(Task_daily.进入星空副本,Task_daily.进入星空副本[1])
	end

	if(_找色(Task_daily.退出队伍) and _找色(Task_daily.组队成功)) then
		_调试("退出队伍")
		mSleep(1000)
		_点击(Task_daily.退出队伍[1])
		mSleep(1000)
		_点击({ 1156,  300})
		mSleep(1000)
		_点击({ 1156,  425})
		mSleep(1000)
	end
end


function _deepSea()
	-- body
	local result,x,y;
	result,x,y = _多点找色(Task_daily.深海宝库,Scope.深海宝库,70);
	if result==false then
		result,x,y = _多点找色(Task_daily.深海宝库2,Scope.深海宝库,70);
	end
	if (result==true) then 
		_调试("找到深海宝库"..x..","..y);
		mSleep(1000)
		_点击({x,y});
	else
		_调试("未找到深海宝库");
	end
end

function _Monster()

	_调试("准备野外挂机");
	if(_找色(Task_daily.野外挂机)) then

		_找色点击(Task_daily.野外挂机,Task_daily.野外挂机[1]);
		mSleep(1000);
		_点击({  170,  554});
		_调试("选择挂机地点");
		mSleep(1000);
		_点击({  170,  656});
		_调试("前往挂机");
		mSleep(1000);
		_点击({ 1290,   45});
		_调试("开始野外挂机");
		mSleep(300000)
	else
		_调试("无法野外挂机");
	end
end

function _tiger()
	-- body
	if _找色(Task_daily.老虎机) then 
		_调试("老虎机");
		mSleep(2000)
		touchDown( 1105,  230)
		mSleep(30)
		touchMove( 1105,  280)
		mSleep(30)
		touchMove( 1105,  330)
		mSleep(30)
		touchMove( 1105,  380)
		mSleep(30)
		touchMove( 1105,  430)
		mSleep(30)
		touchMove( 1105,  480)
		mSleep(30)
		touchMove( 1105,  530)
		mSleep(30)
		touchMove( 1105,  580)
		mSleep(30)
		touchUp( 1105,  580)

		--touch():on(1105,  224):move(1105,  595):off()

		--_调试("老虎机ceshi");
		--require("tigerMec")
	end
end
inspiretag=0
inspiretime=0
function _inspire()
	-- body
	if(_找色(reward.星空秘境内)==true and inspiretag==0) then 
		mSleep(1000)
		_找色点击(reward.鼓舞,reward.鼓舞[1])
		mSleep(1000)
		inspiretag=1
	end
	if _找色(reward.鼓舞确认)==true and inspiretime<5 then 

		_点击(reward.鼓舞确认[1])
		mSleep(1000)
		inspiretime=inspiretime+1
	end
	if _找色(reward.鼓舞页) and inspiretime>4 then
		_调试("退出鼓舞")
		mSleep(1000)
		_点击({ 977,  174})

	end
end
rewardtag=0
function _rewards()
	-- body
	--_调试("加成")
	if(_找色(reward.星空秘境内)==true and rewardtag==0) then 
		mSleep(1000)
		_找色点击(reward.效率,reward.效率[1])
		mSleep(1000)
	end
	if(_找色(reward.效率使用)==true) then 
		mSleep(1000)
		_点击(reward.效率使用[1])
		mSleep(1000)
		rewardtag=1
		_点击({ 977,  174})
	end
	if(_找色(reward.效率购买)==true) then 
		mSleep(1000)
		_点击(reward.效率购买[1])
		mSleep(1000)
		--rewardtag=1
		--_点击({ 977,  174})
	end
	if(_找色(reward.效率购买确认)==true) then 
		mSleep(1000)
		_点击(reward.效率购买确认[1])
		mSleep(1000)
		_点击({  979,  179})
		rewardtag=1
		--_点击({ 977,  174})
	end
end
function _godrelease()
	-- body

	if(_找色(Task_daily.领主界面)) then

		local result,x,y;
		result,x,y = _多点找色(Task_daily.已刷新,Scope.神谕,70);


		if (result==true) then 
			_调试("已刷新"..x..","..y);
			_点击({x,y});
			mSleep(60000*2)
			godChangetime=1

		else
			_调试("需刷新");
			mSleep(3000)
			touchDown(  160,  300)
			mSleep(30)
			touchMove( 160,  290)
			mSleep(30)
			touchMove( 160,  280)
			mSleep(30)
			touchUp( 160,  280)
			--mSleep(time)
			mSleep(1000*30)
		end
	end
end

function _RoleFlow()
	if _找色(Role_Choose.进入游戏,80) then
		_调试("角色选择界面");
		mSleep(1000)
		if(游戏参数.当前角色%4==1)then
			mSleep(1000)
			_调试("选择角色1")
			_点击(Role_Choose.角色1);
		end

		if(游戏参数.当前角色%4==2)then
			mSleep(1000)
			_调试("选择角色2")
			_点击(Role_Choose.角色2);
		end
		if(游戏参数.当前角色%4==3)then
			mSleep(1000)
			_调试("选择角色3")
			_点击(Role_Choose.角色3);
		end
		if(游戏参数.当前角色%4==0)then
			mSleep(1000)
			_调试("选择角色4")
			_点击(Role_Choose.角色4);
		end
		mSleep(1000)
		--_找色点击(Role_Choose.创建角色);
		mSleep(1000)
		_调试("选择完成")
		_点击( {1159,  627});
		_找色点击(Role_Choose.进入游戏,Role_Choose.进入游戏[1]);
		_调试("选择角色结束");
	end

end

function _AccReg()
	-- body
	--mSleep(5000)
	if _找色(AccountReg.前往注册) then
		_调试("注册账号")
		mSleep(1000)
		_点击(AccountReg.前往注册[1])
		mSleep(5000)
	end

	if (_找色(AccountReg.注册)==true) then
		_调试("注册")
		mSleep(1000)
		_点击(AccountReg.注册[1])
		mSleep(5000)

	end
	if _找色(AccountReg.进入游戏) then
		_调试("进入游戏")
		mSleep(1000)
		_点击(AccountReg.进入游戏[1])
		mSleep(1000)
	end
	if _找色(AccountReg.实名认证) or _找色(AccountReg.实名认证2)then
		_调试("实名认证")

		_点击({  987,  104})
		mSleep(1000)
	end
end
function _realname()
	-- body
	if _找色(AccountReg.实名认证) or _找色(AccountReg.实名认证2)then
		_调试("实名认证")
		mSleep(1000)
		_点击( {642,  345})
		mSleep(1000)
		_调试("1")
		mSleep(1000)
		_调试("2")
		_点击( {605,  141})
		mSleep(1000)
		_调试("3")
		_点击( {605,  141})
		mSleep(1000)
		inputText("伍欣然")
		mSleep(1000)
		_调试("4")
		_点击({  630,  244})
		mSleep(1000)
		inputText("530121198903119561")
		mSleep(1000)
		_调试("5")
		_点击({  674,  250})
		mSleep(1000)
		_调试("6")
		_点击({  685,  447})
		mSleep(1000)
		inputText("伍欣然")
	end
end
function _AccTab()
	-- body
	if _找色(AccountReg.切换账号按钮) then
		_调试("切换账号")
		mSleep(1000)
		_点击(AccountReg.切换账号按钮[1])
		mSleep(1000)
	end
	if _找色(AccountReg.蓝色切换账号按钮) then
		_调试("切换账号")
		mSleep(1000)
		_点击(AccountReg.蓝色切换账号按钮[1])
		mSleep(1000)
	end
	if _找色(AccountTab.上拉) then
		_调试("上拉")
		mSleep(1000)
		_点击(AccountTab.上拉[1])
		mSleep(1000)
	end
	if _找色(AccountTab.账号登录框) then
		if(游戏参数.当前角色>1 and 游戏参数.当前角色%4==1) then
			mSleep(1000)
			_调试("下拉")
			_找色点击(AccountTab.下拉,AccountTab.下拉[1])
			mSleep(1000)
			if (_找色(AccountTab.第三行)==true) then
				mSleep(1000)
				_点击(AccountTab.上拉[1])
				mSleep(1000)
				_调试("注册账号")
				mSleep(1000)
				_点击(AccountReg.前往注册[1])
				mSleep(1000)
				_AccReg()


			else
				_调试("切换账号")
				mSleep(1000)

				_点击({  635,  504})
				_调试("账号登录")
				mSleep(1000)
				_点击(AccountTab.账号登录[1])
				游戏参数.当前角色=1;
				if (_找色(Point_t.游戏公告)) then
					_调试("游戏公告")
					_点击({ 1263,   72})
					mSleep(1000)
				end
				if (_找色(AccountReg.开始游戏)) then
					_调试("开始游戏")
					_点击({  662,  597})
					mSleep(1000)
				end
			end
		else
			if (_找色(AccountTab.账号登录页)) then
				_调试("账号登录")
				_点击(AccountTab.账号登录[1])
				mSleep(5000)
			end
			if (_找色(Point_t.游戏公告)) then
				_调试("游戏公告")
				_点击({ 1263,   72})
				mSleep(1000)
			end
			if (_找色(AccountReg.开始游戏)) then
				_调试("开始游戏")
				_点击({  662,  597})
				mSleep(1000)
			end
		end
	end

end

_Init();
_GameFlow();