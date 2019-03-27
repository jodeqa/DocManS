object frmDMSScanADF: TfrmDMSScanADF
  Left = 685
  Top = 60
  Width = 490
  Height = 768
  Caption = 'Scan ke PDF - Auto Document Feeder Scanner'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmLogs: TMemo
    Left = 472
    Top = 0
    Width = 2
    Height = 729
    Align = alClient
    Lines.Strings = (
      'm'
      'm'
      'L'
      'o'
      'g'
      's')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 729
    Align = alLeft
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 1
    object pgc: TPageControl
      Left = 1
      Top = 1
      Width = 470
      Height = 686
      ActivePage = tbsCOP
      Align = alClient
      TabIndex = 0
      TabOrder = 0
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
            OnKeyPress = edSCOPKeyPress
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
            OnKeyPress = edSCOPKeyPress
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
            OnKeyPress = edSCOPKeyPress
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
            OnKeyPress = chbxRemindOnceKeyPress
          end
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 687
      Width = 470
      Height = 41
      Align = alBottom
      BevelInner = bvRaised
      TabOrder = 1
      object btImport: TSpeedButton
        Left = 9
        Top = 7
        Width = 112
        Height = 28
        Caption = 'Import Data'
        OnClick = btImportClick
      end
      object btScan: TSpeedButton
        Left = 232
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
  end
end
