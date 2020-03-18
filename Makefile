KSPDIR		:= ${HOME}/ksp/KSP_linux
MANAGED		:= ${KSPDIR}/KSP_Data/Managed
GAMEDATA	:= ${KSPDIR}/GameData
KGAMEDATA  := ${GAMEDATA}/Kethane
PLUGINDIR	:= ${KGAMEDATA}/Plugins

TARGETS		:= bin/GeodesicGrid.dll

GEO_FILES := \
	BoundsMap.cs	\
	Cell.cs	\
	CellMap.cs	\
	CellSet.cs	\
	ChildType.cs	\
	EnumerableExtensions/Edges.cs	\
	EnumerableExtensions/MinMaxBy.cs	\
	EnumerableExtensions/Pair.cs	\
	EnumerableExtensions/Repeat.cs	\
	EnumerableExtensions/ReverseComparer.cs	\
	IntMath.cs	\
	LicenseSentinel.cs	\
	Properties/AssemblyInfo.cs	\
	Triangle.cs	\
	TriangleHit.cs	\
	$e

RESGEN2		:= resgen2
GMCS		:= mcs
GMCSFLAGS	:= -optimize -debug
GIT			:= git
TAR			:= tar
ZIP			:= zip

#all: version ${TARGETS}
all: ${TARGETS}

.PHONY: version
version:
	@./tools/git-version.sh

info:
	@echo "GeodesicGrid Build Information"
	@echo "    resgen2:    ${RESGEN2}"
	@echo "    gmcs:       ${GMCS}"
	@echo "    gmcs flags: ${GMCSFLAGS}"
	@echo "    git:        ${GIT}"
	@echo "    tar:        ${TAR}"
	@echo "    zip:        ${ZIP}"
	@echo "    KSP Data:   ${KSPDIR}"

bin/GeodesicGrid.dll: ${GEO_FILES}
	@mkdir -p bin
	${GMCS} ${GMCSFLAGS} -t:library -lib:${MANAGED} \
		-r:UnityEngine.CoreModule \
		-resource:GeodesicGrid-LICENSE.txt,GeodesicGrid.GeodesicGrid-LICENSE.txt \
		-out:$@ $^

clean:
	rm -f ${TARGETS} assembly/AssemblyInfo.cs bin/GeodesicGrid.version
	test -d bin && rm -rf bin || true

install: all
	mkdir -p ${PLUGINDIR}
	cp ${TARGETS} ${PLUGINDIR}
#cp ${TARGETS} bin/GeodesicGrid.version ${PLUGINDIR}

.PHONY: all clean install
