object Form2: TForm2
  Left = 891
  Top = 357
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Players'
  ClientHeight = 169
  ClientWidth = 209
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 89
    Height = 16
    Caption = 'Player 1 name:'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 89
    Height = 16
    Caption = 'Player 2 name:'
  end
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 193
    Height = 24
    TabOrder = 0
    Text = 'Player 1'
  end
  object Edit2: TEdit
    Left = 8
    Top = 96
    Width = 193
    Height = 24
    TabOrder = 1
    Text = 'Player 2'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 136
    Width = 89
    Height = 27
    TabOrder = 2
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 104
    Top = 136
    Width = 97
    Height = 25
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkOK
  end
end
