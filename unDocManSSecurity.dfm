object _Security: T_Security
  Left = 694
  Top = 284
  Width = 441
  Height = 318
  Caption = 'Daftar Hak Akses'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgCU: TDBGrid
    Left = 0
    Top = 37
    Width = 425
    Height = 201
    Align = alClient
    DataSource = dm.dsCU
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ModulSubName'
        Title.Caption = 'Nama Modul'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Resource'
        Title.Caption = 'Sumber'
        Width = 180
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 37
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 12
      Width = 184
      Height = 16
      Caption = 'Modul yang diakses untuk '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCU: TLabel
      Left = 193
      Top = 12
      Width = 35
      Height = 16
      Caption = 'lbCU'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 238
    Width = 425
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
    object btUserConfig: TSpeedButton
      Left = 6
      Top = 6
      Width = 128
      Height = 31
      Caption = '&Editor Akses Menu'
      Flat = True
      OnClick = btUserConfigClick
    end
    object btExit: TSpeedButton
      Left = 331
      Top = 6
      Width = 85
      Height = 31
      Caption = '&Selesai'
      Flat = True
      OnClick = btExitClick
    end
  end
end
