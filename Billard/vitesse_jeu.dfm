object Form5: TForm5
  Left = 834
  Top = 371
  BorderStyle = bsSingle
  Caption = 'Vitesse Jeu'
  ClientHeight = 78
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 289
    Height = 25
    AutoSize = False
    ReadOnly = True
    TabOrder = 0
    Text = '    Choisissez la vitesse du jeu (1=lent; 5=rapide)'
  end
  object Button1: TButton
    Left = 8
    Top = 40
    Width = 33
    Height = 33
    Caption = '1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 71
    Top = 40
    Width = 34
    Height = 33
    Caption = '2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 136
    Top = 40
    Width = 33
    Height = 33
    Caption = '3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 200
    Top = 40
    Width = 33
    Height = 33
    Caption = '4'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 264
    Top = 40
    Width = 33
    Height = 33
    Caption = '5'
    TabOrder = 5
    OnClick = Button5Click
  end
end
