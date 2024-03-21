import subprocess
import os

outFileName = 'actions/zoom-original'
svgFileName = 'actions/zoom/zoom-original'

altShadow = True
noShadow = False

svgBasePath = '/home/klapeto/KDE-plasma-luna/icons-svg/'
outBasePath = '/home/klapeto/KDE-plasma-luna/home/dot-local/icons/Luna/'
styleBasePath = '/home/klapeto/KDE-plasma-luna/shadow-styles/'

sizes = [512,256,128,96,64,48,32,24,22,16]

lastSvgFile = ''

for x in sizes:
    outFilePath = outBasePath + str(x) + 'x' + str(x) + '/' + outFileName + '.png'
    svgFilePath = svgBasePath + svgFileName + '.' + str(x) + '.svg'
    if not os.path.exists(svgFilePath):
        if lastSvgFile != '' and os.path.exists(lastSvgFile):
            svgFilePath = lastSvgFile
        else:
            svgFilePath = svgBasePath + svgFileName + '.svg'
    lastSvgFile = svgFilePath
    print(lastSvgFile)
    subprocess.run(["inkscape", "-w", str(x), "-h", str(x), "-o", outFilePath, svgFilePath], capture_output=True)
    stylePath = styleBasePath + 'shadow' + ('-alt' if altShadow else '') + '.' + str(x) + '.asl'
    styleFile = open(stylePath);
    style = styleFile.read();
    styleFile.close()
    currentDoc = Krita.instance().openDocument(outFilePath)
    currentLayer = currentDoc.nodeByName('Background')
    if not noShadow:
        currentLayer.setLayerStyleFromAsl(style)
    currentDoc.setBatchmode(True)
    currentDoc.save()
    currentDoc.close()

