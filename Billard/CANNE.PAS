unit canne;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, idglobal, variables;

procedure calculcanne(wx, wy : integer);
PROCEDURE effacecanne(paintbox:tpaintbox);
PROCEDURE afficher_canne(cax, cay : single; paintbox:tpaintbox);


implementation

var
  acanne   : Single;            { angle de la canne en radians }
  Rcanne   : Trect;             { rectangle image de la canne }
  Bmpcanne : Tbitmap;           { sauvegarde zone sous la canne }
  { gestion du viseur }
  Rviseur   : array[1..3] of Trect;    { rectangle image du viseur }
  Bmpviseur : array[1..3] of Tbitmap;  { sauvegarde zone sous le viseur }
  Visz      : array[1..3] of integer;  { taille du viseur 4, db selon option }
  flagcanne:boolean; {si image de la canne est créée}

procedure calculcanne(wx, wy : integer);
var
  dx, dy : integer;    { centre de la rotation position boule blanche }
  sdx, sdy : single;   { centre de la rotation pour les calculs }
begin
  sdx :=   boule[1].x- wx +decalagex;
  sdy :=   -boule[1].y + wy -decalagey;   {attention au moins}
  dx := round(sdx);
  dy := round(sdy);
  IF dx = 0 then     { protection division par zéro du calcul arc tangente }
  begin              { canne : angle en radians }
    if dy > 0 then acanne := pi/2 else acanne := -pi/2;
  end
  else
  begin
    IF dx > 0  then
    begin
     acanne := arctan(sdy/sdx);
     IF acanne < 0 then acanne := pi+pi+acanne;
    end
    else acanne := pi+arctan(sdy/sdx);
  end;
  { distance souris/centre et calcul de la force }
  sin1 :=  sin(acanne);
  cos1 := -cos(acanne);
  sdx := abs(sdx);
  sdy := abs(sdy);
  IF sdx < 0.0001 then sdx := 0.0001;  { évite overflow 0x0 réels }
  IF sdy < 0.0001 then sdy := 0.0001;
  force := (sqrt(sdx*sdx+sdy*sdy) - rboule) / 6;
  IF force > 28 then force := 28;
  IF force < 1 then force := 1;
end;

{ efface canne et viseurs }
PROCEDURE effacecanne(paintbox:tpaintbox);
Var
  i : integer;
  r : trect;
begin
  IF Flagcanne then
  begin
    { efface canne }
   with paintbox.canvas do
   begin
    r := rect(0,0, bmpcanne.width, bmpcanne.height);
    copyrect(rcanne, bmpcanne.canvas, r);
    bmpcanne.free;
    rcanne := rect(0,0,0,0);
    { efface viseurs }
    for i := 1 to 3 do
    begin
      r := rect(0,0, bmpviseur[i].width, bmpviseur[i].height);
      copyrect(rviseur[i], bmpviseur[i].canvas, r);
      bmpviseur[i].free;
      rviseur[i] := rect(0,0,0,0);
    end;
    flagcanne := false;
   end;
  end;
end;


{ affiche la canne }
PROCEDURE afficher_canne(cax, cay : single;paintbox:tpaintbox);  { caa angle en radians }
VAR
  i : integer;
  px : array[1..6] OF integer;  { points de la canne }
  py : array[1..6] OF integer;
  vix : array[1..3] of integer;
  viy : array[1..3] of integer;     { points du viseur }
  r : Trect;
  wvf : single;
BEGIN
{IF Iviseur = 0 then visz[1] := db else }visz[1] := 2;   {iviseur pour l'option}
  Visz[2] := 4;
  Visz[3] := 2;
  if not rejoue then      {évite des bugs d'affichage du au paintbox}
  effacecanne(paintbox);  { et viseurs }
  rejoue:=false;
  For i := 1 TO 6 DO
  begin
    px[i] := round(cax+ round(ro[i]*cos1));
    py[i] := round(cay+ round(ro[i]*sin1));
  end;
  For i := 1 TO 3 do
  begin
    wvf := i;
    vix[i] := trunc(cax - round(force*5*wvf*cos1) - visz[i] div 2);
    viy[i] := trunc(cay - round(force*5*wvf*sin1) - visz[i] div 2);
  end;
  { sauvegarde des zones sous canne et sous viseur }
  rcanne.left   := min(px[1], px[6])-4;
  rcanne.top    := min(py[1], py[6])-4;
  rcanne.right  := max(px[1], px[6])+4;
  rcanne.bottom := max(py[1], py[6])+4;
  Bmpcanne := Tbitmap.create;
  Bmpcanne.width  := rcanne.right - rcanne.left;
  Bmpcanne.height := rcanne.bottom - rcanne.top;
  r := rect(0,0,bmpcanne.width, bmpcanne.height);
  Bmpcanne.canvas.copyrect(r, paintbox.canvas, rcanne);
  For i := 1 to 3 do
  begin
    rviseur[i].left   := vix[i];
    rviseur[i].top    := viy[i];
    rviseur[i].right  := vix[i]+visz[i];
    rviseur[i].bottom := viy[i]+visz[i];
    Bmpviseur[i] := Tbitmap.create;
    Bmpviseur[i].width  := visz[i];
    Bmpviseur[i].height := visz[i];
    r := rect(0,0,visz[i],visz[i]);
    Bmpviseur[i].canvas.copyrect(r, paintbox.canvas, rviseur[i]);
  end;
  With Paintbox.Canvas do
  Begin
    Pen.mode := pmCopy;
    Pen.width := 3;
    Pen.color := clblack;
    Moveto(px[4], py[4]); Lineto(px[6], py[6]);
    Pen.color := clmaroon;
    Moveto(px[4], py[4]); lineto(px[5], py[5]);
    Pen.color := clolive;
    Moveto(px[2], py[2]); Lineto(px[4], py[4]);
    Pen.width := 1;
    Moveto(px[5], py[5]); Lineto(px[4], py[4]);
    Pen.color := clwhite;
    Moveto(px[1], py[1]); Lineto(px[3], py[3]);
    Pen.color := clyellow;
    Moveto(px[2], py[2]); Lineto(px[4], py[4]);
    Pixels[px[1], py[1]]:= clblack;
    Pixels[px[2], py[2]] := clsilver;
    { viseurs}
    pen.color := clwhite;
    for i := 1 TO 3 do
      Ellipse(vix[i], viy[i], vix[i]+visz[i], viy[i]+visz[i]);
  end;
  flagcanne := true;
end;

end.
