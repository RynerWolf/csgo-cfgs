//Written By Color[STEAM_1:0:44837813]
//DO NOT COPY WITHOUT MY PERMISSION
//Modified by RynerWolf
IncludeScript("ze_roof_adventure/init.nut");

BossN <- "Rock Monster";
BossColor <- "#00FF00";
ticking <- false;
TickRate <- 0.05;
BOSS_HP_TOTAL <- 0.00;
OG_HP <- 0.00;
HP_PERCENT <- 0.00;

function PlayBGM(index)
{
	local message = "message " + BGM[index];EntFire("bgm","StopSound","");
	EntFire("bgm","AddOutput",message,0.01);EntFire("bgm","PlaySound","",0.02);
}

function EnableZMTeleport(i)
{
	EntFire(TELEPORT[i],"Enable","",RandomInt(0,8));
}

function RockMonster()
{
	EntFire("lv3_boss_music_timer","Enable","");
	EntFire("lv3_boss_music_timer","FireTimer","",0.01);
	SpawnCameras("vc",0,337.5,0,Vector(4832,5304,1368),"vt",0,0,0,Vector(5888,4672,977),2.5,0,0);
	SetTimer("lv3_boss_skill_timer",1,5);
	EntFire("lv3_boss_skill_timer","AddOutput","OnTimer functions:RunScriptCode:RockMonsterSkills():0:0",1);
	EntFire("lv3_boss_skill_timer","AddOutput","OnTimer !self:Disable::0:0",1);
	SetTimer("lv3_boss_hp_timer",1,1);
	EntFire("lv3_boss_hp_timer","AddOutput","OnTimer functions:RunScriptCode:ShowBossHP():0:0",1);
	EntFire("functions","RunScriptCode","Start();",1.1);
	EntFire("lv3_teleport_all_9","Enable","");
	EntFire("lv3_break_10","Break","");
	EntFire("_lv3_boss_movie_template","ForceSpawn","");
	EntFire("lv3_boss_add_hp","Enable","");
	EntFire("lv3_boss_add_hp","Kill","",0.5);
	EntFire("functions","RunScriptCode","BOSS_HP_TOTAL2=BOSS_HP_TOTAL;OG_HP=BOSS_HP_TOTAL",1);
	EntFire("global_shake_255","StartShake","");
}

function Start(){ticking = true;Tick();}

function Tick()
{
	if(ticking)
	{
		EntFireByHandle(self, "RunScriptCode", "Tick()", TickRate, null, null);
		EntFireByHandle(self, "RunScriptCode", "CheckHpHud()", 0.00, null, null);
	}
}

function CheckHpHud()
{
	HP_PERCENT = (BOSS_HP_TOTAL/OG_HP)*100;

	if (HP_PERCENT >= 60)
	BossColor = "#00FF00";
	else if (HP_PERCENT >= 25)
	BossColor = "#FFFF00";
	else
	BossColor = "#FF0000";

	if (HP_PERCENT > 0)
	{
		ScriptPrintMessageCenterAll("<font class='fontSize-l'>["+BossN+"]: </font>" + "<font class='fontSize-l' color='" + BossColor + "'>" + BOSS_HP_TOTAL + "</font>"
		+ "<font class='fontSize-l'> (</font><font class='fontSize-l' color='" + BossColor + "'>" + format("%.1f", HP_PERCENT) + "</font><font class='fontSize-l'>%)</font>");
	}
}

function DamageBoss()
{
	BOSS_HP_TOTAL-=1;
}

