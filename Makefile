JAVAC = javac
JVM = java
JAVADOC = javadoc
MKBIN = mkdir -p bin

JAVAC_FLAGS = -g -d 'bin/'
JAVAC_CP = -cp

TEST_RUNNER = org.junit.runner.JUnitCore

MAINSRC = src/main/java/
TESTSRC = src/test/java/
LIB = 'src/test/lib/*:src/main/java:bin'

PKGSRC = <PLACE PACKAGE NAME HERE>/
TARGET = bin/

MAIN = $(PKGSRC).<PLACE MAIN CLASS NAME HERE>

MAINTEST = $(PKGSRC).<PLACE TEST CLASS NAME HERE>

.SUFFIXES : .class .java

all:
	$(MKBIN)
	$(JAVAC) $(JAVAC_FLAGS) $(MAINSRC)$(PKGSRC)*

test:
	$(JAVAC) $(JAVAC_FLAGS) $(JAVAC_CP) $(LIB) $(TESTSRC)$(PKGSRC)*

clean:
	rm -rf $(TARGET)

run:
	$(JVM) $(JAVAC_CP) $(TARGET) $(MAIN)

run_test:
	$(JVM) $(JAVAC_CP) $(LIB) $(TEST_RUNNER) $(MAINTEST)

.PHONY: all test clean run run_test
