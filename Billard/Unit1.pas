unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls,idglobal, zone_de_jeu, canne,
  noms, variables,boules, Buttons ;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    PaintBox1: TPaintBox;
    Nouvellepartie1: TMenuItem;
    Panel1: TPanel;       {nom1}
    Panel2: TPanel;       {nom2}
    Panel3: TPanel;
    Timer1: TTimer;       {animation des boules}
    Timer2: TTimer;
    Timer3: TTimer;
    rejouercoup1: TMenuItem;
    VitesseJeu2: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N51: TMenuItem;
    N41: TMenuItem;
    N31: TMenuItem;
    SpeedButton1: TSpeedButton;

    procedure Quitter1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure initialisation;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Nouvellepartie1Click(Sender: TObject);
    procedure noms_joueurs;
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure messages;
    procedure Timer3Timer(Sender: TObject);
    procedure rejouercoup1Click(Sender: TObject);
    procedure VitesseJeu1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
     { Déclarations privées }
  public
    { Déclarations publiques }
    function etat_jeu:boolean;
  end;

procedure chgt_joueur;
procedure animfin;

var
  Form1: TForm1;

implementation

var msgfin:string;

{$R *.dfm}


procedure TForm1.Quitter1Click(Sender: TObject);
begin
   close;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
sleep(500);
phasecanne:=false;
initialisation;
timer2.enabled:=true;
end;

procedure tform1.initialisation;
var i:integer;
begin
 bmptravail:=tbitmap.create;
 table:=tbitmap.Create;
 table.LoadFromFile('billard2.bmp');
 bmptravail.width:=paintbox1.Width;
 bmptravail.height:=paintbox1.height;
 bmptravail.assign(table);     {copie l'un dans l'autre}
 for i:=1 to 16 do
 begin
  boule[i].x:=  xinitial[i];  {boules prêtes au départ}
  boule[i].y:=  yinitial[i];
  boule[i].vx:=0;
  boule[i].vy:=0;
  boule[i].etat:=1;           {1 <-> boule sur la table}
  if i=1 then
  boule[i].couleur:=clwhite;
  if i=2 then
  boule[i].couleur:=clblack;
  if (i>2) and (i<10) then
  boule[i].couleur:=clred;
  if (i>9) then
  boule[i].couleur:=clyellow;
  afficher_boule(i);
 end;
   { dimensions de la canne }
  ro[1]:= rboule*2;    ro[2]:= rboule*3;
  ro[3]:= rboule*13; ro[4]:= rboule*15;
  ro[5]:= rboule*20; ro[6] := rboule*20+3;
  if not timer2.enabled then  {ie si premier lancement}
{---------------------------------------------}
form1.Repaint;
nvtour:=true;
vites:=3;
jr[1].couleur:=clblue; jr[2].couleur:=clblue;
jr[1].bonus:=false; jr[2].bonus:=false;
jr[1].first:=clblue; jr[2].first:=0;
jr[1].nom:=nom1; jr[2].nom:=nom2;
jr[1].rentrees:=false; jr[2].rentrees:=false;
main:=1; mainpre:=1;      {on donne la main au joueur 1}
casse:=false;
panel3.Caption:='Lancer une nouvelle partie';
timer3.Enabled:=false;
end;

procedure tform1.noms_joueurs;
begin
 nom1:=form2.edit1.text;
 nom2:=form2.edit2.text;
 form1.Panel1.Font.Color:=jr[1].couleur;
 form1.Panel2.Font.Color:=jr[2].couleur;
 if main=1 then
 begin
  panel1.Font.style := [fsBold,fsUnderline];      {on souligne le nom du joueur qui a la main}
  panel2.Font.style := [fsBold];
 end
 else
 begin
  panel2.Font.style := [fsBold,fsUnderline];      {on souligne le nom du joueur qui a la main}
  panel1.Font.style := [fsBold];
 end;
 form1.Panel1.Caption:=nom1;
 form1.Panel2.Caption:=nom2;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
 PaintBox1.Canvas.Draw(decalagex,decalagey,bmptravail);  {faut afficher manuellement car paintbox}
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  table.free;
  bmptravail.free;
end;

