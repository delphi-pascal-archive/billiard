unit Boules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls,variables ;

procedure nouvelle_position(n:integer);    {calcule tout }
procedure collision(n1,n2 :integer); {calcul des vitesses après chocs}
procedure bande(n:integer);
procedure trou(n:integer);
procedure ralentir(n:integer);
procedure replacer_blanche(x,y:integer);
function test_collision2(n1,n2:integer):boolean;
function test_collision(n1,n2:integer):boolean;
function distance(n1,n2:integer):single;
function inv(m:integer):integer;   {utilisé pour savoir qui n'a pas la main}

implementation

procedure nouvelle_position(n:integer);
 var i,j:integer;
begin
 boule[n].xold := boule[n].x;
 boule[n].yold := boule[n].y;


for i:=1 to 16 do
 if boule[i].etat<>0 then
 begin
  bande(i);trou(i);
  for j:=i+1 to 16 do
   begin
    if boule[j].etat<>0 then
     begin
      if test_collision(i,j) then
      begin
       collision(i,j);
       {si collision on assigne la couleur de la premiére boule touchée}
       if casse then
       begin
        if (i=1) and (jr[main].first=clblue) then jr[main].first:=boule[j].couleur;
        if (j=1) and (jr[main].first=clblue) then jr[main].first:=boule[i].couleur;
       end
       else casse:=true;
      end;
     end;
    end;

 boule[n].x:=boule[n].xold+boule[n].vx;
 boule[n].y:=boule[n].yold+boule[n].vy;
end;
ralentir(n);

end;

function test_collision(n1,n2:integer):boolean;   {renvoie vrai s'il y collision entre les deux boules, sinon renvoie non}
var  dx,dy,dx2,dy2:single;
begin
dx:=(boule[n1].x+boule[n1].vx-boule[n2].x-boule[n2].vx); {ecart sur x entre les 2 boules}
dy:=(boule[n1].y+boule[n1].vy-boule[n2].y-boule[n2].vy);{ecart sur y}
dx2:=(boule[n1].x-boule[n2].x);
dy2:=(boule[n1].y-boule[n2].y);
if ((dx*dx+dy*dy)<={390}324) and ((dx2*dx2+dy2*dy2)>=320) {formule de pythagore}
    then result:=true
    else result:=false;
end;

function test_collision2(n1,n2:integer):boolean;   {renvoie vrai s'il y collision entre les deux boules, sinon renvoie non}
var  dx,dy:single;
begin
dx:=(boule[n1].x-boule[n2].x); {ecart sur x entre les 2 boules}
dy:=(boule[n1].y-boule[n2].y); {acart sur y}
if (dx*dx+dy*dy)<={390}320 {formule de pythagore}
    then result:=true
    else result:=false;
end;


procedure collision(n1,n2 :integer);
var dy,dx,v1x,v1y,v2x,v2y,a,stock:single;

begin
if test_collision2(n1,n2)  then  begin stock:=boule[n1].vx;
                                       boule[n1].vx:=boule[n2].vx*3/4+stock*1/4;
                                       boule[n2].vx:=stock*3/4+boule[n2].vx*1/4;
                                       stock:=boule[n1].vy;
                                       boule[n1].vy:=boule[n2].vy*3/4+stock*1/4;
                                       boule[n2].vy:=stock*3/4+boule[n2].vy*1/4
                                 end;

if test_collision(n1,n2)  then
dx:=(boule[n1].x+boule[n1].vx-boule[n2].x-boule[n2].vx);  {idem}
dy:=(boule[n1].y+boule[n1].vy-boule[n2].y-boule[n2].vy);  {idem}
a:=arctan(dy/(dx+0.00000001));  {angle formé par l'axe passant par les centres des boules et l'axe x}
v1x:=boule[n1].vx;              {0.000000001 pour enlever la division par 0}
v2x:=boule[n2].vx;
v1y:=boule[n1].vy;
v2y:=boule[n2].vy;
{nouvelles vitesses données par les relations simplificatrices des chocs entre boules}
boule[n1].vx:=(v2x*cos(a)+v2y*sin(a))*cos(a)+(v1x*sin(a)-v1y*cos(a))*sin(a) ;
boule[n1].vy:=(v2x*cos(a)+v2y*sin(a))*sin(a)+(-v1x*sin(a)+v1y*cos(a))*cos(a) ;
boule[n2].vx:=(v1x*cos(a)+v1y*sin(a))*cos(a)+(v2x*sin(a)-v2y*cos(a))*sin(a) ;
boule[n2].vy:=(v1x*cos(a)+v1y*sin(a))*sin(a)+(-v2x*sin(a)+v2y*cos(a))*cos(a) ;
end;

procedure bande(n:integer);
var a,xx,yy:single;
begin
xx:=boule[n].x+boule[n].vx;
yy:=boule[n].y+boule[n].vy;
{bandes horizontales}
if (( (xx>=xb) and (xx<=xc) ) or ( (xx>=xd) and (xx<=xe) )) and ( (yy<=yb) or (yy>=yk) )
        then boule[n].vy:=-boule[n].vy;

{bandes verticales}
if ( (yy>=ya) and (yy<=yl) and ( (xx<=xa) or (xx>=xf) ) )
        or ( (((xx>=xc) and (xx<=xcp)) or ((xx>=xdp) and (xx<=xd))) and ((yy<=ycp) or (yy>=yjp)) )
        then boule[n].vx:=-boule[n].vx;

{droites à 45 degré montantes}
if ( (xx+yy<=xc+yb) and (xx>=xc) and (yy>=ycp) )
        or ( (xx+yy>=xd+yk) and (xx<=xd) and (yy<=yjp) )
        or ( (xx+yy<=xa+yl) and (yy>=yl) )
        or ( (xx+yy>=xb+yk) and (xx<=xb) )
        or ( (xx+yy<=xe+yb) and (xx>=xe) )
        or ( (xx+yy>=xf+ya) and (yy<=ya) )
        then begin a:=boule[n].vx;
                   boule[n].vx:=-boule[n].vy;
                   boule[n].vy:=-a;
                   exit
             end;

{droites à 45 degrés descendantes}
if ( (xx-xd>=yy-yb) and (xx<=xd) and (yy>=ycp) )
        or ( (xx-xc<=yy-yk) and (xx>=xc) and (yy<=yjp) )
        or ( (xx-xa<=yy-ya) and (yy<=ya) )
        or ( (xx-xb>=yy-yb) and (xx<=xb) )
        or ( (xx-xe<=yy-yk) and (xx>=xe) )
        or ( (xx-xf>=yy-yl) and (yy>=yl) )
        then begin a:=boule[n].vx;
                   boule[n].vx:=boule[n].vy;
                   boule[n].vy:=a;
                   exit
             end;
end;

procedure trou(n:integer);
var pasmain:integer;  {numéro du joueur qui n'a pas la main}
begin
{disparition des boules}
if ((boule[n].y<=y1)or(boule[n].y>=y2)or(boule[n].x<=x1)or(boule[n].x>=x2))
        then begin
                boule[n].etat:=2;
                boule[n].vx:=0;
                boule[n].vy:=0;
                {règles}
                if (n=1) and (faute<>-3) and (faute<>4) then faute:=1;

                if (n>=3) and (faute<>-3) and (faute<>4) then
                begin
                 if (jr[main].couleur=clblue) then   {assigne des couleurs aux joueurs}
                 begin
                 {jr[main].rentrees:=1;}
                  faute:=-2;
                  jr[main].couleur:=boule[n].couleur;
                  pasmain:=inv(main);
                  if jr[main].couleur=clred then
                  jr[pasmain].couleur:=clyellow
                  else
                  jr[pasmain].couleur:=clred
                 end
                 else
                 if boule[n].couleur=jr[main].couleur then
                 begin
                  faute:=-1-3*random(5);    {éventuellemant écrasé si boules adverses rentrées ensuite}
                  {jr[main].rentrees:=jr[main].rentrees+1;}
                 end
                 else
                 begin
                  if jr[main].rentrees=false then faute:=3;
                  pasmain:=inv(main);
                  {jr[pasmain].rentrees:=jr[pasmain].rentrees+1;}
                 end;
               end;
                 if n=2 then          {boule noire!}
                 begin
                 if jr[main].rentrees=true then faute:=-3
                 else
                 faute:=4;
                 end;


        end;
{effet donné par les bordures des trous, permet aussi à une boule de ne pas s'arreter dans le vide}
{trou 1}
if (((boule[n].x-xt1)*(boule[n].x-xt1)+(boule[n].y-yt1)*(boule[n].y-yt1))<=rtrou2)
        then begin
                boule[n].vy:=boule[n].vy-0.0007;
                boule[n].vx:=boule[n].vx-0.0007
             end;
{trou 2}
if (((boule[n].x-xt2)*(boule[n].x-xt2)+(boule[n].y-yt2)*(boule[n].y-yt2))<=rtrou2)
        then boule[n].vy:=boule[n].vy-0.0007;
{trou 3}
if (((boule[n].x-xt3)*(boule[n].x-xt3)+(boule[n].y-yt1)*(boule[n].y-yt1))<=rtrou2)
        then begin
                boule[n].vy:=boule[n].vy-0.0007;
                boule[n].vx:=boule[n].vx+0.0007
             end;
{trou 4}
if (((boule[n].x-xt1)*(boule[n].x-xt1)+(boule[n].y-yt4)*(boule[n].y-yt4))<=rtrou2)
        then begin
                boule[n].vy:=boule[n].vy+0.0007;
                boule[n].vx:=boule[n].vx-0.0007
             end;
{trou 5}
if (((boule[n].x-xt2)*(boule[n].x-xt2)+(boule[n].y-yt5)*(boule[n].y-yt5))<=rtrou2)
        then boule[n].vy:=boule[n].vy+0.0007;
{trou 6}
if (((boule[n].x-xt3)*(boule[n].x-xt3)+(boule[n].y-yt4)*(boule[n].y-yt4))<=rtrou2)
        then begin
                boule[n].vy:=boule[n].vy+0.0007;
                boule[n].vx:=boule[n].vx+0.0007
             end;
end;

procedure ralentir(n:integer);
begin
 boule[n].vx:=boule[n].vx*kralentissement;
 boule[n].vy:=boule[n].vy*kralentissement;
 if abs(boule[n].vx)<0.01 then
 boule[n].vx:=0;
 if abs(boule[n].vy)<0.01 then
 boule[n].vy:=0;
 {autre essai infructueux : cette fois ci on soustrait
 au lieu de multiplier par un nombre :
 a:=arctan(boule[n].vy/boule[n].vx);
 boule[n].vx:=boule[n].vx-kralentissement*cos(a);
 boule[n].vy:=boule[n].vy-kralentissement*sin(a);}
end;

procedure replacer_blanche(x,y:integer);
var contact:boolean;
    i:integer;
    d,dmin:single;    {distances}
begin
contact:=false;
dmin:=1000;           {distance minimale}
for i:=2 to 16 do
begin
d:=sqrt((x-boule[i].x)*(x-boule[i].x)+(y-boule[i].y)*(y-boule[i].y));
if dmin>d then dmin:=d;
end;
if dmin<=2*rboule then contact:= true;    {évite le chevauchement avec une autre boule}
{petite tricherie pour pas que la boule ne tombe pas ds le trou}
if (x>45+rboule) and (x<=154) and (y>45+rboule) and (y<250-rboule) and not contact then
begin
 boule[1].etat:=1;
 boule[1].x:=x;
 boule[1].y:=y;
end;
end;

function distance(n1,n2:integer):single;
begin
result:=sqrt((boule[n1].x-boule[n2].x)*(boule[n1].x-boule[n2].x)+(boule[n1].y-boule[n2].y)*(boule[n1].y-boule[n2].y))
end;

function inv(m:integer):integer;   {utilisé pour savoir qui n'a pas la main}
begin
if m=1 then result:=2
else result:=1;
end;

end.
