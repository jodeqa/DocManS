object frmDMSPrint: TfrmDMSPrint
  Left = 427
  Top = 105
  Width = 771
  Height = 762
  Caption = 'Cetak Data hasil Scan'
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
  object pnv: TPanel
    Left = 0
    Top = 0
    Width = 755
    Height = 88
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object lbi: TLabel
      Left = 9
      Top = 9
      Width = 76
      Height = 16
      Caption = 'Pilih Data :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbg: TLabel
      Left = 29
      Top = 59
      Width = 93
      Height = 13
      Caption = 'Grup Dokumen :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbcr: TLabel
      Left = 41
      Top = 33
      Width = 81
      Height = 13
      Caption = 'Cari No.Kontrak :'
    end
    object btsrc: TSpeedButton
      Left = 259
      Top = 27
      Width = 28
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      OnClick = btsrcClick
    end
    object lbdp: TLabel
      Left = 687
      Top = 24
      Width = 20
      Height = 13
      Caption = 'lbdp'
      Transparent = True
      Visible = False
    end
    object cbxg: TComboBox
      Left = 128
      Top = 55
      Width = 158
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'CopyContract'
      Items.Strings = (
        'CopyContract'
        'BPKB')
    end
    object edcr: TEdit
      Left = 128
      Top = 28
      Width = 125
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edcrKeyPress
    end
  end
  object pna: TPanel
    Left = 0
    Top = 682
    Width = 755
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    DesignSize = (
      755
      41)
    object btx: TSpeedButton
      Left = 610
      Top = 6
      Width = 139
      Height = 30
      Anchors = [akRight, akBottom]
      Caption = 'S&elesai'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      Layout = blGlyphRight
      NumGlyphs = 2
      ParentFont = False
      OnClick = btxClick
    end
  end
  object flbx: TFileListBox
    Left = 0
    Top = 88
    Width = 199
    Height = 594
    Align = alLeft
    ItemHeight = 13
    Mask = '*.nothing'
    TabOrder = 2
    OnClick = flbxClick
  end
  object AcroPDF1: TAcroPDF
    Left = 199
    Top = 88
    Width = 556
    Height = 594
    Align = alClient
    TabOrder = 3
    ControlData = {000A000077390000643D0000}
  end
end
