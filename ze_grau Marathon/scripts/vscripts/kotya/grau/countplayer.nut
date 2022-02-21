function AliveCt(act){if(act.GetTeam() == 3 && act.GetHealth() > 0)return true;}
function AliveT(act){if(act.GetTeam() == 2 && act.GetHealth() > 0)return true;}

function CountHumans()
{
	local p = null;
	local PCtcount = 0;
	local PTcount = 0;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
		if (AliveCt(p)) PCtcount++;
		else PTcount++;
	}
	EntFire("sc", "Command", "say << Players alive on this stage : "+PCtcount.tostring()+"/"+(PTcount+PCtcount).tostring()+" >>", 2.00, self);
}

function CountPlayer(index)
{
	if(index==1)
	{
	 local p = null;
	 local ctCount = 0;
	 while(null != (p = Entities.FindByClassname(p,"player")))
	 {
		 if (AliveCt(p)) ctCount++;
	 }
	 return ctCount;
	}
	else
	{
		local p = null;
	  local tCount = 0;
	  while(null != (p = Entities.FindByClassname(p,"player")))
	  {
		 if (AliveT(p)) tCount++;
	  }
		return tCount;
	}
}
