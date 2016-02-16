

LEX 		= flex
YACC 		= bison -y


all: 		adc

.c.o:
		$(CC) -c $<

adc: 		lexer.o parser.o 
		$(CC) $(CFLAGS) $^ -o $@

parser.c parser.h: 	parser.y
			$(YACC) -dtv parser.y
			mv -f y.tab.c parser.c
			mv -f y.tab.h parser.h

lexer.c: 	lexer.l
		$(LEX) -t lexer.l > lexer.c

lexer.o: 	parser.h