function tform1.etat_jeu:boolean;
var i:integer;
begin
result:=true;    {true si boules toutes à l'arrêt}
for i:=1 to 16 do
if (boule[i].vx<>0) or (boule[i].vy<>0) then result:=false;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if phasecanne and (boule[1].etat<>0) then  {si boule blanche sortie mouseclick prend le relais}
begin
 calculcanne(x, y );
 afficher_canne(boule[1].x +decalagex, boule[1].y +decalagey,paintbox1 );
end;
{panel1.Caption:=inttostr(x-decalagex);
panel2.caption:=inttostr(y-decalagey); }

end;



procedure TForm1.Nouvellepartie1Click(Sender: TObject);
begin
 timer2.enabled:=false;
 phasecanne:=false;
 if form2.ShowModal=mrok then
 begin
 initialisation;
 rejoue:=true;       {évite bug d'affichage}
 end;
 timer2.enabled:=true;      {normalement le prgm attend la fermeture de form2}
 PaintBox1.Canvas.Draw(decalagex,decalagey,bmptravail); {réaffiche tte la table}
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i,j:integer;    {boucle avec j si trop lent}
    r:trect;   {parce qu'il y a un décalage par rapport au paintbox}
begin
for j:=1 to vites do
begin
for i:=1 to 16 do
begin
 nouvelle_position(i);
end;
efface_tout;    {pour que les calculs ne perturbent pas l'affichage}
for i:=1 to 16 do
begin
 afficher_boule(i);
end;
 {PaintBox1.Canvas.Draw(decalagex,decalagey,bmptravail); }
 r:=rect(runion.left+decalagex,runion.top+decalagey,runion.Right+decalagex,runion.Bottom+decalagey);
 paintbox1.Canvas.CopyRect(r,bmptravail.Canvas,runion);
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
begin
for i:=1 to 16 do
begin
 boule[i].vx:=1-random(3);
 boule[i].vy:=1-random(3);
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
initialisation;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
 jr[1].nom:=nom1;jr[2].nom:=nom2;
 noms_joueurs;
if not etat_jeu then      {au moins une boule en mouvement}
 begin
 timer1.enabled:=true;
 phasecanne:=false;  {sûrement inutile dans la version finale}
 end
 else                    {boules à l'arrêt on commence un nv tour}
 begin
 timer1.Enabled:=false;
 if not form2.visible then phasecanne:=true;      {évite bug d'affichage avec la fenêtre des noms de joueurs}
 if not nvtour then
 begin
if (faute=-3) or (faute=4) then
begin
 if faute=-3 then
  begin
  msgfin:=(jr[main].nom+' gagne');
  end
 else
  begin
  msgfin:=(jr[inv(main)].nom+' gagne');
  end;
 animfin;
end
else if jr[main].rentrees=false then
begin

 if jr[main].first=clblue then faute:=2   {evite de refaire le test à chaque collision}
 else
 if (jr[main].couleur<>clblue) and (faute<>-2) and (jr[main].first<>jr[main].couleur) then
 faute:=5;
 if (jr[main].first=clblack) and (jr[main].rentrees=false) then faute:=6;
 if faute<=-1 then jr[main].bonus:=true;
 if faute>=1 then jr[main].bonus:=false;  {une faute implique la perte du bonus}
end;
  chgt_joueur;
  messages;            {messages après chgt_joueur pour la cohérence des messages}
{----------------------règles--------------------------}
if (not casse) or (faute>=1) then jr[main].bonus:=true;
{------------------------------------------------------}

  jr[main].first:=clblue;
  nvtour:=true;            {nvtour effectif qd on a changé de joueur}
  faute:=0;
 end;
end;

end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

var i,pasmain:integer;
begin
if  (boule[3].etat=0) and (boule[4].etat=0) and (boule[5].etat=0)
       and (boule[6].etat=0) and (boule[7].etat=0) and (boule[8].etat=0) and (boule[9].etat=0) then
       begin if jr[main].couleur=clred then jr[main].rentrees:=true
       end;
if  (boule[10].etat=0) and (boule[11].etat=0) and (boule[12].etat=0)
       and (boule[13].etat=0) and (boule[14].etat=0) and (boule[15].etat=0) and (boule[16].etat=0) then
       begin if jr[main].couleur=clyellow then jr[main].rentrees:=true
       end;
if phasecanne then
if boule[1].etat<>0 then
 begin    {on met la blanche en mouvement}
  phasecanne:=false;  {pour pas que la canne s'efface automatiquement}
  boule[1].vx:= -force*cos1*Kforce;
  boule[1].vy:= -force*sin1*kforce;
  for i:=1 to 16 do
   begin
    boule[i].etatpre:=boule[i].etat;
    boule[i].xpre:=boule[i].x;
    boule[i].ypre:=boule[i].y;
   end;
  effacecanne(paintbox1);


  nvtour:=false;
 end
else          {remise en place de la blanche}
begin
 replacer_blanche(x-decalagex,y-decalagey);
 afficher_boule(1);
 PaintBox1.Canvas.Draw(decalagex,decalagey,bmptravail); {réaffiche tte la table}
end;
 end;

procedure tform1.messages;
var i:integer;
    s:string;
begin
case faute of
-3: s:='!!!!!!! GAGNE !!!!!!!';
-2: s:='!!!!!!!!! Première boule rentrée !!!!!!!!!';
  -1: s:='Joli Coup !';
  -4: s:='Bien Joué';
  -7: s:='Pas Mal !!!';
  -10: s:='Bravo';
  -13: s:='Waouh !';
0: s:='';
1: s:='Faute! Veuillez replacer la boule blanche dans la zone de gauche';
2: s:='Faute! Vous n'+char(658)+'avez touché aucune boule';
3: s:='Faute! Boule adverse empochée * 2 coups pour '+jr[main].nom;
4: s:='PERDU...vous avez rentré la boule noire; '+jr[inv(main)].nom+' gagne la partie';
5: s:='Faute! Boule adverse touchée';
6: s:='Faute! Boule noire touchée en premier';
end;              {il en faut un pour le case}
panel3.Caption:=s;

end;

procedure chgt_joueur;
begin
mainpre:=main;
if not jr[main].bonus then
begin
 if main=1 then main:=2
 else main:=1;
end
else
jr[main].bonus:=false;     {bonus utilisé}
end;

procedure animfin;
var i:integer ;
begin
bmptravail.assign(table);
form1.PaintBox1.Canvas.Draw(decalagex,decalagey,table);
bmptravail.Canvas.Font.Color:=clblue;
bmptravail.Canvas.Font.Size:=24;
bmptravail.Canvas.Font.Name:='Comic sans ms';
for i:=1 to 16 do
 begin
  boule[i].x:=xanim[i];  {boules prêtes au départ}
  boule[i].y:=yanim[i];
  boule[i].vx:=0;
  boule[i].vy:=0;
  boule[i].etat:=1;  {1 <-> boule sur la table}
  boule[i].couleur:=boulcouleur[i];
  afficher_boule(i);
 end;
 phasecanne:=false;
 form1.timer3.Enabled:=true;                {à ce point c'est celui qui a rentré la noire qui a la main}
end;

procedure TForm1.Timer3Timer(Sender: TObject);
var i:integer;
begin
bmptravail.Canvas.brush.color:=$2D6D2B;
for i:=1 to 16 do
begin
 boule[i].vx:=1-random(3);
 boule[i].vy:=1-random(3);
end;
  bmptravail.Canvas.TextOut(180,125,msgfin);
paintbox1.Canvas.Draw(decalagex,decalagey,bmptravail);
end;

procedure TForm1.rejouercoup1Click(Sender: TObject);
var
 i:integer;
begin
if (timer3.enabled=false) and etat_jeu then
begin
  rejoue:=true;
  bleu:=true;
  form1.timer3.Enabled:=false;

  main:=mainpre;
  panel3.caption:='Rejouez votre coup!!!';
for i:=1 to 16 do
 begin
  if boule[i].etatpre=0 then bleu:=false;
  effacer_boule(i);
  if i=1 then
  boule[i].couleur:=clwhite;
  if i=2 then
  boule[i].couleur:=clblack;
  if (i>2) and (i<10) then
  boule[i].couleur:=clred;
  if (i>9) then
  boule[i].couleur:=clyellow;
  boule[i].etat:=boule[i].etatpre;
  boule[i].vx:=0; boule[i].vy:=0;
  boule[i].x:=boule[i].xpre;
  boule[i].y:=boule[i].ypre;
  end;
  for i:=1 to 16 do afficher_boule(i);
  PaintBox1.Canvas.Draw(decalagex,decalagey,bmptravail);
  form1.Repaint;
  if bleu=true then begin jr[main].couleur:=clblue; jr[inv(main)].couleur:=clblue end
 end;
end;

procedure TForm1.VitesseJeu1Click(Sender: TObject);
begin
rejoue:=false;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
vites:=1;
end;

procedure TForm1.N21Click(Sender: TObject);
begin
vites:=2;
end;

procedure TForm1.N31Click(Sender: TObject);
begin
vites:=3;
end;

procedure TForm1.N41Click(Sender: TObject);
begin
vites:=4;
end;

procedure TForm1.N51Click(Sender: TObject);
begin
vites:=5;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var i:integer;
begin
if (timer3.enabled=false) and etat_jeu then
begin
  rejoue:=true;
  bleu:=true;
  form1.timer3.Enabled:=false;

  main:=mainpre;
  panel3.caption:='Rejouez votre coup!!!';
for i:=1 to 16 do
 begin
  if boule[i].etatpre=0 then bleu:=false;
  effacer_boule(i);
  if i=1 then
  boule[i].couleur:=clwhite;
  if i=2 then
  boule[i].couleur:=clblack;
  if (i>2) and (i<10) then
  boule[i].couleur:=clred;
  if (i>9) then
  boule[i].couleur:=clyellow;
  boule[i].etat:=boule[i].etatpre;
  boule[i].vx:=0; boule[i].vy:=0;
  boule[i].x:=boule[i].xpre;
  boule[i].y:=boule[i].ypre;
  end;
  for i:=1 to 16 do afficher_boule(i);
  PaintBox1.Canvas.Draw(decalagex,decalagey,bmptravail);
  form1.Repaint;
  if bleu=true then begin jr[main].couleur:=clblue; jr[inv(main)].couleur:=clblue end
end;
 end;
end.
