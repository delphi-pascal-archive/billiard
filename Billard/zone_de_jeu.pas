unit zone_de_jeu;
{cette unité gère l'affichage de la zone de jeu
coordonnées à retenir:}
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, boules ,variables;

procedure afficher_boule(n:integer);
procedure effacer_boule(n:integer);
procedure efface_tout;

implementation


procedure afficher_boule(n:integer);
var xx,yy:integer;  {il faut bien des entiers pour la fonction ellipse}
    r:trect;
begin
if boule[n].etat=0 then
exit
else
begin
with bmptravail.canvas do
begin
 pen.color := boule[n].couleur;
 brush.color:= boule[n].couleur;
 xx:=trunc(boule[n].x);
 yy:=trunc(boule[n].y);
 ellipse(xx-rboule,yy-rboule,xx+rboule,yy+rboule);
 r:=rect(xx-rboule,yy-rboule,xx+rboule,yy+rboule);
 unionrect(runion,runion,r);
end;
end;
end;

procedure effacer_boule(n:integer);
var r:trect;
    xx,yy:integer;
begin
 if boule[n].etat<>0 then
 with bmptravail.Canvas do
 begin
 xx:=trunc(boule[n].xold);
 yy:=trunc(boule[n].yold);
 r:=rect(xx - rboule,yy - rboule,xx + rboule,yy + rboule);
 copyrect(r,table.Canvas,r);
 end;
 if boule[n].etat=2 then  boule[n].etat:=0  {on efface une dernière fois la boule rentrée}
end;

procedure efface_tout;
var i,xx,yy:integer;
    r:trect;
begin
runion:=rect(0,0,0,0);
for i:=1 to 16 do
 begin
 if boule[i].etat<>0 then
 begin
  xx:=trunc(boule[i].xold);
  yy:=trunc(boule[i].yold);
  r:=rect(xx - rboule,yy - rboule,xx + rboule,yy + rboule);
  bmptravail.Canvas.CopyRect(r,table.Canvas,r);
  unionrect(runion,runion,r);
  if boule[i].etat=2 then boule[i].etat:=0;  {on efface une dernière fois la boule rentrée}
 end;
 end
end;

end.
