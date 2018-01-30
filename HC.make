
HCC = hcc

CXXFLAGS+=-O3 $(shell hcc-config --cxxflags)
LDFLAGS+=$(shell hcc-config --ldflags)

ifdef MANAGED
MEM=-DMANAGED
else
MEM=-DCOPY
endif 

ifdef READ
RW=-DREAD_ONLY
endif
ifdef WRITE
RW=-DWRITE_ONLY
endif
ifdef READ_WRITE
RW=-DREAD_WRITE
endif 

ifdef TBSIZE
CXXFLAGS+=-DVIRTUALTILESIZE=$(TBSIZE)
endif

ifdef NTILES
CXXFLAGS+=-DNTILES=$(TBSIZE)
endif


hc-stream: main.cpp HCStream.cpp
	$(HCC) $(CXXFLAGS) $(MEM) $(RW) -DHC  $^  $(LDFLAGS) $(EXTRA_FLAGS) -o $@

.PHONY: clean
clean:
	rm -f hc-stream
