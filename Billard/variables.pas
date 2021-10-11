unit variables;

{définition et déclaration des variables globales au programmes}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, idglobal;



const xa:integer=45;
      xb:integer=53;
      xc:integer=255;
      xcp:integer=267;
      xdp:integer=277;
      ycp:integer=32;
      yjp:integer=268;
      xd:integer=289;
      xe:integer=498;
      xf:integer=505;
      yb:integer=46;
      ya:integer=53;
      yl:integer=250;
      yk:integer=255;
      x1:integer=36;
      x2:integer=515;
      y1:integer=23;
      y2:integer=277;
      xt1:integer=30;
      xt2:integer=272;
      xt3:integer=514;
      yt1:integer=30;
      yt2:integer=20;
      yt4:integer=270;
      yt5:integer=280;
      rtrou2:integer=500;
      rboule:integer= 9;   {rayon des boules}
      boulcouleur:array[1..16] of tcolor=(clRed, clGreen, clYellow, clBlue, clWhite, clGray, clFuchsia, clTeal, clNavy, clMaroon, clLime, clOlive, clPurple, clSilver, clAqua, clBlack);
      xinitial:array[1..16] of integer=({154,404,382,404,404,426,426,448,448,360,382,426,426,448,448,448);}
                                         {154,406,385,406,406,427,427,448,448,364,385,427,427,448,448,448);}
                                         154,412,394,412,430,430,448,448,448,376,394,412,430,430,448,448);
      yinitial:array[1..16] of integer=({150,150,139,128,172,139,183,128,172,150,161,117,161,106,150,194);}
                                         150,150,160,130,180,140,150,170,110,150,140,170,160,120,130,190);
      xanim:array[1..16] of integer=(154,412,154,197,240,283,326,369,412,154,197,240,283,326,369,412);
      yanim:array[1..16] of integer=(150,150,90,90,90,90,90,90,90,210,210,210,210,210,210,210);
      {distance entre 2 centres d'une même ligne ou d'une même rangée fixée à 22 pixels}
      bande_gauche:integer= 35;  {abscisse de la bande gauche}
      bande_droite:integer= 515; {abscisse de la bande droite}
      decalagex:integer=76;     {table n'est pas en 0,0}
      decalagey:integer=41;      {utilisé dans affichade bmptravail}
                                  {et pour calculcanne}
      kforce:single=0.5;  {coefficient correcteur pour les vitesses}
                          {utilisé pour tricher sur la puissance du pc}
      kralentissement:single=0.992;


type tboule = record
        couleur:tcolor; {'rouge','jaune','blanche','noire'}
        x,y,xold,yold,vx,vy,xpre,ypre:single; {position et vitesse}
        etat,etatpre:integer;    {0:sortie , 1:en jeu, 3:en cours de sortie}
        end;
     tjoueur = record
        couleur:tcolor;   {rouge,jaune ou noir au début}
        bonus:boolean;    {true si le joueur a droit à un coup en plus}
        first:tcolor;    {numéro de la première boule touchée à chaque tour; initialisé à 0}
        nom:string;
        rentrees:boolean; {toutes les boules rentrées}
        end;
        
var
  bleu:boolean;
  boutonvalide:boolean;
  mainpre:integer;
  runion:trect;
  table:tbitmap; {table de yahoo  552*302 pixels}
  bmptravail:tbitmap; {bmp ou les modifs sont effectuées
                       vérifier l'utilité....}
  boule:array[1..16] of tboule;   {cf déclaration dans boules.pas}
  {variables pour la canne}
  phasecanne:boolean;   {true<->la canne est affichée}
  ro : array[1..6] OF single;  { longueurs éléments de la canne }
  nom1,nom2:string; {noms des 2 joueurs}

  sin1, cos1 : Single;          { relatifs à l'angle de la canne }
  Force : Single;               { force du coup de canne }

  {variables propres aux règles}
  main:integer;                {joueur qui a la main}
  nvtour:boolean;              {true qd on commence un nveau tour}
                               {initialisé qd on frappe avec la canne}
  faute:integer;                {nature de la faute donnée par l'entier}
  jr:array[1..2]of tjoueur;
  casse:boolean;                 {false tt que le cassage n'est pas réalisé}
  rejoue:boolean;
  vites:integer;
  
implementation

end.
