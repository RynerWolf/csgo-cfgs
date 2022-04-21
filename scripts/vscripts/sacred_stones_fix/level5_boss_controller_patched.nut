//Script editted by Detroid
//Thanks to Kotya and iXi for original scripts
canhit <- 1;
BossHpBar <- 10;
BossN <- "Formortiis";
ticking <- false;
TickRate <- 0.05;
HPHUD <- "◼◼◼◼◼◼◼◼◼◼";
BossHealth <- 1000000.00;
ChangeHealth <- 1000000.00;
HudHealth <- 1000000.00;
formortiis_can_heal <- true;

function scaleHp(add_amount) {
	formortiis_can_heal = true;
	BossHealth = 0.00;
	ChangeHealth = 0.00;
	HudHealth = 0.00;
	local p = null;
	while(null != (p = Entities.FindByClassname(p, "player")))
	{
	    if(p.GetTeam() == 3 && p.GetHealth() > 0 && p.IsValid())
		{
		    	BossHealth += add_amount;
			ChangeHealth += add_amount;
		}
	}
	HudHealth = ChangeHealth * BossHpBar;
	Start();
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
			checkIfBreak();
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

function SubtractHealth()
{
	if (canhit)
	{
		BossHealth-=2;
		HudHealth-=2;
	}
	else
	{
		BossHealth+=10;
		HudHealth+=10;
	}
}

function BossKill()
{
	ticking = false;
	EntFire("formortiis_hp", "SetValue", "0", 0.00);
}

//test this
function checkIfBreak() 
{
	if (formortiis_can_heal == true) 
	{
		formortiis_can_heal = false;
		local p = null;
		while(null != (p = Entities.FindByClassname(p, "player")))
		{	
	    		if(p.GetTeam() == 3 && p.GetHealth() > 0 && p.IsValid())
			{
		    		BossHealth += 200;
				HudHealth += 200;
			}
		}
		EntFire("formortiis", "Skin", "1", 0.00, null);
		EntFire("formortiis", "AddOutput", "rendercolor 255 0 6", 0.00, null);
		EntFire("Server", "Command", "say <<<Hah, do you really think your guns can hurt me?>>>", 1.00, null);
		EntFire("Server", "Command", "say <<<***All damage increased! Extra attack combo frequency increased!***>>>", 2.00, null);
		EntFire("Server", "Command", "say <<<***Formortiis has healed himself***>>>", 3.00, null);
		EntFire("formortiis_light_hurt", "AddOutput", "damage 85", 0.00, null);
		EntFire("contagious_mist_trig", "AddOutput", "damage 30", 0.00, null);
		EntFire("contagious_mist_trig2", "AddOutput", "damage 30", 0.00, null);
	}
}

function setHitVar(value) {
	canhit = value;
}
