BEGIN{
FS =","
strongestTotal = 0
strongestName = None
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
	

END{
	print "Most Powerful Pokemon- Stat Total of " strongestTotal
	print strongestName
}		
