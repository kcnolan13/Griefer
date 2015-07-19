import os
import glob

paths = ['E:\Griefer\Griefer.gmx\scripts','E:\Griefer\Griefer.gmx\objects','E:\Griefer\GriefPlusPlus','E:\Griefer\GriefPlusPlus\src','E:\Griefer\GriefNode','E:\Griefer\GriefNode\lib']
exclusions = ['E:\Griefer\GriefPlusPlus\src\internal','E:\Griefer\GriefPlusPlus\lib','E:\Griefer\GriefNode\\node_modules','E:\Griefer\GriefNode\log','E:\Griefer\GriefNode\deprecated']
line_total = 0
for path in paths:
	path_total = 0
	for filename in os.listdir(path):
		fName = path+"\\"+filename
		#if "abort_match.gml" in fName:
		if not os.path.isdir(path+"\\"+filename):
			with open(fName,'r+') as f:
				#print "\n"+filename
				line_count = 0
				lines = f.readlines()
				f.close()
				#print filename+str(len(lines))
				lnum = 0
				for ind in range(0,len(lines)):
					lnum = lnum+1
					line = lines[ind].strip()
					if (line.startswith('<') and line.endswith('>')) or any(path is exclusion for exclusion in exclusions):
						#print "excluding: "+line
						lnum = lnum
					else:
						line_count = line_count + 1
						path_total = path_total + 1
						#print line

				print str(line_count)+"\t:\t"+fName
				line_total = line_total+line_count
	print "-------\n"+str(path_total)+" Original Lines In: "+path+"\n"
print "\n=======================\n"+str(line_total)+" ORIGINAL LINES IN GRIEFER"