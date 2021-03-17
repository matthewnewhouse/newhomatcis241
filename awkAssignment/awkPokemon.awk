BEGIN{
FS =","
strongestTotal = 0
strongestName = ""
highestHP = 0
HPname = ""
highestAttack = 0
attackName = ""
highestDefense = 0
defenseName = 0
highestSPattack = 0
SPattackName = ""
highestSPdefense = 0
SPdefenseName = ""
highestSpeed = 0
speedName = ""
avgTotal=0
avgHP=0
avgAttack=0
avgDefense=0
avgSPAttack=0
avgSPDefense=0
avgSpeed=0
lastNum=0
powBug = ""
bugTotal = 0
powDark = ""
darkTotal = 0
powDragon = ""
dragonTotal = 0
powElectric = ""
electricTotal = 0
powFairy = ""
fairyTotal = 0
powFighting = ""
fightingTotal = 0
powFire = ""
fireTotal = 0
powFlying = ""
flyingTotal = 0
powGhost = ""
ghostTotal = 0
powGrass = ""
grassTotal = 0
powGround = ""
groundTotal = 0
powIce = ""
iceTotal = 0
powNormal = ""
normalTotal = 0
powPoison = ""
poisonTotal = 0
powPsychic = ""
psychicTotal = 0
powRock = ""
rockTotal = 0
powSteel = ""
steelTotal = 0
powWater = ""
waterTotal = 0
}

/Mega /{
	while(substr($2,0,4)!~"Mega"){
		
		$2=substr($2,2)
	}
}

/Primal /{
	while(substr($2,0,6)!~"Primal"){
		$2 = substr($2,2)
	}

	}

/KyuremBlack/{
		while(substr($2,0,5)!~"Black"){
			$2 = substr($2,2)
			}
	}
/KyuremWhite/{
	while(substr($2,0,5)!~"White"){
		$2=substr($2,2)
		        }

	}
/Altered Forme/{
	while(substr($2,0,7)!~"Altered"){
		$2=substr($2,2)
	}
	$2 = $2 " Giratina"
	}
/Origin Forme/{
	while(substr($2,0,6)!~"Origin"){
		        $2=substr($2,2)
		}       
		$2=$2" Giratina"
       	}

/Speed Forme/{
	while(substr($2,0,5)!~"Speed"){
		$2=substr($2,2)
	}
	$2=$2" Deoxys"
}

{
	if (strongestTotal < $5 && $2!= "Name"){
		strongestTotal = $5
		strongestName=$2
		}
	else if (strongestTotal == $5 && $2!= "Name"){
		strongestName= strongestName ", " $2
		}
}

{
	if (highestHP < $6 && $2!= "Name"){
		highestHP = $6
		HPname=$2
	}
	else if (highestHP == $6 && $2!= "Name"){
		HPname= HPname ", " $2
	}
}

{
	if (highestAttack < $7 && $2!= "Name"){
		highestAttack = $7
		attackName=$2
	}
	else if (highestAttack == $7 && $2!= "Name"){
		attackName= attackName ", " $2
}
}
{
	if (highestDefense < $8 && $2!= "Name"){
		highestDefense = $8
		defenseName=$2
	}
	else if (highestDefense == $8 && $2!= "Name"){
		defenseName= defenseName ", " $2
}
}

{

	if (highestSPattack < $9 && $2!= "Name"){

		highestSPattack = $9

		SPattackName=$2

	}

	else if (highestSPattack == $9 && $2!= "Name"){

		SPattackName= SPattackName ", " $2

	}

}

{

	if (highestSPdefense < $10 && $2!= "Name"){

		highestSPdefense = $10

		SPdefenseName=$2

	}

	else if (highestSPdefense == $10 && $2!= "Name"){

		SPdefenseName= SPdefenseName ", " $2

	}

}

{

	if (highestSpeed < $11 && $2!= "Name"){

		highestSpeed = $11

		speedName=$2

	}

	else if (highestSpeed == $11 && $2!= "Name"){

		speedName= speedName ", " $2

	}

}

