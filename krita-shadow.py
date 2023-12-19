fileName = 'apps/internet-web-browser'
basePath = '/home/klapeto/KDE-plasma-luna/home/dot-local/icons/Luna/'
styleBasePath = '/home/klapeto/KDE-plasma-luna/shadow-styles/'

sizes = [16,22,24,32,48,64,96,128,256,512]

for x in sizes:
    filePath = basePath + str(x) + 'x' + str(x) + '/' + fileName + '.png'
    stylePath = styleBasePath + 'shadow.' + str(x) + '.asl'
    styleFile = open(stylePath);
    style = styleFile.read();
    styleFile.close()
    currentDoc = Krita.instance().openDocument(filePath)
    currentLayer = currentDoc.nodeByName('Background')
    currentLayer.setLayerStyleFromAsl(style)
    currentDoc.setBatchmode(True)
    currentDoc.save()
    currentDoc.close()

