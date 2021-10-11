unit Noms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, variables;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
form2.modalresult:=mrok;
nom1:=edit1.Text;
nom2:=edit2.Text;         {pas besoin de close car affectation modale->fermeture automatique}
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
self.ShowModal;
end;

end.