function RockMonsterSkills()
{
	EntFire("env_sound_global","AddOutput","message ze_roof_adventure/env/skill.mp3");
	EntFire("env_sound_global","StopSound","");EntFire("env_sound_global","PlaySound","",0.01);	
	
	local n = RandomInt(1,100)%7;
	BOSS_SKILL_COUNT++;
	if(BOSS_SKILL_COUNT > 9) n = RandomInt(1,100)%8;
	switch (n)
	{
		case 0:
		EntFire("lv3_boss_skill_rush","Stop","");
		EntFire("lv3_boss_skill_rush","Start","",0.01);
		EntFire("lv3_boss_skill_rush","Stop","",3);
		EntFire("lv3_boss_collision","Disable","",3);
		EntFire("lv3_boss_model","ClearParent","");
		EntFire("lv3_boss_model","SetParent","lv3_boss_move_forward",0.01);
		EntFire("lv3_boss_move_forward","Open","",3);
		EntFire("lv3_boss_model","SetDefaultAnimation","",3);
		EntFire("lv3_boss_model","SetAnimation","idle",3);
		EntFire("lv3_boss_skill_rush_hurt","Enable","",3);
		EntFire("functions","RunScriptCode","RockMonsterRush(1)",3);
		EntFire("lv3_boss_skill_timer","Enable","",3);
		break;
		
		case 1:
		EntFire("lv3_boss_skill_fire","Stop","");
		EntFire("lv3_boss_skill_fire","Start","",0.01);
		EntFire("lv3_boss_skill_fire","Stop","",3);
		EntFire("lv3_boss_model","SetAnimation","attack",3);
		
		if(RandomInt(0,1)) EntFire("lv3_boss_skill_fire_*","AddOutput","origin 5568 4672 784",2.9);
		else EntFire("lv3_boss_skill_fire_*","AddOutput","origin 5440 4672 784",2.9);
		
		EntFire("lv3_boss_skill_fire_p","Start","",3);
		EntFire("lv3_boss_skill_fire_hurt","Enable","",3);
		EntFire("lv3_boss_skill_fire_p","Stop","",8);
		EntFire("lv3_boss_skill_fire_hurt","Disable","",8);
		EntFire("lv3_boss_skill_timer","Enable","",8);
		break;
		
		case 7:
		EntFire("lv3_boss_skill_health","Stop","");
		EntFire("lv3_boss_skill_health","Start","",0.01);
		EntFire("lv3_boss_skill_health","Stop","",3);
		EntFire("lv3_boss_skill_health_trigger","Enable","",1.5);
		EntFire("lv3_boss_skill_health_trigger","Disable","",2);
		EntFire("lv3_boss_skill_timer","Enable","",3);
		BOSS_SKILL_COUNT = 0;
		break;
		
		case 3:
		EntFire("lv3_boss_model","SetAnimation","attack");
		EntFire("lv3_boss_skill_blackhole","Stop","");
		EntFire("lv3_boss_skill_blackhole","Start","",0.01);
		EntFire("lv3_boss_skill_blackhole","Stop","",6);
		EntFire("lv3_boss_skill_blackhole_push","SetPushDirection","0 0 0");
		EntFire("lv3_boss_skill_blackhole_push","Enable","",1);
		EntFire("lv3_boss_skill_blackhole_push","SetPushDirection","0 180 0",4);
		EntFire("lv3_boss_skill_blackhole_push","Disable","",7);
		EntFire("lv3_boss_skill_timer","Enable","",7);
		break;
		
		case 4:
		EntFire("lv3_boss_model","SetAnimation","attack");
		
		local pos = ["5248 4544 784","5248 4800 784","5504 4800 784","5504 4544 784","5760 4544 784","5760 4800 784"];
		for (local i = 0; i < 5; i++)
		{
			local t = RandomInt(0,pos.len()-1);
			EntFire("lv3_boss_skill2_lightning_template","AddOutput","origin "+pos[t],i*0.02);
			EntFire("lv3_boss_skill2_lightning_template","ForceSpawn","",i*0.02+0.01);
			pos.remove(t);
		}
		EntFire("lv3_boss_skill2_lightning","Start","",0.5);
		EntFire("lv3_boss_skill2_lightning","Kill","",4);
		EntFire("lv3_boss_skill2_lightning_hurt","Enable","",3.5);
		EntFire("lv3_boss_skill2_lightning_hurt","Kill","",4);
		EntFire("fade_moment","AddOutput","rendercolor 96 175 255",3.4);
		EntFire("fade_moment","Fade","",3.5);
		EntFire("lv3_boss_skill_timer","Enable","",4);
		break;
		
		case 5:
		EntFire("lv3_boss_model","SetAnimation","attack");
		EntFire("_lv3_boss_skill2_stone_template","ForceSpawn","");
		if(RandomInt(0,1)) 
		for (local i = 1; i < 6; i++) 
		EntFire("lv3_boss_skill2_stone"+i.tostring(),"Open","",i);
		
		else 
		for (local i = 1; i < 6; i++) 
		EntFire("lv3_boss_skill2_stone"+(6-i).tostring(),"Open","",i);
		EntFire("lv3_boss_skill_timer","Enable","",7.5);
		break;
		
		case 6:
		EntFire("lv3_boss_model","SetDefaultAnimation","");
		EntFire("lv3_boss_model","SetAnimation","idle");
		EntFire("_lv3_boss_skill2_clone_template","AddOutput","origin 6528 4672 912");
		EntFire("_lv3_boss_skill2_clone_template","ForceSpawn","",0.01);local t = RandomInt(0,2);
		
		if(t==0) EntFire("lv3_boss_skill2_clone*","Open","",0.01);
		else if(t==1)
		{
			EntFire("lv3_boss_skill2_clone2_root","Open","",0.01);
			EntFire("lv3_boss_model","ClearParent","");
			EntFire("lv3_boss_model","SetParent","lv3_boss_move_left",0.01);
			EntFire("lv3_boss_move_left","Open","",0.01);
		}
		else
		{
			EntFire("lv3_boss_skill2_clone1_root","Open","",0.01);
			EntFire("lv3_boss_model","ClearParent","");
			EntFire("lv3_boss_model","SetParent","lv3_boss_move_right",0.01);
			EntFire("lv3_boss_move_right","Open","",0.01);
		};;
		
		EntFire("lv3_boss_model","SetDefaultAnimation","wave",2.01);
		EntFire("lv3_boss_model","SetAnimation","wave",2.01);
		EntFire("lv3_boss_skill2_clone*","SetDefaultAnimation","wave",2.01);
		EntFire("lv3_boss_skill2_clone*","SetAnimation","wave",2.01);
		EntFire("lv3_boss_model","SetDefaultAnimation","",7);
		EntFire("lv3_boss_model","SetAnimation","idle",7);
		EntFire("lv3_boss_skill2_clone*","SetDefaultAnimation","",7);
		EntFire("lv3_boss_skill2_clone*","SetAnimation","idle",7);
		EntFire("lv3_boss_skill2_clone*","Close","",7);
		EntFire("lv3_boss_move_*","Close","",7);
		EntFire("lv3_boss_skill2_clone*","Kill","",9);
		EntFire("lv3_boss_skill_timer","Enable","",9);
		EntFire("lv3_boss_model","SetDefaultAnimation","wave",9);
		EntFire("lv3_boss_model","SetAnimation","wave",9);
		break;
		
		case 2:
		EntFire("lv3_boss_skill_bounce","Stop","");
		EntFire("lv3_boss_skill_bounce","Start","",0.01);
		EntFire("lv3_boss_skill_bounce","Stop","",4);
		EntFire("lv3_boss_collision","Disable","");
		EntFire("lv3_boss_collision","Enable","",4);
		EntFire("lv3_boss_collision_bounce","Enable","");
		EntFire("lv3_boss_collision_bounce","Disable","",4);
		EntFire("lv3_boss_skill_timer","Enable","",4);break;
	}
}

