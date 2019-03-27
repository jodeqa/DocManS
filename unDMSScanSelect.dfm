object frmDMSScanSelect: TfrmDMSScanSelect
  Left = 554
  Top = 89
  Width = 569
  Height = 571
  BorderStyle = bsSizeToolWin
  Caption = 'Import Data Dari Excel'
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
  object btImportData: TSpeedButton
    Left = 27
    Top = 477
    Width = 196
    Height = 34
    Caption = 'import Data &Dari Excel'
    OnClick = btImportDataClick
  end
  object btSelesai: TSpeedButton
    Left = 429
    Top = 477
    Width = 94
    Height = 34
    Caption = '&Selesai'
    OnClick = btSelesaiClick
  end
  object pgc: TPageControl
    Left = 27
    Top = 12
    Width = 496
    Height = 454
    ActivePage = tbsCOP
    TabIndex = 0
    TabOrder = 0
    object tbsCOP: TTabSheet
      Tag = 1
      Caption = 'Commence Contract List'
      object pnCOP: TPanel
        Left = 0
        Top = 402
        Width = 488
        Height = 24
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object lsbCOP: TListBox
        Left = 0
        Top = 0
        Width = 488
        Height = 402
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
        OnDblClick = lsbCOPDblClick
      end
    end
    object tbsBPK: TTabSheet
      Tag = 2
      Caption = 'BPKB Acceptance List'
      ImageIndex = 1
      object pnBPK: TPanel
        Left = 0
        Top = 402
        Width = 488
        Height = 24
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object lsbBPK: TListBox
        Left = 0
        Top = 0
        Width = 488
        Height = 402
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
        OnDblClick = lsbCOPDblClick
      end
    end
    object tbsOLE: TTabSheet
      Tag = 3
      Caption = 'Data OTO Lease'
      ImageIndex = 2
      object lsbOLE: TListBox
        Left = 0
        Top = 0
        Width = 488
        Height = 402
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = lsbCOPDblClick
      end
      object pnOLE: TPanel
        Left = 0
        Top = 402
        Width = 488
        Height = 24
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
      end
    end
  end
  object pnPlzWait: TPanel
    Left = 96
    Top = 75
    Width = 337
    Height = 328
    BevelOuter = bvLowered
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object imgWait: TImage
      Left = 66
      Top = 66
      Width = 220
      Height = 220
    end
    object lbWait: TLabel
      Left = 27
      Top = 285
      Width = 286
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'Please wait............  Data sedang diimport'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object gauData: TGauge
      Left = 15
      Top = 12
      Width = 295
      Height = 19
      Progress = 50
    end
  end
end
