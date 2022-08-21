object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  Caption = 'Hist'#243'rico de Download'
  ClientHeight = 358
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 667
    Height = 358
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 667
      Height = 65
      Align = alTop
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 274
        Top = 24
        Width = 109
        Height = 17
        Caption = 'LOG DOWNLOAD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object DBGrid: TDBGrid
      Left = 0
      Top = 65
      Width = 667
      Height = 293
      Align = alClient
      DataSource = DataSource
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'URL'
          Title.Caption = 'Url'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAINICIO'
          Title.Caption = 'Data in'#237'cio'
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAFIM'
          Title.Caption = 'Data fim'
          Width = 125
          Visible = True
        end>
    end
  end
  object DataSource: TDataSource
    Left = 224
    Top = 160
  end
end
