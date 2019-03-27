object _UserEditor: T_UserEditor
  Left = 302
  Top = 122
  Width = 655
  Height = 699
  Caption = 'Tambah / Ubah Hak Akses Pengguna'
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
    Top = 619
    Width = 639
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 9
      Top = 6
      Width = 100
      Height = 28
      Caption = '&Hapus Akses'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 552
      Top = 6
      Width = 79
      Height = 28
      Caption = '&Selesai'
      Flat = True
      OnClick = SpeedButton2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 639
    Height = 286
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 469
      Height = 284
      Align = alClient
      BevelOuter = bvLowered
      Caption = 'Panel2'
      TabOrder = 0
      object dbgUserLIst: TDBGrid
        Left = 1
        Top = 1
        Width = 467
        Height = 282
        Align = alClient
        DataSource = dm.dsqEmp
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
        OnKeyPress = edCAKeyPress
        Columns = <
          item
            Expanded = False
            FieldName = 'employeeName'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Title.Caption = 'Nama Karyawan'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NTUserName'
            Title.Caption = 'NT User Name'
            Width = 150
            Visible = True
          end>
      end
    end
    object Panel5: TPanel
      Left = 470
      Top = 1
      Width = 168
      Height = 284
      Align = alRight
      BevelOuter = bvLowered
      Caption = 'Panel4'
      TabOrder = 1
      object clbxMenuAccess: TCheckListBox
        Left = 1
        Top = 1
        Width = 166
        Height = 241
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 20
        Items.Strings = (
          '21.ScanADF'#9
          '22.ScanFB'#9
          '31.ViewScan'#9
          '41.VerifyScan'#9
          '51.Print'#9
          '61.eMail'#9)
        ParentFont = False
        TabOrder = 0
        OnKeyPress = clbxMenuAccessKeyPress
      end
      object Panel8: TPanel
        Left = 1
        Top = 242
        Width = 166
        Height = 41
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
        object btAddUser: TSpeedButton
          Left = 8
          Top = 6
          Width = 152
          Height = 31
          Caption = '&Tambah Akses Pengguna'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          OnClick = btAddUserClick
        end
      end
    end
  end
  object Panel9: TPanel
    Left = 0
    Top = 327
    Width = 639
    Height = 292
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel9'
    TabOrder = 2
    object dbgUserLIstWithAccess: TDBGrid
      Left = 1
      Top = 42
      Width = 637
      Height = 249
      Align = alClient
      DataSource = dm.dsCA
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
          FieldName = 'NTUserName'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Caption = 'NT User Name'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ModulID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Caption = 'Kode Modul'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ModulSubID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Caption = 'Kode Sub Modul'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ModulSubName'
          Title.Caption = 'Nama Akses Menu'
          Width = 150
          Visible = True
        end>
    end
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 637
      Height = 41
      Align = alTop
      TabOrder = 1
      object Label2: TLabel
        Left = 9
        Top = 15
        Width = 18
        Height = 13
        Caption = 'Cari'
      end
      object edU: TEdit
        Left = 39
        Top = 11
        Width = 175
        Height = 21
        TabOrder = 0
        OnChange = edUChange
      end
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 639
    Height = 41
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 3
    object Label3: TLabel
      Left = 9
      Top = 15
      Width = 18
      Height = 13
      Caption = 'Cari'
    end
    object DBText1: TDBText
      Left = 222
      Top = 12
      Width = 60
      Height = 16
      AutoSize = True
      DataField = 'employeeName'
      DataSource = dm.dsqEmp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edCA: TEdit
      Left = 39
      Top = 11
      Width = 175
      Height = 21
      TabOrder = 0
      OnChange = edCAChange
      OnKeyPress = edCAKeyPress
    end
  end
end
