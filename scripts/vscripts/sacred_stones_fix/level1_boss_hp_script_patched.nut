BossHpBar <- 10;
BossN <- "Guardian";
ticking <- false;
TickRate <- 0.05;
HPHUD <- "◼◼◼◼◼◼◼◼◼◼";
BossHealth <- 0.00;
ChangeHealth <- 0.00;
HudHealth <- 0.00;
canRage <- true;

function scaleHp(add_amount) {
	BossHealth += add_amount;
	ChangeHealth += add_amount;
	HudHealth += add_amount * BossHpBar;
}

function ChangeHp()
{
	if(BossHealth <= 0){HpBar();BossHpBar--;BossHealth += ChangeHealth;}
	else if(BossHpBar<=0){BossKill();ticking=false;}
}

function HpBar()
{
	for(local i = BossHpBar; i >= 0; i--)
	{
	    if(BossHpBar == 10){HPHUD = "◼◼◼◼◼◼◼◼◼◻";}
	    if(BossHpBar == 9){HPHUD = "◼◼◼◼◼◼◼◼◻◻";}
	    if(BossHpBar == 8){HPHUD = "◼◼◼◼◼◼◼◻◻◻";}
	    if(BossHpBar == 7){HPHUD = "◼◼◼◼◼◼◻◻◻◻";}
	    if(BossHpBar == 6)
		{
			HPHUD = "◼◼◼◼◼◻◻◻◻◻";
			checkRage();
		}
	    if(BossHpBar == 5){HPHUD = "◼◼◼◼◻◻◻◻◻◻";}
	    if(BossHpBar == 4){HPHUD = "◼◼◼◻◻◻◻◻◻◻";}
	    if(BossHpBar == 3){HPHUD = "◼◼◻◻◻◻◻◻◻◻";}
	    if(BossHpBar == 2){HPHUD = "◼◻◻◻◻◻◻◻◻◻";}
		if(BossHpBar == 1){HPHUD = "◻◻◻◻◻◻◻◻◻◻";}
		return;
	}
}

function CheckHpHud(){ScriptPrintMessageCenterAll("["+BossN+": " + HudHealth + "]" + "\n" + HPHUD);}

function Start(){ticking = true;Tick();}

function Tick()
{
	if(ticking)
	{
		EntFireByHandle(self, "RunScriptCode", "Tick()", TickRate, null, null);
		EntFireByHandle(self, "RunScriptCode", "ChangeHp()", 0.00, null, null);
		EntFireByHandle(self, "RunScriptCode", "CheckHpHud()", 0.00, null, null);
	}
}

function SubtractHealth(){BossHealth--;HudHealth--;if(HudHealth <= 0){HudHealth=0;}}

function BossKill()
{
	ticking = false;
	EntFire("level1_boss_hitbox", "Kill", null, 0.00, null);
	EntFire("actual_boss_mdl", "SetAnimation", "golem_low_health", 0.00, null);
	EntFire("level1_boss_nuke_relay", "Kill", null, 0.00, null);
	EntFire("level1_boss_nuke", "Kill", null, 0.00, null);
	EntFire("death_sound", "PlaySound", null, 0.00, null);
	EntFire("level1_killallboss_atk", "Trigger", null, 0.00, null);
	EntFire("level1_boss_main_timer", "Disable", null, 0.00, null);
	EntFire("level1_boss_model", "Disable", null, 4.00, null);
	EntFire("Server", "Command", "say <<<Congratulations, Advancing to next chapter...>>>", 5.00, null);
	EntFire("level_counter", "SetValue", "5", 5.00, null);
	EntFire("spawn_nuke", "Enable", null, 6.00, null);
	EntFire("boss_t_nuke", "Enable", null, 6.00, null);
	EntFire("actual_boss_mdl", "Disable", null, 4.00, null);//level nuke
	EntFireByHandle(self, "Kill", "", 1.00, null, null);
}

function checkRage() {
	if(canRage == true) {
		canRage = false;
		EntFire("Server", "Command", "say <<<All damages and frequencies are now increased>>>", 0.00, null);
		EntFire("level1_boss_earthquake_hurt", "AddOutput", "damage 30", 0.00, null);
		EntFire("level1_boss_main_timer", "AddOutput", "RefireTime 15", 0.00, null);//renable timer so it doesn't take longer
	}
}
