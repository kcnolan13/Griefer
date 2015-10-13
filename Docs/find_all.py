import os
import glob

searchTerms = ['keyboard_check']

paths = ['C:\Users\Kyle\GRIEFER_LOCAL\Griefer_v0-105.gmx\scripts','C:\Users\Kyle\GRIEFER_LOCAL\Griefer_v0-105.gmx\objects']
for path in paths:
	for filename in os.listdir(path):
		fName = path+"\\"+filename
		#if "abort_match.gml" in fName:
		if not os.path.isdir(path+"\\"+filename):
			with open(fName,'r+') as f:
				#print "\n"+filename
				sep = False
				lines = f.readlines()
				f.close()
				#if ("player.object.gmx" in fName):
				with open(fName,'r+') as f:
					#print filename+str(len(lines))
					lnum = 0
					for ind in range(0,len(lines)):
						lnum = lnum+1
						#kill prints with no if statement in the line before
						#if not " if " in lines[ind] and (ind < len(lines)-1):
						#	lines[ind+1] = lines[ind+1].replace("printf","//printf")
						for searchTerm in searchTerms:
							if searchTerm in lines[ind].replace(" ",""):
								if not sep:
									sep = True
									print ""
								print str(lnum)+":  "+filename+":  "+lines[ind].strip()
						
						#if "whoName" not in lines[ind]:
						#	lines[ind] = lines[ind].replace("self","id")

						#lines[ind] = lines[ind].replace("<whoName>id</whoName>","<whoName>self</whoName>")
						#f.write(lines[ind])
					f.close()