function RockMonsterRush(index)
{
	local t = 255;
	if(index == -1) t = 0; 
	
	for (local i = 1; i < 101; i++) 
	EntFire("lv3_boss_model","AddOutput","renderamt "+(t-i*2.55*index),i*0.01);
}

function ShowBossHP()
{
	if(BOSS_HP_TOTAL <= 0)
	{
		ScriptPrintMessageCenterAll("<font class='fontSize-l'>["+BossN+"]: </font>" + "<font class='fontSize-l' color='" + BossColor + "'> DEFEATED </font>");
		ticking = false;
		BOSS_HP_TOTAL=0;
		EntFire("lv3_boss_hp_timer","Kill","");
		EntFire("global_shake_255","StartShake","");
		
		for (local i = 1; i < 101; i++) 
		EntFire("lv3_boss_model","AddOutput","renderamt "+(255-i*2.55),i*0.01);
		
		EntFire("lv3_boss_*","Kill","",1);
		EntFire("wall_1","Kill","",1);
		EntFire("lv3_teleport_all_11","Enable","",8);
		EntFire("skyfire_timer","Enable","");
		EntFire("item_ultimate_template","AddOutput","origin 6144 4672 624");
		EntFire("item_ultimate_template","ForceSpawn","",0.01);
		Explode(17);
		PlayBGM(8);
		EntFire("lv3_wall_7","Toggle","");
		return;
	};
}

