program Billard;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  zone_de_jeu in 'zone_de_jeu.pas',
  Boules in 'Boules.pas',
  variables in 'variables.pas',
  canne in 'CANNE.PAS',
  Noms in 'Noms.pas' {Form2},
  splash in 'splash.pas' {Form4};

{$R *.res}
var form4:tform4;

begin
 Application.Initialize;
 Form4 := Tform4.create(application);
 Form4.Show; // affichage de la fiche
 Form4.Update; // force la fiche à se dessiner complètement
 try
  Form4.Close;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
 finally
  Form4.Release;// libération de la mémoire
 end;
 Application.CreateForm(TForm4, Form4);
 Application.Run;
end.
