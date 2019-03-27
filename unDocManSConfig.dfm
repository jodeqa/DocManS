object _Config: T_Config
  Left = 401
  Top = 221
  Width = 593
  Height = 325
  Caption = '_Config'
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
  object pgc: TPageControl
    Left = 0
    Top = 0
    Width = 577
    Height = 245
    ActivePage = tbsDocConfig
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object tbsLocConfig: TTabSheet
      Caption = 'Local Configuration'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 569
        Height = 217
        Align = alClient
        DataSource = dm.dsDBCfg
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tbsDocConfig: TTabSheet
      Caption = 'Document Configuration'
      ImageIndex = 1
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 569
        Height = 217
        Align = alClient
        DataSource = dm.dsDBGrp
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Width = 20
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Group'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Document'
            Width = 64
            Visible = True
          end>
      end
    end
  end
  object pnc: TPanel
    Left = 0
    Top = 245
    Width = 577
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object btExit: TSpeedButton
      Left = 474
      Top = 5
      Width = 90
      Height = 30
      Caption = '&Selesai'
      Flat = True
      OnClick = btExitClick
    end
  end
end