function SpawnCameras(n1,x1,y1,z1,o1,n2,x2,y2,z2,o2,time,flag,delay)
{
	local vc = Entities.CreateByClassname("point_viewcontrol_multiplayer");
	vc.__KeyValueFromString("targetname", n1);
	
	vc.SetAngles(x1,y1,z1);
	vc.SetOrigin(o1);
	
	local vt = Entities.CreateByClassname("info_target");
	vt.__KeyValueFromString("targetname", n2);
	vt.SetAngles(x2,y2,z2);
	vt.SetOrigin(o2);
	vc.__KeyValueFromString("target_entity", n2);
	vc.__KeyValueFromFloat("interp_time", time);
	vc.__KeyValueFromInt("spawnflags", flag);
	
	EntFireByHandle(vc,"Enable","",delay,vc,vc);
	EntFireByHandle(vc,"StartMovement","",delay+0.01,vc,vc);
}

function Weather()
{
	if(RandomInt(0,1))
	{
		EntFire("skybox_cloudy","Trigger","");
		EntFire("tonemap","SetAutoExposureMin","0.7");
		EntFire("tonemap","SetAutoExposureMax","0.8");
		EntFire("weather","AddOutput","renderamt 100");
		EntFire("lightning_timer","Enable","",15);
	}
	else 
	EntFire("lightning_timer","Kill","");
}

function PushPlayer()
{
	PLAYER.push(activator);
}

function GetRandomPlayer()
{
	local h = null;
	if(PLAYER.len() != 0) 
	{
		h = PLAYER[RandomInt(0,PLAYER.len()-1)];
	};
	
	PLAYER.clear();
	return h;
}

function SpawnLightning()
{
	local h = GetRandomPlayer();
	if(h != null)
	{
		EntFire("lightning_template","AddOutput","origin "+ConvertOrigin(h.GetOrigin()));
		EntFire("lightning_template","ForceSpawn","",0.01);
	}
}

function SpawnSkyfire()
{
	local h = GetRandomPlayer();
	if(h != null)
	{
		EntFire("skyfire_template","AddOutput","origin "+ConvertOrigin(h.GetOrigin()));
		EntFire("skyfire_template","ForceSpawn","",0.01);
	}
}

function ConvertOrigin(item)
{
	local newOrigin = (item.x).tostring()+" "+(item.y).tostring()+" "+(item.z).tostring();
	return newOrigin;
}

function Explode(index)
{
	EntFire("global_shake_255","StartShake","");
	EntFire("lv3_explosion_fire_"+index,"StartFire","");
	EntFire("prop_explosion_"+index,"Break","");
	EntFire("prop_explosion_"+index,"Kill","",0.5);
	EntFire("lv3_explosion_"+index,"Start","");
	EntFire("lv3_explosion_"+index,"Kill","",3);
	EntFire("lv3_explosion_sound_"+index,"PlaySound","");
	EntFire("lv3_explosion_sound_"+index,"Kill","",4);
}

function GetRandomZombie()
{
	local h = null;
	local t = [];
	
	while(null != (h = Entities.FindByClassnameWithin(h,"player",self.GetOrigin(),500000)))
	{
		if(h.GetTeam() == 2) t.push(h);
	}
	if(t.len() != 0) h = t[RandomInt(0,t.len()-1)];
	
	return h;
}

