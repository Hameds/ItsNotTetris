                        {********* TETRIS GAME *********}
program gun;
{Programmer: Hamed Saeedy Fard          Final Project}

uses crt;
type arraytype= array[1..30] of integer;

{****************************************************************}

{Calculate and write score.}
procedure score(var sum:integer);
begin { procedure }
 gotoxy(20,22);
 write(' score > ' ,sum);
end;  { procedure }

{****************************************************************}

{Draw gun in new position.}
procedure drawgun(var x,y:integer);
begin { procedure }
 gotoxy(x,y);
 write(chr(006));
end;   { procedure }

{****************************************************************}
{Determines if a key has been passed on the keyboard.}
function keypress:char;
var c:integer;sw:boolean;
begin { procedure }
 c:=1;
 sw:=true;
 while (c<=5) and (sw=true) do
  begin { while }
   if keypressed then
    begin { if }
     keypress:=readkey;
     sw:=false;
    end;  { if }
   c:=c+1;
  end;  { while }
end;   { procedure }

{******************************************************************}

{Start game again.}
procedure startgame(var x,y:integer;var p:arraytype);
var c:integer;
begin { procedure }

 window(5,2,24,23);
 textbackground(6);
 clrscr;
 writeln('****Tetris Game****');
 writeln('Written by :');
 writeln(' Hamed Saeedy Fard');
 writeln;
 writeln('Game key: ');
 writeln('Enter for new game');
 writeln('Esc for exit game');
 writeln(chr(024),' for gun shot');
 writeln(chr(027),' for move gun left');
 writeln(chr(026),' for move gun right');
 writeln('Score Reulles');
 writeln('STAGE 1 : 350');
 writeln('STAGE 2 : 750');
 writeln('STAGE 3 : 1000');
 randomize;
 window(25,2,25,33);
 textbackground(random(5));
 clrscr;
 x:=15;
 y:=21;
 drawgun(x,y);
 for c:=1 to 30 do
  p[c]:=1;
 end;  { procedure }

{****************************************************************}

{Add 50 to score for each stage.}
procedure stage(var sum:integer);
var c:integer;
begin  { procedure }
 for c:=1 to 50 do
  begin  { for }
   delay(50);
   sum:=sum+1;
   score(sum);
  end;   { for }
end;   { procedure }

{****************************************************************}

{Write Status of game(such as stage,game over,etc).}
procedure message(text:string);
begin  { procedure }
 gotoxy(1,22);
 write(text);
end;   { procedure }

{****************************************************************}

procedure tir(dnum,x:integer;p:arraytype);
var c:integer;
begin
 for c:=21 downto p[x] do
  begin
  delay(dnum);
  if c=1 then
   gotoxy(x,1)
  else
   gotoxy(x,c-1);
  write(chr(15));
  delay(dnum+2);
  if c=1 then
   gotoxy(x,1)
  else
   gotoxy(x,c-1);
   write(' ');
  end;
end;

{****************************************************************}

var key:char;
    counter,sum,dnum:integer;
    x,y,h:integer;
    p:arraytype;

{****************************************************************}

begin
 clrscr;
 dnum:=150;
 startgame(x,y,p);
 sum:=0;
 score(sum);
 message('STAGE 1');
 key:=keypress;

 while true do
  begin
   key:=keypress;

   if sum=350 then
    begin
     dnum:=70;
     startgame(x,y,p);
     message('STAGE 2');
     stage(sum);
    end;

   if sum=750 then
    begin
     dnum:=30;
     startgame(x,y,p);
     message('STAGE 3');
     stage(sum);
    end;

   if sum=1000 then
    begin
     clrscr;
     message('YOU WIN');
     delay(5000);
     message('START NEW GAME');
     dnum:=150;
     startgame(x,y,p);
     sum:=0;
     score(sum);
     message('STAGE 1');
    end;
   case key of
        'M': begin
              gotoxy(x,y);
              write(' ');
              x:=x+1;
              if x>30 then
                x:=30;
              drawgun(x,y);
             end;
        'K': begin
              gotoxy(x,y);
              write(' ');
              x:=x-1;
              if x<=1 then
               x:=1;
              drawgun(x,y);
             end;
        'H': begin
              tir(8,x,p);
              if p[x]>=2 then
               begin
                p[x]:=p[x]-1;
                sum:=sum+10;
                score(sum);
               end;
              end;  { case command for H }
        #13 : begin
               dnum:=150;
               startgame(x,y,p);
               sum:=0;
               score(sum);
               message('STAGE 1');
              end;
        #27 : begin
               message('EXTE GAME [Y/N]?');
               key:=readkey;
               while(key<>'y') and (key<>'n') do
                key:=readkey;
               if key='y' then
                exit;
               case dnum of
                     150 : message('STAGE 1     ');
                      70 : message('STAGE 2     ');
                      30 : message('STAGE 3     ');
               end;
               if key='n' then
                key:=keypress
               end;
        end; {case key}

        for counter:=1 to 30 do
         if p[counter]=21 then
          begin
           clrscr;
           message('GAME OVER');
           score(sum);
           delay(1000);
           message('ENTER =>NEW GAME');
           key:=readkey;
           while key<>#13 do
            key:=readkey;
           dnum:=150;
           startgame(x,y,p);
           message('STAGE 1');
           sum:=0;
          end;

         delay(dnum);
         h:=random(30)+1;
         gotoxy(h,p[h]);
         p[h]:=p[h]+1;
         write(chr(4));

        end; { while key}
       end.






