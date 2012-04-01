NAME = piratebox-scripts
VERSION = 0.4
ARCH = all
PB_FOLDER=piratebox

PACKAGE_NAME=$(NAME)_$(VERSION)
PACKAGE=$(PACKAGE_NAME).tar.gz
VERSION_FILE=$(PB_FOLDER)/$(PB_FOLDER)/version

.DEFAULT_GOAL = all

$(VERSION):	
	echo "$(PACKAGE_NAME)" >  $(VERSION_FILE)

$(PACKAGE):  $(VERSION)
	tar czf $@ $(PB_FOLDER) 



all: $(PACKAGE)

clean: 
	rm -f $(PACKAGE)
	rm -f $(VERSION_FILE)

.PHONY: all clean

