EXEC := asm_practice
SRC ?= src
BIN := bin
INCLUDE := include
CC := gcc
CFLAGS := -I ${INCLUDE} -O0 -g -c
AS := gcc
ASFLAGS := -g -c
LD := gcc
LDFLAGS := -O0

EXT := .c .s
EXT_FILTER := ${foreach ext, ${EXT}, %${ext}}
SRC_FILES := ${filter ${EXT_FILTER}, ${wildcard ${SRC}/*}}
O_FILES := ${patsubst ${SRC}/%, ${BIN}/%.o, ${SRC_FILES}}

.PHONY=build
build: ${EXEC}

.PHONY=clean
clean:
	rm -rf ${BIN}
	rm -rf ${EXEC}

${EXEC}: ${O_FILES} 
	${LD} ${LDFLAGS} -o ${EXEC} ${O_FILES}

${filter %.c.o, ${O_FILES}}: ${BIN}/%.c.o: ${SRC}/%.c
	mkdir -p ${dir $@}
	${CC} ${CFLAGS} -o $@ $<

${filter %.s.o, ${O_FILES}}: ${BIN}/%.s.o: ${SRC}/%.s
	mkdir -p ${dir $@}
	${AS} ${ASFLAGS} -o $@ $<