{
	lastNum=$1
	avgTotal+=$5
	avgHP+=$6
	avgAttack+=$7
	avgDefense+=$8
	avgSPAttack+=$9
	avgSPDefense+=$10
	avgSpeed+=$11
}

{
	if($3 == "Bug" ||  $4 == "Bug" ){
		bugStats["total"]+=$5
		bugStats["HP"]+=$6
		bugStats["attack"]+=$7
		bugStats["defense"]+=$8
		bugStats["SPattack"]+=$9
		bugStats["SPdefense"]+=$10
		bugStats["speed"]+=$11
		bugStats["num"]+=1
		if(bugTotal<$5){
			bugTotal = $5
			powBug = $2
		}
		else if (bugTotal == $5){
			powBug = powBug ", " $2
		}
	}
	if($3 == "Dark" ||  $4 == "Dark" ){
		darkStats["total"]+=$5
		darkStats["HP"]+=$6
		darkStats["attack"]+=$7
		darkStats["defense"]+=$8
		darkStats["SPattack"]+=$9
		darkStats["SPdefense"]+=$10
		darkStats["speed"]+=$11
		darkStats["num"]+=1
		if(darkTotal<$5){
			darkTotal = $5
			powDark = $2
		}
		else if (darkTotal == $5){
			powDark = powDark ", " $2
		}
	 }
	 if($3 == "Dragon" ||  $4 == "Dragon" ){
		 dragonStats["total"]+=$5
		 dragonStats["HP"]+=$6
		 dragonStats["attack"]+=$7
		 dragonStats["defense"]+=$8
		 dragonStats["SPattack"]+=$9
		 dragonStats["SPdefense"]+=$10
		 dragonStats["speed"]+=$11
		 dragonStats["num"]+=1
		 if(dragonTotal<$5){
			 dragonTotal = $5
			 powDragon = $2
		 }
		 else if (dragonTotal == $5){
			 powDragon = powDragon ", " $2
	 	 }
	 
	 }
	 if($3 == "Electric" ||  $4 == "Electric" ){
		 electricStats["total"]+=$5
		 electricStats["HP"]+=$6
		 electricStats["attack"]+=$7
		 electricStats["defense"]+=$8
		 electricStats["SPattack"]+=$9
		 electricStats["SPdefense"]+=$10
		 electricStats["speed"]+=$11
	         electricStats["num"]+=1

		 if(electricTotal<$5){

			 electricTotal = $5

			 powElectric = $2

		 }

		 else if (electricTotal == $5){

			 powElectric = powElectric ", " $2

		 }

	}
	if($3 == "Fairy" ||  $4 == "Fairy" ){
		fairyStats["total"]+=$5
		fairyStats["HP"]+=$6
		fairyStats["attack"]+=$7
		fairyStats["defense"]+=$8
		fairyStats["SPattack"]+=$9
		fairyStats["SPdefense"]+=$10
		fairyStats["speed"]+=$11
		fairyStats["num"]+=1

		if(fairyTotal<$5){

			fairyTotal = $5

			powFairy = $2

		}

		else if (fairyTotal == $5){

			powFairy = powFairy ", " $2

		}

		        }
	if($3 == "Fighting" ||  $4 == "Fighting" ){
		fightingStats["total"]+=$5
		fightingStats["HP"]+=$6
		fightingStats["attack"]+=$7
		fightingStats["defense"]+=$8
		fightingStats["SPattack"]+=$9
		fightingStats["SPdefense"]+=$10
		fightingStats["speed"]+=$11
		fightingStats["num"]+=1

		if(fightingTotal<$5){

			fightingTotal = $5

			powFighting = $2

		}

		else if (fightingTotal == $5){

			powFighting = powFighting ", " $2

		}

	}
	if($3 == "Fire" ||  $4 == "Fire" ){
		fireStats["total"]+=$5
		fireStats["HP"]+=$6
		fireStats["attack"]+=$7
		fireStats["defense"]+=$8
		fireStats["SPattack"]+=$9
		fireStats["SPdefense"]+=$10
		fireStats["speed"]+=$11
		fireStats["num"]+=1

		if(fireTotal<$5){

			fireTotal = $5

			powFire = $2

		}

		else if (fireTotal == $5){

			powFire = powFire ", " $2

		}

	}
	if($3 == "Flying" ||  $4 == "Flying" ){
		flyingStats["total"]+=$5
		flyingStats["HP"]+=$6
		flyingStats["attack"]+=$7
		flyingStats["defense"]+=$8
		flyingStats["SPattack"]+=$9
		flyingStats["SPdefense"]+=$10
		flyingStats["speed"]+=$11
		flyingStats["num"]+=1
		if(flyingTotal<$5){
			flyingTotal = $5
			powFlying = $2
		}
		else if (flyingTotal == $5){
			powFlying = powFlying ", " $2
		}
	}
	if($3 == "Ghost" ||  $4 == "Ghost" ){
		ghostStats["total"]+=$5
		ghostStats["HP"]+=$6
		ghostStats["attack"]+=$7
		ghostStats["defense"]+=$8
		ghostStats["SPattack"]+=$9
		ghostStats["SPdefense"]+=$10
		ghostStats["speed"]+=$11
		ghostStats["num"]+=1
		if(ghostTotal<$5){
			ghostTotal = $5
			powGhost = $2
		}
		else if (ghostTotal == $5){
			powGhost = powGhost ", " $2
		}
	}
	if($3 == "Grass" ||  $4 == "Grass" ){
		grassStats["total"]+=$5
		grassStats["HP"]+=$6
		grassStats["attack"]+=$7
		grassStats["defense"]+=$8
		grassStats["SPattack"]+=$9
		grassStats["SPdefense"]+=$10
		grassStats["speed"]+=$11
		grassStats["num"]+=1
		if(grassTotal<$5){

			grassTotal = $5

			powGrass = $2

		}
		else if (grassTotal == $5){

			powGrass = powGrass ", " $2

		}
	}
	if($3 == "Ground" ||  $4 == "Ground" ){
		groundStats["total"]+=$5
		groundStats["HP"]+=$6
		groundStats["attack"]+=$7
		groundStats["defense"]+=$8
		groundStats["SPattack"]+=$9
		groundStats["SPdefense"]+=$10
		groundStats["speed"]+=$11
		groundStats["num"]+=1

		if(groundTotal<$5){

			groundTotal = $5

			powGround = $2

		}

		else if (groundTotal == $5){

			powGround = powGround ", " $2

		}

	}
	if($3 == "Ice" ||  $4 == "Ice" ){
		iceStats["total"]+=$5
		iceStats["HP"]+=$6
		iceStats["attack"]+=$7
		iceStats["defense"]+=$8
		iceStats["SPattack"]+=$9
		iceStats["SPdefense"]+=$10
		iceStats["speed"]+=$11
		iceStats["num"]+=1

		if(iceTotal<$5){

			iceTotal = $5

			powIce = $2

		}

		else if (iceTotal == $5){

			powIce = powIce ", " $2

		}

	}
	if($3 == "Normal" ||  $4 == "Normal" ){
		normalStats["total"]+=$5
		normalStats["HP"]+=$6
		normalStats["attack"]+=$7
		normalStats["defense"]+=$8
		normalStats["SPattack"]+=$9
		normalStats["SPdefense"]+=$10
		normalStats["speed"]+=$11
		normalStats["num"]+=1

		if(normalTotal<$5){

			normalTotal = $5

			powNormal = $2

		}

		else if (normalTotal == $5){

			powNormal = powNormal ", " $2

		}

	}
	if($3 == "Poison" ||  $4 == "Poison" ){
		poisonStats["total"]+=$5
		poisonStats["HP"]+=$6
		poisonStats["attack"]+=$7
		poisonStats["defense"]+=$8
		poisonStats["SPattack"]+=$9
		poisonStats["SPdefense"]+=$10
		poisonStats["speed"]+=$11
		poisonStats["num"]+=1

		if(poisonTotal<$5){

			poisonTotal = $5

			powPoison = $2

		}

		else if (poisonTotal == $5){

			powPoison = powPoison ", " $2

		}

	}
	if($3 == "Psychic" ||  $4 == "Psychic" ){
		psychicStats["total"]+=$5
		psychicStats["HP"]+=$6
		psychicStats["attack"]+=$7
		psychicStats["defense"]+=$8
		psychicStats["SPattack"]+=$9
		psychicStats["SPdefense"]+=$10
		psychicStats["speed"]+=$11
		psychicStats["num"]+=1

		if(psychicTotal<$5){

			psychicTotal = $5

			powPsychic = $2

		}

		else if (psychicTotal == $5){

			powPsychic = powPsychic ", " $2

		}

	}
	if($3 == "Rock" ||  $4 == "Rock" ){
		rockStats["total"]+=$5
		rockStats["HP"]+=$6
		rockStats["attack"]+=$7
		rockStats["defense"]+=$8
		rockStats["SPattack"]+=$9
		rockStats["SPdefense"]+=$10
		rockStats["speed"]+=$11
		rockStats["num"]+=1

	if(rockTotal<$5){

		rockTotal = $5

		powRock = $2

	}

	else if (rockTotal == $5){

		powRock = powRock ", " $2

	}

	}
	if($3 == "Steel" ||  $4 == "Steel" ){
		steelStats["total"]+=$5
		steelStats["HP"]+=$6
		steelStats["attack"]+=$7
		steelStats["defense"]+=$8
		steelStats["SPattack"]+=$9
		steelStats["SPdefense"]+=$10
		steelStats["speed"]+=$11
		steelStats["num"]+=1

		if(steelTotal<$5){

			steelTotal = $5

			powSteel = $2

	}

	else if (steelTotal == $5){

		powSteel = powSteel ", " $2

	}
	}

	if($3 == "Water" ||  $4 == "Water" ){
		waterStats["total"]+=$5
		waterStats["HP"]+=$6
		waterStats["attack"]+=$7
		waterStats["defense"]+=$8
		waterStats["SPattack"]+=$9
		waterStats["SPdefense"]+=$10
		waterStats["speed"]+=$11
		waterStats["num"]+=1

		if(waterTotal<$5){

			waterTotal = $5

			powWater = $2

		}
	
		else if (waterTotal == $5){

			powWater = powWater ", " $2

		}
	}

}
	

