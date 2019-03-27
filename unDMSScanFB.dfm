object frmDMSScanFB: TfrmDMSScanFB
  Left = 206
  Top = 59
  Width = 490
  Height = 768
  Caption = 'Scan ke PDF - FlatBed Scanner'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 729
    Align = alLeft
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 687
      Width = 470
      Height = 41
      Align = alBottom
      BevelInner = bvRaised
      TabOrder = 0
      object btImport: TSpeedButton
        Left = 9
        Top = 7
        Width = 112
        Height = 28
        Caption = 'Import Data'
        OnClick = btImportClick
      end
      object btScan: TSpeedButton
        Left = 233
        Top = 7
        Width = 112
        Height = 28
        Caption = '&Mulai Scan'
        OnClick = btScanClick
      end
      object btExit: TSpeedButton
        Left = 354
        Top = 6
        Width = 112
        Height = 28
        Caption = '&Selesai'
        OnClick = btExitClick
      end
      object btAll: TSpeedButton
        Left = 121
        Top = 7
        Width = 112
        Height = 28
        Caption = '&Pilih Semua'
        OnClick = btAllClick
      end
    end
    object pgc: TPageControl
      Left = 1
      Top = 1
      Width = 470
      Height = 686
      ActivePage = tbsOther
      Align = alClient
      TabIndex = 3
      TabOrder = 1
      OnChange = pgcChange
      object tbsCOP: TTabSheet
        Tag = 1
        Caption = 'Commence Contract'
        object clbxCOP: TCheckListBox
          Left = 0
          Top = 28
          Width = 462
          Height = 630
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
        object pnSCOP: TPanel
          Left = 0
          Top = 0
          Width = 462
          Height = 28
          Align = alTop
          BevelOuter = bvLowered
          TabOrder = 1
          object edSCOP: TEdit
            Left = 3
            Top = 4
            Width = 457
            Height = 21
            TabOrder = 0
          end
        end
      end
      object tbsBPK: TTabSheet
        Tag = 2
        Caption = 'BPKB Acceptance'
        ImageIndex = 1
        object clbxBPK: TCheckListBox
          Left = 0
          Top = 28
          Width = 462
          Height = 630
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
        object pnSBPK: TPanel
          Left = 0
          Top = 0
          Width = 462
          Height = 28
          Align = alTop
          BevelOuter = bvLowered
          TabOrder = 1
          object edSBPK: TEdit
            Left = 3
            Top = 4
            Width = 457
            Height = 21
            TabOrder = 0
          end
        end
      end
      object tbsOLease: TTabSheet
        Tag = 3
        Caption = 'OTO Lease'
        ImageIndex = 3
        object pnSOLE: TPanel
          Left = 0
          Top = 0
          Width = 462
          Height = 28
          Align = alTop
          BevelOuter = bvLowered
          TabOrder = 0
          object edSOLE: TEdit
            Left = 3
            Top = 4
            Width = 457
            Height = 21
            TabOrder = 0
          end
        end
        object clbxOLE: TCheckListBox
          Left = 0
          Top = 28
          Width = 462
          Height = 630
          Align = alClient
          ItemHeight = 13
          TabOrder = 1
        end
      end
      object tbsOther: TTabSheet
        Tag = 4
        Caption = 'Internal Documents'
        ImageIndex = 2
        object Label1: TLabel
          Left = 12
          Top = 21
          Width = 156
          Height = 13
          Caption = 'Dokumen yang hendak di Scan :'
        end
        object Label2: TLabel
          Left = 19
          Top = 63
          Width = 83
          Height = 13
          Caption = 'Nama Dokumen :'
        end
        object cbxScanGrp: TComboBox
          Left = 174
          Top = 18
          Width = 193
          Height = 21
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'pilih salah satu'
          OnKeyPress = cbxScanGrpKeyPress
          Items.Strings = (
            'pilih salah satu')
        end
        object edScanName: TEdit
          Left = 114
          Top = 60
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'edScanName'
          OnExit = edScanNameExit
          OnKeyPress = cbxScanGrpKeyPress
        end
        object chbxIsRreminder: TCheckBox
          Left = 18
          Top = 96
          Width = 163
          Height = 17
          Caption = 'Apakah butuh reminder ?'
          TabOrder = 2
          OnClick = chbxIsRreminderClick
          OnExit = chbxIsRreminderExit
          OnKeyPress = cbxScanGrpKeyPress
        end
        object grbxReminder: TGroupBox
          Left = 18
          Top = 126
          Width = 352
          Height = 154
          Caption = 'Data Reminder'
          TabOrder = 3
          object Label3: TLabel
            Left = 23
            Top = 31
            Width = 79
            Height = 13
            Caption = 'Reminder dalam '
          end
          object Label4: TLabel
            Left = 168
            Top = 31
            Width = 26
            Height = 13
            Caption = 'bulan'
          end
          object Label5: TLabel
            Left = 25
            Top = 63
            Width = 135
            Height = 13
            Caption = 'atau reminder pada tanggal :'
          end
          object edBulan: TEdit
            Left = 104
            Top = 28
            Width = 40
            Height = 21
            TabOrder = 0
            Text = '0'
            OnExit = edBulanExit
            OnKeyPress = cbxScanGrpKeyPress
          end
          object udBulan: TUpDown
            Left = 144
            Top = 28
            Width = 16
            Height = 21
            Associate = edBulan
            Min = 0
            Max = 60
            Position = 0
            TabOrder = 1
            Wrap = False
          end
          object dtpRemindWhen: TDateTimePicker
            Left = 171
            Top = 58
            Width = 112
            Height = 21
            CalAlignment = dtaLeft
            Date = 43515.4757041898
            Time = 43515.4757041898
            DateFormat = dfShort
            DateMode = dmComboBox
            Kind = dtkDate
            ParseInput = False
            TabOrder = 2
            OnKeyPress = cbxScanGrpKeyPress
          end
          object chbxRemindOnce: TCheckBox
            Left = 27
            Top = 93
            Width = 142
            Height = 17
            Caption = 'Cukup ingatkan sekali ?'
            Checked = True
            State = cbChecked
            TabOrder = 3
            OnExit = chbxRemindOnceExit
          end
        end
      end
    end
  end
  object pnScan: TPanel
    Left = 472
    Top = 0
    Width = 2
    Height = 729
    Align = alClient
    BevelInner = bvLowered
    Caption = 'pnScan'
    Enabled = False
    TabOrder = 1
    object ContainImage: TScrollBox
      Left = 2
      Top = 72
      Width = 964
      Height = 614
      Align = alClient
      TabOrder = 0
      object ImageResult: TImage
        Left = 7
        Top = 7
        Width = 105
        Height = 105
        AutoSize = True
      end
    end
    object pnv: TPanel
      Left = 2
      Top = 2
      Width = 964
      Height = 70
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 1
      object lbi: TLabel
        Left = 9
        Top = 9
        Width = 81
        Height = 16
        Caption = 'Scan Data :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbno: TLabel
        Left = 38
        Top = 33
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = 'No kontrak :'
      end
      object lbnm: TLabel
        Left = 32
        Top = 49
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'Nama BPKB :'
      end
      object SpeedButton1: TSpeedButton
        Left = 501
        Top = 6
        Width = 23
        Height = 22
        Caption = 'X'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbtno: TLabel
        Left = 105
        Top = 34
        Width = 33
        Height = 13
        Caption = 'dbtno'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbtnm: TLabel
        Left = 105
        Top = 49
        Width = 35
        Height = 13
        Caption = 'dbtnm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object chbxa: TCheckBox
        Left = 453
        Top = 42
        Width = 67
        Height = 17
        Caption = 'AutoFit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = chbxaClick
      end
    end
    object pna: TPanel
      Left = 2
      Top = 686
      Width = 964
      Height = 41
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 2
      DesignSize = (
        964
        41)
      object btsc: TSpeedButton
        Left = 8
        Top = 6
        Width = 89
        Height = 30
        Caption = '&Scan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          C20A0000424DC20A0000000000003600000028000000210000001B0000000100
          1800000000008C0A000000000000000000000000000000000000D8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9EC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99
          A8AC99A8AC99A8AC99A8AC99A8AC000000000000D8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9EC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC
          99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC000000D8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9EC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8
          AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC00
          0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8AC99A8AC
          99A8AC99A8AC000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8AC99A8AC99A8AC99A8AC
          99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8ACD8E9
          EC99A8AC99A8AC99A8AC99A8AC000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8
          ACD8E9ECD8E9ECFFFF00D8E9ECD8E9ECFFFF00D8E9ECD8E9ECFFFF00D8E9EC99
          A8AC000000D8E9EC99A8AC99A8AC99A8AC99A8AC000000D8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99
          A8ACD8E9EC99A8ACD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECFFFF00D8E9EC
          FFFF00FFFF0099A8AC00000099A8AC99A8AC99A8AC99A8AC99A8AC000000D8E9
          ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9EC99A8AC99A8ACD8E9ECD8E9ECD8E9ECD8E9ECFFFF00FFFF
          00D8E9ECFFFF00FFFF00D8E9ECFFFF00000000D8E9EC99A8AC99A8AC99A8AC00
          0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8ACD8E9ECD8E9ECFFFF00D8
          E9ECD8E9ECFFFF00D8E9ECD8E9ECFFFF00D8E9EC99A8AC000000D8E9EC99A8AC
          99A8AC000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8ACD8E9EC99A8ACFFFF00
          D8E9ECFFFF00FFFF00D8E9ECFFFF00FFFF00D8E9ECFFFF00FFFF0099A8AC0000
          0099A8AC99A8AC000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8
          AC00000000000000000000000000000000000000000000000000000000000000
          0000000000000000D8E9EC000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9EC99A8AC99A8ACD8E9EC99A8AC99A8ACD8E9EC99A8AC99A8ACD8E9EC99A8AC
          99A8ACD8E9EC99A8AC99A8ACD8E9EC000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
          EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9EC99A8ACD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8ACD8E9ECD8E9EC99A8
          ACD8E9ECD8E9EC99A8ACD8E9ECD8E9EC000000D8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC99A8ACD8E9ECD8E9EC99A8ACD8
          E9EC99A8ACD8E9ECD8E9EC99A8ACD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9EC99A8ACD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9EC99A8ACD8E9EC99A8AC99A8ACD8E9EC000000D8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9EC99A8ACD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9EC99A8ACD8E9EC99A8ACD8E9ECD8E9EC000000D8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9EC00}
        ParentFont = False
        OnClick = btscClick
      end
      object btpdf: TSpeedButton
        Left = 251
        Top = 6
        Width = 125
        Height = 30
        Caption = 'Simpan P&DF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          12090000424D120900000000000036000000280000001C0000001B0000000100
          180000000000DC08000000000000000000000000000000000000D8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000D8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9EC000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FFFFFF000000
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9EC000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000FFFFFF00
          0000FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9EC000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000D8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFF000000FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFF
          FF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9EC000000FFFFFF0000FF0000FFFFFFFFFFFFFF99A8ACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000D8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000FFFFFF0000FF00
          00FFFFFFFFFFFFFFFFFFFFFFFFFF99A8ACFFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFF000000FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9EC000000FFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FF0000FFFFFFFF000000FFFFFF000000FFFFFF000000
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000
          00FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FFFFFFFF000000FFFFFF000000FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000FFFFFF99A8ACFFFFFFFFFF
          FF0000FFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF00
          0000FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9EC000000FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000D8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000FFFFFF
          FFFFFF99A8ACFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFF99A8ACFFFFFFFFFF
          FF000000FFFFFF000000FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000FFFFFFFFFFFFFFFFFFFFFFFF0000FF
          FFFFFFFFFFFF99A8ACFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFF
          FF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9EC000000FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF000000FFFFFF000000000000000000D8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000FFFFFFFFFFFFFF
          FFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9EC000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000D8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000D8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC}
        ParentFont = False
        OnClick = btpdfClick
      end
      object btd: TSpeedButton
        Left = 98
        Top = 6
        Width = 75
        Height = 30
        Caption = '&Hapus'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333333333333333333FFF33FF333FFF339993370733
          999333777FF37FF377733339993000399933333777F777F77733333399970799
          93333333777F7377733333333999399933333333377737773333333333990993
          3333333333737F73333333333331013333333333333777FF3333333333910193
          333333333337773FF3333333399000993333333337377737FF33333399900099
          93333333773777377FF333399930003999333337773777F777FF339993370733
          9993337773337333777333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        OnClick = btdClick
      end
      object btr: TSpeedButton
        Left = 173
        Top = 6
        Width = 75
        Height = 30
        Anchors = [akLeft, akBottom]
        Caption = '&Putar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF33339993707399933333773337F3777FF3399933000339
          9933377333777F3377F3399333707333993337733337333337FF993333333333
          399377F33333F333377F993333303333399377F33337FF333373993333707333
          333377F333777F333333993333101333333377F333777F3FFFFF993333000399
          999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
          99933773FF777F3F777F339993707399999333773F373F77777F333999999999
          3393333777333777337333333999993333333333377777333333}
        NumGlyphs = 2
        ParentFont = False
        OnClick = btrClick
      end
    end
  end
  object twain: TDelphiTwain
    OnTwainAcquire = twainTwainAcquire
    OnSourceSetupFileXfer = twainSourceSetupFileXfer
    OnSourceFileTransfer = twainSourceFileTransfer
    TransferMode = ttmMemory
    SourceCount = 0
    Info.MajorVersion = 1
    Info.MinorVersion = 0
    Info.Language = tlUserLocale
    Info.CountryCode = 1
    Info.Groups = [tgControl, tgImage]
    Info.VersionInfo = 'Application name'
    Info.Manufacturer = 'Application manufacturer'
    Info.ProductFamily = 'App product family'
    Info.ProductName = 'App product name'
    LibraryLoaded = False
    SourceManagerLoaded = False
    Left = 300
    Top = 124
  end
end
