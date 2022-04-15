//Original vscript by iXi from v1_10
//Editted by Detroid

//current hp and others
formortiis_hp <- 0;
canhit <- 1;

//reference variable
full_hp <- 0;
each_bar <- 0;
formortiis_can_heal <- true;
function scaleHp(mode) {
	//0 = more hp, weaker attack
	//1 = less hp, stronger attack
	if (mode == 0) {
		formortiis_hp += 3000;
		full_hp += 3000;
		EntFire("formortiis_hp", "Add", "3000", 0.00);
		EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
		EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
	}
	else {//for other purpose i can't think of
		formortiis_hp += 1800;
		full_hp += 1800;
		EntFire("formortiis_hp", "Add", "1800", 0.00);
	}
}

function halveBossHp() {
	formortiis_hp /= 2;
	EntFire("formortiis_hp", "SetValue", formortiis_hp.tostring(), 0.00);
	EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
	EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
	each_bar = formortiis_hp / 4;
}

//subtract two if weak, else one
function onHit() {
	if (canhit == 1) {
		formortiis_hp -= 2;
		EntFire("formortiis_hp", "Subtract", "2", 0.00);
		printl(formortiis_hp.tostring());
		EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
		EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
		checkIfBreak();
		if (formortiis_hp <= 0) {
			EntFire("formortiis_fire_1", "Stop", null, 0.00, null);
		}
	}
	else {
		formortiis_hp += 30;
		EntFire("formortiis_hp", "Add", "30", 0.00);
		EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
		EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
		printl(formortiis_hp.tostring());
		checkIfRestore();
	}
}

//test this
function checkIfBreak() {
	switch(formortiis_hp) {
		case (each_bar * 0) :
			EntFire("formortiis_fire_1", "Stop", null, 0.00, null);
			break;
		case (each_bar * 1) :
			EntFire("formortiis_fire_2", "Stop", null, 0.00, null);
			break;
		case (each_bar * 2) :
			if (formortiis_can_heal) {
				formortiis_can_heal = false;
				formortiis_hp += 2750;
				EntFire("formortiis_fire_3", "Stop", null, 0.00, null);
				EntFire("formortiis", "Skin", "1", 0.00, null);
				EntFire("formortiis", "AddOutput", "rendercolor 255 0 6", 0.00, null);
				EntFire("Server", "Command", "say <<<Hah, do you really think your guns can hurt me?>>>", 1.00, null);
				EntFire("Server", "Command", "say <<<***All damage increased! Extra attack combo frequency increased!***>>>", 2.00, null);
				EntFire("Server", "Command", "say <<<***Formortiis has healed himself***>>>", 3.00, null);
				EntFire("formortiis_hp", "Add", "2750", 0.00);
				EntFire("formortiis_light_hurt", "AddOutput", "damage 85", 0.00, null);
				EntFire("contagious_mist_trig", "AddOutput", "damage 30", 0.00, null);
				EntFire("contagious_mist_trig2", "AddOutput", "damage 30", 0.00, null);
			}
			else {
				EntFire("formortiis_fire_3", "Stop", null, 0.00, null);
			}
			break;
		case (each_bar * 3) :
			EntFire("formortiis_fire_4", "Stop", null, 0.00, null);
			break;
	}
}

function checkIfRestore() {
	switch(formortiis_hp) {
		case (each_bar * 0) :
			//EntFire("formortiis_fire_1", "Start", null, 0.00, null);
			break;
		case (each_bar * 1) :
			EntFire("formortiis_fire_2", "Start", null, 0.00, null);
			break;
		case (each_bar * 2) :
			EntFire("formortiis_fire_3", "Start", null, 0.00, null);
			break;
		case (each_bar * 3) :
			EntFire("formortiis_fire_4", "Start", null, 0.00, null);
			break;
	}
}

function setHitVar(value) {
	canhit = value;
}

function addHp(value) {
	formortiis_hp += value;
	EntFire("formortiis_hp", "Add", value.tostring(), 0.00);
}