function TeleportRandomZombie(index)
{
	if(!EXMODE)
	{
		if(index == 9 || index == 18) TeleportRandomZombie2(index);
	}
	else 
	TeleportRandomZombie2(index);
}

function TeleportRandomZombie2(index)
{
	local h = GetRandomZombie();
	if(h != null)
	{
		local o = ZMPOSITION[index-1];
		if(index == 9)
		{
			local x= RandomInt(1408,1792);
			local y= RandomInt(-3200,-2432);
			o = x+" "+y+" 984";
		};
		
		if(index == 18)
		{
			local x= RandomInt(5216,5792);
			local y= RandomInt(4512,4832);
			o = x+" "+y+" 792";
		};
		
		EntFire("teleport_particle_template","AddOutput","origin "+o);
		EntFire("teleport_particle_template","ForceSpawn","",0.01);
		EntFire("!activator","AddOutput","origin "+o,5,h);
		EntFire("!activator","RunScriptCode","self.SetVelocity(Vector(0 0 0));",5,h);
	}
}

function SpawnLaser(index)
{
	EntFire("env_sound_global","AddOutput","message ze_roof_adventure/env/laser.mp3");
	EntFire("env_sound_global","StopSound","");
	EntFire("env_sound_global","PlaySound","",0.01);
	EntFire("lv3_laser_boss","SetAnimation","wave");
	if(index == 1)
	{
		local o = ["2792 10000 636","2792 10000 656"];
		EntFire("lv3_laser1_template","AddOutput","origin "+o[RandomInt(0,1)]);
		EntFire("lv3_laser1_template","ForceSpawn","",0.01);
	};
	if(index == 2)
	{
		for (local i = 1; i < 101; i++)
		{
			EntFire("lv3_laser2_left_train","AddOutput","angles "+"0 0 "+0.2*i,0.01*i+0.1);
			EntFire("lv3_laser2_right_train","AddOutput","angles "+"0 0 "+(-0.2*i),0.01*i+0.1);
		}
		for (local i = 100; i < 176; i++)
		{
			EntFire("lv3_laser2_left","AddOutput","renderamt "+(595-3.4*i),0.01*i+0.1);
			EntFire("lv3_laser2_right","AddOutput","renderamt "+(595-3.4*i),0.01*i+0.1);
		}
		
		LASERZ = 0;
		SetInfLaser("lv3_laser2_left_path_");
		SetInfLaser("lv3_laser2_right_path_");
		EntFire("lv3_laser2_left_train","StartForward","",0.1);
		EntFire("lv3_laser2_right_train","StartForward","",0.1);
	}
}

function SetInfLaser(path)
{
	local p = null;
	for(local i=2;i<5;i++)
	{
		local h = Entities.FindByName(null,path+i.tostring());
		if(h != null)
		{
			local o = h.GetOrigin();
			if(i == 2)
			{
				if(!LASERZ)
				if(RandomInt(0,100) % 2 != 0)
				{
					o = Vector(o.x,o.y,o.z+66.12);
					LASERZ = 1;
				};;
				p = o.z;
			}
			else o = Vector(o.x,o.y,p);
			
			h.SetOrigin(o);
		}
	}
}

function RTVLevel()
{
	local n = RandomInt(0,2);
	if(n == 0)
	{
		SpawnBreakTrigger();
		EntFire("item_jumpad_template_human","AddOutput","origin -15648 -4848 544");
		EntFire("item_jumpad_template","AddOutput","origin -15168 -4368 544");
		EntFire("item_jumpad_template_human","ForceSpawn","",0.01);
		EntFire("item_jumpad_template","ForceSpawn","",0.01);
		return;
	};
	if(n == 1) 
	for (local i = 0; i < RTV_BREAK_1.len(); i++) 
	EntFire("lv4_break_"+RTV_BREAK_1[i],"Break","");
	
	if(n == 2) for (local i = 0; i < RTV_BREAK_2.len(); i++) 
	EntFire("lv4_break_"+RTV_BREAK_2[i],"Break","");
	EntFire("lv4_effect_timer","Enable","",5);
}

