unit vitesse_jeu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, variables;

type
  TForm5 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin
 vites:=1; close;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
 vites:=2; close;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
 vites:=3;  close;
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
 vites:=4; close;
end;

procedure TForm5.Button5Click(Sender: TObject);
begin
 vites:=5;  close;
end;

end.
