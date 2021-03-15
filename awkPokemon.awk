BEGIN{
FS =","
strongestTotal = 0
strongestName = ""
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

{
	if (strongestTotal < $5 && $2!= "Name"){
		strongestTotal = $5
		strongestName=$2
		}
	else if (strongestTotal == $5 && $2!= "Name"){
		strongestName= strongestName "\n"
		strongestName= strongestName $2
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
		if(darkTotal<$5){
			darkTotal = $5
			powDark = $2
		}
		else if (darkTotal == $5){
			powDark = powDark ", " $2
		}
	 }
	 if($3 == "Dragon" ||  $4 == "Dragon" ){
		 if(dragonTotal<$5){
			 dragonTotal = $5
			 powDragon = $2
		 }
		 else if (dragonTotal == $5){
			 powDragon = powDragon ", " $2
	 	 }
	 
	 }
	 if($3 == "Electric" ||  $4 == "Electric" ){

		 if(electricTotal<$5){

			 electricTotal = $5

			 powElectric = $2

		 }

		 else if (electricTotal == $5){

			 powElectric = powElectric ", " $2

		 }

	}
	if($3 == "Fairy" ||  $4 == "Fairy" ){

		if(fairyTotal<$5){

			fairyTotal = $5

			powFairy = $2

		}

		else if (fairyTotal == $5){

			powFairy = powFairy ", " $2

		}

		        }
	if($3 == "Fighting" ||  $4 == "Fighting" ){

		if(fightingTotal<$5){

			fightingTotal = $5

			powFighting = $2

		}

		else if (fightingTotal == $5){

			powFighting = powFighting ", " $2

		}

	}
	if($3 == "Fire" ||  $4 == "Fire" ){

		if(fireTotal<$5){

			fireTotal = $5

			powFire = $2

		}

		else if (fireTotal == $5){

			powFire = powFire ", " $2

		}

	}
	if($3 == "Flying" ||  $4 == "Flying" ){
		if(flyingTotal<$5){
			flyingTotal = $5
			powFlying = $2
		}
		else if (flyingTotal == $5){
			powFlying = powFlying ", " $2
		}
	}
	if($3 == "Ghost" ||  $4 == "Ghost" ){
		if(ghostTotal<$5){
			ghostTotal = $5
			powGhost = $2
		}
		else if (ghostTotal == $5){
			powGhost = powGhost ", " $2
		}
	}
	if($3 == "Grass" ||  $4 == "Grass" ){

		if(grassTotal<$5){

			grassTotal = $5

			powGrass = $2

		}

		else if (grassTotal == $5){

			powGrass = powGrass ", " $2

		}

	}
	if($3 == "Ground" ||  $4 == "Ground" ){

		if(groundTotal<$5){

			groundTotal = $5

			powGround = $2

		}

		else if (groundTotal == $5){

			powGround = powGround ", " $2

		}

	}
	if($3 == "Ice" ||  $4 == "Ice" ){

		if(iceTotal<$5){

			iceTotal = $5

			powIce = $2

		}

		else if (iceTotal == $5){

			powIce = powIce ", " $2

		}

	}
	if($3 == "Normal" ||  $4 == "Normal" ){

		if(normalTotal<$5){

			normalTotal = $5

			powNormal = $2

		}

		else if (normalTotal == $5){

			powNormal = powNormal ", " $2

		}

	}
	if($3 == "Poison" ||  $4 == "Poison" ){

		if(poisonTotal<$5){

			poisonTotal = $5

			powPoison = $2

		}

		else if (poisonTotal == $5){

			powPoison = powPoison ", " $2

		}

	}
	if($3 == "Psychic" ||  $4 == "Psychic" ){

		if(psychicTotal<$5){

			psychicTotal = $5

			powPsychic = $2

		}

		else if (psychicTotal == $5){

			powPsychic = powPsychic ", " $2

		}

	}
	if($3 == "Rock" ||  $4 == "Rock" ){

	if(rockTotal<$5){

		rockTotal = $5

		powRock = $2

	}

	else if (rockTotal == $5){

		powRock = powRock ", " $2

	}

	}
	if($3 == "Steel" ||  $4 == "Steel" ){

		if(steelTotal<$5){

			steelTotal = $5

			powSteel = $2

	}

	else if (steelTotal == $5){

		powSteel = powSteel ", " $2

	}
	}

	
	if($3 == "Water" ||  $4 == "Water" ){

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
	bugStats["total"]/=bugStats["num"]

	dragonStats["HP"]/=          dragonStats["num"]
	dragonStats["attack"]/=      dragonStats["num"]
	dragonStats["defense"]/=     dragonStats["num"]
	dragonStats["SPattack"]/=    dragonStats["num"]
	dragonStats["SPdefense"]/=   dragonStats["num"]
	dragonStats["speed"]/=       dragonStats["num"]

	electricStats["HP"]/=          electricStats["num"]
	electricStats["attack"]/=      electricStats["num"]
	electricStats["defense"]/=     electricStats["num"]
	electricStats["SPattack"]/=    electricStats["num"]
	electricStats["SPdefense"]/=   electricStats["num"]
	electricStats["speed"]/=       electricStats["num"]

	fairyStats["HP"]/=          fairyStats["num"]
	fairyStats["attack"]/=      fairyStats["num"]
	fairyStats["defense"]/=     fairyStats["num"]
	fairyStats["SPattack"]/=    fairyStats["num"]
	fairyStats["SPdefense"]/=   fairyStats["num"]
	fairyStats["speed"]/=       fairyStats["num"]

	fightingStats["HP"]/=          fightingStats["num"]
	fightingStats["attack"]/=      fightingStats["num"]
	fightingStats["defense"]/=     fightingStats["num"]
	fightingStats["SPattack"]/=    fightingStats["num"]
	fightingStats["SPdefense"]/=   fightingStats["num"]
	fightingStats["speed"]/=       fightingStats["num"]

	fireStats["HP"]/=          fireStats["num"]
	fireStats["attack"]/=      fireStats["num"]
	fireStats["defense"]/=     fireStats["num"]
	fireStats["SPattack"]/=    fireStats["num"]
	fireStats["SPdefense"]/=   fireStats["num"]
	fireStats["speed"]/=       fireStats["num"]

	flyingStats["HP"]/=          flyingStats["num"]
	flyingStats["attack"]/=      flyingStats["num"]
	flyingStats["defense"]/=     flyingStats["num"]
	flyingStats["SPattack"]/=    flyingStats["num"]
	flyingStats["SPdefense"]/=   flyingStats["num"]
	flyingStats["speed"]/=       flyingStats["num"]

	ghostStats["HP"]/=          ghostStats["num"]
	ghostStats["attack"]/=      ghostStats["num"]
	ghostStats["defense"]/=     ghostStats["num"]
	ghostStats["SPattack"]/=    ghostStats["num"]
	ghostStats["SPdefense"]/=   ghostStats["num"]
	ghostStats["speed"]/=       ghostStats["num"]

	grassStats["HP"]/=          grassStats["num"]
	grassStats["attack"]/=      grassStats["num"]
	grassStats["defense"]/=     grassStats["num"]
	grassStats["SPattack"]/=    grassStats["num"]
	grassStats["SPdefense"]/=   grassStats["num"]
	grassStats["speed"]/=       grassStats["num"]

	groundStats["HP"]/=          groundStats["num"]
	groundStats["attack"]/=      groundStats["num"]
	groundStats["defense"]/=     groundStats["num"]
	groundStats["SPattack"]/=    groundStats["num"]
	groundStats["SPdefense"]/=   groundStats["num"]
	groundStats["speed"]/=       groundStats["num"]

	iceStats["HP"]/=          iceStats["num"]
	iceStats["attack"]/=      iceStats["num"]
	iceStats["defense"]/=     iceStats["num"]
	iceStats["SPattack"]/=    iceStats["num"]
	iceStats["SPdefense"]/=   iceStats["num"]
	iceStats["speed"]/=       iceStats["num"]

	normalStats["HP"]/=          normalStats["num"]
	normalStats["attack"]/=      normalStats["num"]
	normalStats["defense"]/=     normalStats["num"]
	normalStats["SPattack"]/=    normalStats["num"]
	normalStats["SPdefense"]/=   normalStats["num"]
	normalStats["speed"]/=       normalStats["num"]
	print "---------------------------------------------------------------"
	print "Most Powerful Pokemon- Stat Total of " strongestTotal
	print strongestName
	print "---------------------------------------------------------------"
	print "Average Stats Of All Pokemon:"
	print "Total:      " avgTotal
	print "HP:          " avgHP
	print "Attack:      " avgAttack
	print "Defense:     " avgDefense
	print "SP Attack:   " avgSPAttack
	print "SP Defense:  " avgSPDefense
	print "Speed:       " avgSpeed
	print "---------------------------------------------------------------"
	print "Most Powerful Pokemon of Each Type:"
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
	print "---------------------------------------------------------------"
	print "Average Stats of All Types:"
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
	print "      " "Attack -      " dragonStats["attack"]
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
	print "      " "Attack -      " fightingStats["attack"]
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
	print "      " "Defense -     " rockStats["defense"]
	print "      " "SP Attack -   " rockStats["SPattack"]
	print "      " "SP Defense -  " rockStats["SPdefense"]
	print "      " "Speed -       " rockStats["speed"]
	print "Steel:      " 
	print "      " "Total -      " steelStats["total"]
	print "      " "HP -          " steelStats["HP"]
	print "      " "Attack -      " steelStats["attack"]
	print "      " "Defense -     " steelStats["defense"]
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
	print "---------------------------------------------------------------"
}