END{
	avgTotal/=lastNum
	avgHP/=lastNum
	avgAttack/=lastNum
	avgDefense/=lastNum
	avgSPAttack/=lastNum
	avgSPDefense/=lastNum
	avgSpeed/=lastNum

	bugStats["total"]/=bugStats["num"]
	bugStats["HP"]/=bugStats["num"]
	bugStats["attack"]/=bugStats["num"]
	bugStats["defense"]/=bugStats["num"]
	bugStats["SPattack"]/=bugStats["num"]
	bugStats["SPdefense"]/=bugStats["num"]
	bugStats["speed"]/=bugStats["num"]

	darkStats["total"]/=darkStats["num"]
	darkStats["HP"]/=darkStats["num"]
	darkStats["attack"]/=darkStats["num"]
	darkStats["defense"]/=darkStats["num"]
	darkStats["SPattack"]/=darkStats["num"]
	darkStats["SPdefense"]/=darkStats["num"]
	darkStats["speed"]/=darkStats["num"]
	
	dragonStats["total"]/=       dragonStats["num"]
	dragonStats["HP"]/=          dragonStats["num"]
	dragonStats["attack"]/=      dragonStats["num"]
	dragonStats["defense"]/=     dragonStats["num"]
	dragonStats["SPattack"]/=    dragonStats["num"]
	dragonStats["SPdefense"]/=   dragonStats["num"]
	dragonStats["speed"]/=       dragonStats["num"]

	electricStats["total"]/=       electricStats["num"]
	electricStats["HP"]/=          electricStats["num"]
	electricStats["attack"]/=      electricStats["num"]
	electricStats["defense"]/=     electricStats["num"]
	electricStats["SPattack"]/=    electricStats["num"]
	electricStats["SPdefense"]/=   electricStats["num"]
	electricStats["speed"]/=       electricStats["num"]

	fairyStats["total"]/=       fairyStats["num"]
	fairyStats["HP"]/=          fairyStats["num"]
	fairyStats["attack"]/=      fairyStats["num"]
	fairyStats["defense"]/=     fairyStats["num"]
	fairyStats["SPattack"]/=    fairyStats["num"]
	fairyStats["SPdefense"]/=   fairyStats["num"]
	fairyStats["speed"]/=       fairyStats["num"]

	fightingStats["total"]/=       fightingStats["num"]
	fightingStats["HP"]/=          fightingStats["num"]
	fightingStats["attack"]/=      fightingStats["num"]
	fightingStats["defense"]/=     fightingStats["num"]
	fightingStats["SPattack"]/=    fightingStats["num"]
	fightingStats["SPdefense"]/=   fightingStats["num"]
	fightingStats["speed"]/=       fightingStats["num"]

	fireStats["total"]/=       fireStats["num"]
	fireStats["HP"]/=          fireStats["num"]
	fireStats["attack"]/=      fireStats["num"]
	fireStats["defense"]/=     fireStats["num"]
	fireStats["SPattack"]/=    fireStats["num"]
	fireStats["SPdefense"]/=   fireStats["num"]
	fireStats["speed"]/=       fireStats["num"]

	flyingStats["total"]/=       flyingStats["num"]
	flyingStats["HP"]/=          flyingStats["num"]
	flyingStats["attack"]/=      flyingStats["num"]
	flyingStats["defense"]/=     flyingStats["num"]
	flyingStats["SPattack"]/=    flyingStats["num"]
	flyingStats["SPdefense"]/=   flyingStats["num"]
	flyingStats["speed"]/=       flyingStats["num"]

	ghostStats["total"]/=       ghostStats["num"]
	ghostStats["HP"]/=          ghostStats["num"]
	ghostStats["attack"]/=      ghostStats["num"]
	ghostStats["defense"]/=     ghostStats["num"]
	ghostStats["SPattack"]/=    ghostStats["num"]
	ghostStats["SPdefense"]/=   ghostStats["num"]
	ghostStats["speed"]/=       ghostStats["num"]

	grassStats["total"]/=       grassStats["num"]
	grassStats["HP"]/=          grassStats["num"]
	grassStats["attack"]/=      grassStats["num"]
	grassStats["defense"]/=     grassStats["num"]
	grassStats["SPattack"]/=    grassStats["num"]
	grassStats["SPdefense"]/=   grassStats["num"]
	grassStats["speed"]/=       grassStats["num"]

	groundStats["total"]/=       groundStats["num"]
	groundStats["HP"]/=          groundStats["num"]
	groundStats["attack"]/=      groundStats["num"]
	groundStats["defense"]/=     groundStats["num"]
	groundStats["SPattack"]/=    groundStats["num"]
	groundStats["SPdefense"]/=   groundStats["num"]
	groundStats["speed"]/=       groundStats["num"]

	iceStats["total"]/=       iceStats["num"]
	iceStats["HP"]/=          iceStats["num"]
	iceStats["attack"]/=      iceStats["num"]
	iceStats["defense"]/=     iceStats["num"]
	iceStats["SPattack"]/=    iceStats["num"]
	iceStats["SPdefense"]/=   iceStats["num"]
	iceStats["speed"]/=       iceStats["num"]

	normalStats["total"]/=       normalStats["num"]
	normalStats["HP"]/=          normalStats["num"]
	normalStats["attack"]/=      normalStats["num"]
	normalStats["defense"]/=     normalStats["num"]
	normalStats["SPattack"]/=    normalStats["num"]
	normalStats["SPdefense"]/=   normalStats["num"]
	normalStats["speed"]/=       normalStats["num"]

	poisonStats["total"]/=       poisonStats["num"]
	poisonStats["HP"]/=          poisonStats["num"]
	poisonStats["attack"]/=      poisonStats["num"]
	poisonStats["defense"]/=     poisonStats["num"]
	poisonStats["SPattack"]/=    poisonStats["num"]
	poisonStats["SPdefense"]/=   poisonStats["num"]
	poisonStats["speed"]/=       poisonStats["num"]

	psychicStats["total"]/=       psychicStats["num"]
	psychicStats["HP"]/=          psychicStats["num"]
	psychicStats["attack"]/=      psychicStats["num"]
	psychicStats["defense"]/=     psychicStats["num"]
	psychicStats["SPattack"]/=    psychicStats["num"]
	psychicStats["SPdefense"]/=   psychicStats["num"]
	psychicStats["speed"]/=       psychicStats["num"]

	rockStats["total"]/=       rockStats["num"]
	rockStats["HP"]/=          rockStats["num"]
	rockStats["attack"]/=      rockStats["num"]
	rockStats["defense"]/=     rockStats["num"]
	rockStats["SPattack"]/=    rockStats["num"]
	rockStats["SPdefense"]/=   rockStats["num"]
	rockStats["speed"]/=       rockStats["num"]

	steelStats["total"]/=       steelStats["num"]
	steelStats["HP"]/=          steelStats["num"]
	steelStats["attack"]/=      steelStats["num"]
	steelStats["defense"]/=     steelStats["num"]
	steelStats["SPattack"]/=    steelStats["num"]
	steelStats["SPdefense"]/=   steelStats["num"]
	steelStats["speed"]/=       steelStats["num"]

	waterStats["total"]/=       waterStats["num"]
	waterStats["HP"]/=          waterStats["num"]
	waterStats["attack"]/=      waterStats["num"]
	waterStats["defense"]/=     waterStats["num"]
	waterStats["SPattack"]/=    waterStats["num"]
	waterStats["SPdefense"]/=   waterStats["num"]
	waterStats["speed"]/=       waterStats["num"]
	print "------------------------------------------------------------------"
	print "Most Powerful Pokemon:\n"
	print "Stat Total of " strongestTotal " - " strongestName
	print "------------------------------------------------------------------"
	print "Most Powerful Pokemon of Each Type:\n"
	print "Bug:        " powBug
	print "Dark:       " powDark 
	print "Dragon:     " powDragon
	print "Electric:   " powElectric
	print "Fairy:      " powFairy
	print "Fighting:   " powFighting
	print "Fire:       " powFire
	print "Flying:     " powFlying
	print "Ghost:      " powGhost
	print "Grass:      " powGrass
	print "Ground:     " powGround
	print "Ice:        " powIce
	print "Normal:     " powNormal
	print "Poison:     " powPoison
	print "Psychic:    " powPsychic
	print "Rock:       " powRock
	print "Steel:      " powSteel
	print "Water:      " powWater
	print "------------------------------------------------------------------"
	print "Pokemon With Highest Stats:\n"
	print "HP Stat of " highestHP ":           " HPname
	print "Attack Stat of " highestAttack ":       " attackName
	print "Defense Stat of " highestDefense ":      " defenseName
	print "SP Attack Stat of " highestSPattack ":    " SPattackName
	print "SP Defense Stat of " highestSPdefense ":   " SPdefenseName
	print "Speed Stat of " highestSpeed ":        " speedName
	print "------------------------------------------------------------------"
	print "Average Stats Of All Pokemon:\n"
	print "Total:      " avgTotal
	print "HP:          " avgHP
	print "Attack:      " avgAttack
	print "Defense:     " avgDefense
	print "SP Attack:   " avgSPAttack
	print "SP Defense:  " avgSPDefense
	print "Speed:       " avgSpeed
	print "------------------------------------------------------------------"
	print "Average Stats of All Types:\n"
	print "Bug:        "
	print "      " "Total -      " bugStats["total"]
	print "      " "HP -          " bugStats["HP"]
	print "      " "Attack -      " bugStats["attack"]
	print "      " "Defense -     " bugStats["defense"]
	print "      " "SP Attack -   " bugStats["SPattack"]
	print "      " "SP Defense -  " bugStats["SPdefense"]
	print "      " "Speed -       " bugStats["speed"]
	print "Dark:       "
       	print "      " "Total -      " darkStats["total"]
	print "      " "HP -          " darkStats["HP"]
	print "      " "Attack -      " darkStats["attack"]
	print "      " "Defense -     " darkStats["defense"]
	print "      " "SP Attack -   " darkStats["SPattack"]
	print "      " "SP Defense -  " darkStats["SPdefense"]
	print "      " "Speed -       " darkStats["speed"]
	print "Dragon:     " 
	print "      " "Total -      " dragonStats["total"]
	print "      " "HP -          " dragonStats["HP"]
	print "      " "Attack -     " dragonStats["attack"]
	print "      " "Defense -     " dragonStats["defense"]
	print "      " "SP Attack -   " dragonStats["SPattack"]
	print "      " "SP Defense -  " dragonStats["SPdefense"]
	print "      " "Speed -       " dragonStats["speed"]
	print "Electric:   " 
	print "      " "Total -      " electricStats["total"]
	print "      " "HP -          " electricStats["HP"]
	print "      " "Attack -      " electricStats["attack"]
	print "      " "Defense -     " electricStats["defense"]
	print "      " "SP Attack -   " electricStats["SPattack"]
	print "      " "SP Defense -  " electricStats["SPdefense"]
	print "      " "Speed -       " electricStats["speed"]
	print "Fairy:      " 
	print "      " "Total -      " fairyStats["total"]
	print "      " "HP -          " fairyStats["HP"]
	print "      " "Attack -      " fairyStats["attack"]
	print "      " "Defense -     " fairyStats["defense"]
	print "      " "SP Attack -   " fairyStats["SPattack"]
	print "      " "SP Defense -  " fairyStats["SPdefense"]
	print "      " "Speed -       " fairyStats["speed"]
	print "Fighting:   " 
	print "      " "Total -      " fightingStats["total"]
	print "      " "HP -          " fightingStats["HP"]
	print "      " "Attack -     " fightingStats["attack"]
	print "      " "Defense -     " fightingStats["defense"]
	print "      " "SP Attack -   " fightingStats["SPattack"]
	print "      " "SP Defense -  " fightingStats["SPdefense"]
	print "      " "Speed -       " fightingStats["speed"]
	print "Fire:       " 
	print "      " "Total -      " fireStats["total"]
	print "      " "HP -          " fireStats["HP"]
	print "      " "Attack -      " fireStats["attack"]
	print "      " "Defense -     " fireStats["defense"]
	print "      " "SP Attack -   " fireStats["SPattack"]
	print "      " "SP Defense -  " fireStats["SPdefense"]
	print "      " "Speed -       " fireStats["speed"]
	print "Flying:     " 
	print "      " "Total -      " flyingStats["total"]
	print "      " "HP -          " flyingStats["HP"]
	print "      " "Attack -      " flyingStats["attack"]
	print "      " "Defense -     " flyingStats["defense"]
	print "      " "SP Attack -   " flyingStats["SPattack"]
	print "      " "SP Defense -  " flyingStats["SPdefense"]
	print "      " "Speed -       " flyingStats["speed"]
	print "Ghost:      " 
	print "      " "Total -      " ghostStats["total"]
	print "      " "HP -          " ghostStats["HP"]
	print "      " "Attack -      " ghostStats["attack"]
	print "      " "Defense -     " ghostStats["defense"]
	print "      " "SP Attack -   " ghostStats["SPattack"]
	print "      " "SP Defense -  " ghostStats["SPdefense"]
	print "      " "Speed -       " ghostStats["speed"]
	print "Grass:      " 
	print "      " "Total -      " grassStats["total"]
	print "      " "HP -          " grassStats["HP"]
	print "      " "Attack -      " grassStats["attack"]
	print "      " "Defense -     " grassStats["defense"]
	print "      " "SP Attack -   " grassStats["SPattack"]
	print "      " "SP Defense -  " grassStats["SPdefense"]
	print "      " "Speed -       " grassStats["speed"]
	print "Ground:     " 
	print "      " "Total -      " groundStats["total"]
	print "      " "HP -          " groundStats["HP"]
	print "      " "Attack -      " groundStats["attack"]
	print "      " "Defense -     " groundStats["defense"]
	print "      " "SP Attack -   " groundStats["SPattack"]
	print "      " "SP Defense -  " groundStats["SPdefense"]
	print "      " "Speed -       " groundStats["speed"]
	print "Ice:        " 
	print "      " "Total -      " iceStats["total"]
	print "      " "HP -          " iceStats["HP"]
	print "      " "Attack -      " iceStats["attack"]
	print "      " "Defense -     " iceStats["defense"]
	print "      " "SP Attack -   " iceStats["SPattack"]
	print "      " "SP Defense -  " iceStats["SPdefense"]
	print "      " "Speed -       " iceStats["speed"]
	print "Normal:     " 
	print "      " "Total -      " normalStats["total"]
	print "      " "HP -          " normalStats["HP"]
	print "      " "Attack -      " normalStats["attack"]
	print "      " "Defense -     " normalStats["defense"]
	print "      " "SP Attack -   " normalStats["SPattack"]
	print "      " "SP Defense -  " normalStats["SPdefense"]
	print "      " "Speed -       " normalStats["speed"]
	print "Poison:     " 
	print "      " "Total -      " poisonStats["total"]
	print "      " "HP -          " poisonStats["HP"]
	print "      " "Attack -      " poisonStats["attack"]
	print "      " "Defense -     " poisonStats["defense"]
	print "      " "SP Attack -   " poisonStats["SPattack"]
	print "      " "SP Defense -  " poisonStats["SPdefense"]
	print "      " "Speed -       " poisonStats["speed"]
	print "Psychic:    " 
	print "      " "Total -      " psychicStats["total"]
	print "      " "HP -          " psychicStats["HP"]
	print "      " "Attack -      " psychicStats["attack"]
	print "      " "Defense -     " psychicStats["defense"]
	print "      " "SP Attack -   " psychicStats["SPattack"]
	print "      " "SP Defense -  " psychicStats["SPdefense"]
	print "      " "Speed -       " psychicStats["speed"]
	print "Rock:       " 
	print "      " "Total -      " rockStats["total"]
	print "      " "HP -          " rockStats["HP"]
	print "      " "Attack -      " rockStats["attack"]
	print "      " "Defense -    " rockStats["defense"]
	print "      " "SP Attack -   " rockStats["SPattack"]
	print "      " "SP Defense -  " rockStats["SPdefense"]
	print "      " "Speed -       " rockStats["speed"]
	print "Steel:      " 
	print "      " "Total -      " steelStats["total"]
	print "      " "HP -          " steelStats["HP"]
	print "      " "Attack -      " steelStats["attack"]
	print "      " "Defense -    " steelStats["defense"]
	print "      " "SP Attack -   " steelStats["SPattack"]
	print "      " "SP Defense -  " steelStats["SPdefense"]
	print "      " "Speed -       " steelStats["speed"]
	print "Water:      " 
	print "      " "Total -      " waterStats["total"]
	print "      " "HP -          " waterStats["HP"]
	print "      " "Attack -      " waterStats["attack"]
	print "      " "Defense -     " waterStats["defense"]
	print "      " "SP Attack -   " waterStats["SPattack"]
	print "      " "SP Defense -  " waterStats["SPdefense"]
	print "      " "Speed -       " waterStats["speed"]
	print "------------------------------------------------------------------"
}
