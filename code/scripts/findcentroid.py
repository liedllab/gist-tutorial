

from os.path import basename
#from more_itertools import unique_everseen #make sure more_itertools is installed (conda install more-itertools)
from math import sqrt
from math import floor



import argparse


parser = argparse.ArgumentParser()
requiredNamed = parser.add_argument_group('required arguments')
#requiredNamed.add_argument("-d", dest='threshold', help="distance threshold for atoms near waters", type=float, default=4.0, required=True)
requiredNamed.add_argument("-i", dest='structure', help="input file, expected to be in .pdb format", type=str, required=True)
parser.add_argument("-e", dest='Even', help="boolean to set the dimensions to even by default", default=False, type=bool)
args = parser.parse_args()

filenames = []


filenames.append(basename(args.structure[:-4]))

print(filenames)
#print args.threshold
#structure = sys.argv[1]
#distance_cutoff = sys.argv[2]
# HOLDS IN INFORMATION OF ATOM
ATOM = []
# HOLDS IN ALL NON HOH ATOMS THAT ARE LABELED HETAM
HETAM = []
# HOLDS ALL THE HOH ATOMS
HETAMHOH = []
DIS = []
Unique = []
newHOH =[]  
Vectors = []
Dictionary = {}




#POINT CLASS USED TO HOLD POINTS OF ALL DIFFERENT ATOMS
class Point:
    #STORES THE X Y AND Z COORDINATES
        def __init__(Self,x, y , z ):
                Self.x = x
                Self.y = y
                Self.z = z
        #FINDS DISTANCE BETWEEN TWO POINTS
        def Distance(firstpoint, secondPoint):
        	d = sqrt(((firstpoint.x-secondPoint.x)**2)+
                    ((firstpoint.y-secondPoint.y)**2)+
                    ((firstpoint.z-secondPoint.z)**2))
        	return d
        def length(Self):
          return sqrt((float(Self.x)**2)+(float(Self.y)**2)+(float(Self.z)**2))

		#SHOWS OUTPUT
        def __str__(Self):
                return(str(Self.x) + "," + str(Self.y)+ "," + str(Self.z))

class Atom:
  #ATOM CLASS HOLDS INFORMATION READ IN FROM FILE

  def __init__(Self,name,idnum,char,tp,att1,att2,x,y,z,av,bv,n,line):
    Self.name = name
    Self.idnum = idnum
    Self.Element = char
    Self.res = tp
    Self.chain = att1
    Self.resnum = att2
    Self.point = Point(float(x),float(y),float(z))
    Self.AValue = av
    Self.BValue = bv
    Self.AtomN = n
    Self.line = line
    Self.Acceptor = True
    Self.HOHDIS = ""
    Self.Associate = ""
    Self.nearHeavyAtom = ""
    Self.nearHydrogen = []
  def setnearHydrogen(Self, H):
    Self.nearHydrogen.append(H)
  def setnearHeavyAtom(Self, HA):
    Self.nearHeavyAtom = HA
  def setHOHDIS(Self, HOHnum):
    Self.HOHDIS = HOHnum
  def setAssociate(Self, HOH):
    Self.Associate = HOH
  def getPoint(Self):
    return Self.point
  def changeAcceptor(Self):
    Self.Acceptor = False
  def getLine(Self):
    return Self.line
  def checkSame(self, Atom):
    # Simple check function that will return true if two atoms have the same name and same coordinates
    if self.name == Atom.name and self.point == Atom.point:
        return True
    else: return False
  def __str__(Self):
    return Self.line

def parseData(line):
    if "CRYST1" in line or "REMARK" in line or "END" in line: 
        print("Skipping comment line")
        return
    if not('CL') in line and not('NA') in line and not('MG') in line and not('SO4') in line and not('PO4') in line:
    #LINE IS AN INDIVIDUAL LINE IN THE FILE
      #if "ATOM" in line[0:6]:
    # READS IN INFORMATION IF IT IS AN ATOM AND STORES IN ATOM ARRAY
        name = line[0:6]
        idnum = line[6:11]
        char = line[11:16]
        tp = line[16:20]
        att1 = line[20:23]
        att2 =line[23:26]
        x = line[26:38]
        y = line[38:46]
        z = line[46:54]
        av = line[55:61]
        bv = line[60:66]
        n = line[67:79]
        ATOM.append(Atom(name,idnum,char,tp,att1,att2,x,y,z,av,bv,n,line))

    return


def printCentroid():
    #print("in centroid")
    #print(len(ATOM))
    x = 0.0
    y = 0.0
    z = 0.0
    maxx = 0.0
    maxy = 0.0
    maxz = 0.0
    minx = 1000.0
    miny = 1000.0
    minz = 1000.0
    count = 0
    for atom in ATOM:
        x+=atom.point.x
        y+=atom.point.y
        z+=atom.point.z
        maxx = max(maxx, atom.point.x)
        minx = min(minx, atom.point.x)
        maxy = max(maxy, atom.point.y)
        miny = min(miny, atom.point.y)
        maxz = max(maxz, atom.point.z)
        minz = min(minz, atom.point.z)
        count+=1
    
    
    x/=float(count)
    y/=float(count)
    z/=float(count)
    
    print("Centroid is:")
    
    print(x, y, z)
    
    print("Ranges are:")
    print("x:  ", minx, maxx)
    print("y:  ", miny, maxy)
    print("z:  ", minz, maxz)
    
    rangex = maxx-minx
    rangey = maxy-miny
    rangez = maxz-minz
    
    rangex*=5
    rangey*=5
    rangez*=5

    rangex=round(rangex)
    rangey=round(rangey)
    rangez=round(rangez)
    
    if (args.Even):
        if (rangex%2):
            rangex+=1
        if (rangey%2):
            rangey+=1
        if (rangez%2):
            rangez+=1
    
    rangex = int(rangex)
    rangey = int(rangey)
    rangez = int(rangez)

    print("Recommended gist input command given input file (presumed ligand or binding cavity .pdb file)")
    print("gist gridspacn 0.5 gridcntr {0:6.3f} {1:6.3f} {2:6.3f} griddim {3} {4} {5}".format(x,y,z,rangex,rangey,rangez) )
    
    return



f = open(args.structure, "r")                      
#GETS ALL THE LINES AND SAVES ALL THE LINES INTO LINES
lines = f.readlines()
#LINE COUNT 
for line in lines:
    #print(line)
    parseData(line)
       
f.close()
    
printCentroid()
    
    
