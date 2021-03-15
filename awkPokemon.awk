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
powDark = ""
bugTotal = 0
powDragon = ""
powElectric = ""
powFairy = ""
powFighting = ""
powFire = ""
powFlying = ""
powGhost = ""
powGrass = ""
powGround = ""
powIce = ""
powNormal = ""
powPoison = ""
powPsychic = ""
powRock = ""
powSteel = ""
powWater = ""
}

/Mega /{
	while(substr($2,0,4)!~"Mega"){
		
		$2=substr($2,2)
	}
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
		if(bugTotal<$5){
			bugTotal = $5
			powBug = $2
		}
		else if (bugTotal == $5){
			powBug = powBug ", " $2
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
	print "------------------------------------------------"
	print "Most Powerful Pokemon- Stat Total of " strongestTotal
	print strongestName
	print "------------------------------------------------"
	print "Average Stats Of All Pokemon:"
	print "Total:      " avgTotal
	print "HP:         " avgHP
	print "Attack:     " avgAttack
	print "Defense:    " avgDefense
	print "SP Attack:  " avgSPAttack
	print "SP Defense: " avgSPDefense
	print "Speed:      " avgSpeed
	print "------------------------------------------------"
	print "Most Powerful Pokemon of Each Type:"
	print "Bug:      " powBug
	print "Dark:     " 
	print "Dragon:   " 
	print "Electric: " 
	print "Fairy:    " 
	print "Fighting: " 
	print "Fire:     " 
	print "Flying:   " 
	print "Ghost:    " 
	print "Grass:    " 
	print "Ground:   " 
	print "Ice:      " 
	print "Normal:   " 
	print "Poison:   " 
	print "Psychic:  " 
	print "Rock:     " 
	print "Steel:    " 
	print "Water:    " 
	print "------------------------------------------------"
}		