function RTVRandomEffect()
{
	local n = RandomInt(1,4);
	EntFire("env_sound_global","StopSound","");
	EntFire("env_sound_global","PlaySound","",0.01);
	EntFire("lv4_effect_4","SetPushDirection","0 "+RandomInt(0,3)*90+" 0");
	EntFire("lv4_effect_"+n,"Enable","",2.01);EntFire("lv4_effect_"+n,"Disable","",7.01);
	EntFire("lv4_effect_timer","Enable","",7.01);
}

function SpawnBreakTrigger()
{
	for (local i = 0; i < RTV_POSITION.len(); i++)
	{
		EntFire("lv4_break_trigger_template","AddOutput","origin "+RTV_POSITION[i]+" 512",0.02*i);
		EntFire("lv4_break_trigger_template","AddOutput","angles 0 "+RTV_ANGLE[i]+" 0",0.02*i);
		EntFire("lv4_break_trigger_template","ForceSpawn","",0.02*i+0.01);
	}
}

function StartBreak()
{
	local h = Entities.FindByClassnameWithin(null,"func_breakable",caller.GetOrigin(),100);
	if(h != null) 
	EntFire("!activator","Break","",0,h);
}

function Jumpad(speed)
{
	local v = activator.GetVelocity();
	local anglesY = activator.GetAngles().y;
	local c = null;
	local s = null;
	if(anglesY == 0 || anglesY == 180) s = 1;
	if(anglesY == 90 || anglesY == 270) c = 1;
	else{anglesY = anglesY*PI/180;
	
	c = cos(anglesY);
	s = sin(anglesY);};
	
	activator.SetVelocity(Vector(v.x+500*c,v.y+500*s,speed));
}

function FilterZombieName()
{
	local name = activator.GetName();
	for (local i = 0; i < ZOMBIE_FILTER.len(); i++)
	{
		if(name == ZOMBIE_FILTER[i]) return;
	}
	
	EntFire("stripper","StripWeaponsAndSuit","",0,activator);
}

function SpawnParticle(index)
{
	local t = Entities.FindByName(null,PARTICLE_NAME[index-1]);
	t.SetOrigin(activator.GetOrigin());
	EntFire("!activator","ForceSpawn","",0.01,t);
}

function SpawnItem(level)
{
	local p = ITEM_POSITION_1;
	if(level == 3)
	{
		p = ITEM_POSITION_2;
		ITEM_NAME.push("item_waterfall_template");
	};
	
	local n = p.len();
	for (local i = 0; i < n; i++)
	{
		local n1 = RandomInt(0,p.len()-1);
		local n2 = RandomInt(0,p.len()-1);
		
		if(p[n2] == "2912 1120 728") EntFire(ITEM_NAME[n1],"AddOutput","angles 0 180 0",i*2);
		
		EntFire(ITEM_NAME[n1],"AddOutput","origin "+p[n2],i*2);
		EntFire(ITEM_NAME[n1],"ForceSpawn","",i*2+1);
		ITEM_NAME.remove(n1);p.remove(n2);
	}
}

function ChangeLevel(level)
{
	EntFire("round_end","EndRound_Draw","3");
	EntFire("level_button*","Lock","");
	EntFire("database","RunScriptCode","LEVEL="+level);
}

function Reset()
{
	EntFire("tonemap","SetBloomScale","0.2");
	EntFire("tonemap","SetAutoExposureMin","0.8");
	EntFire("tonemap","SetAutoExposureMax","1.75");
	EntFire("tonemap","SetTonemapPercentBrightPixels","8");
	EntFire("tonemap","SetTonemapRate","0.4");
	EntFire("fog","SetStartDist","500");
	EntFire("fog","SetEndDist","30000");
	EntFire("fog","SetMaxDensity","0.2");
	EntFire("skybox_daylight","Trigger","");
}

function SetBossHPTick()
{
	if(PLAYERCOUNT != 0 && PLAYERCOUNT*252 < BOSS_HP_TOTAL)
	{
		BOSS_HP_TOTAL = PLAYERCOUNT*252;
		BOSS_HP_TOTAL2 = BOSS_HP_TOTAL;
	};
	
	PLAYERCOUNT = 0;
}